// APBS PMGC newton - Newton driver for nonlinear problems
// Port of pmgc/newtond.c

use rayon::prelude::*;
use std::sync::OnceLock;

const PAR_THRESHOLD: usize = 16_384;
const DEFAULT_NEWTON_ITMAX_CAP: i32 = 20;

fn configured_itmax(requested: i32) -> i32 {
    static VALUE: OnceLock<i32> = OnceLock::new();
    *VALUE.get_or_init(|| {
        if let Ok(value) = std::env::var("APBS_RUST_NEWTON_ITMAX") {
            return value.parse::<i32>().unwrap_or(requested).max(1);
        }
        if std::env::var("APBS_RUST_OVERRIDE_ITMAX").is_ok() {
            return requested.max(1);
        }
        requested.clamp(1, DEFAULT_NEWTON_ITMAX_CAP)
    })
}

/// Newton iteration driver for nonlinear PBE
pub fn newton(
    nx: usize, ny: usize, nz: usize,
    ipc: &[i32], rpc: &[f64],
    ac: &[f64], cc: &[f64], fc: &[f64],
    u: &mut [f64],
    w1: &mut [f64], w2: &mut [f64], r: &mut [f64],
    itmax: i32, errtol: f64,
    _nlev: i32,
    _pc: &[f64], _iz: &[i32],
    nu1: i32, _nu2: i32,
    omegan: f64, _irite: i32,
) {
    let n = nx * ny * nz;
    let itmax = configured_itmax(itmax);
    let mut j_cc = vec![0.0; n];
    let mut du = vec![0.0; n];
    let mut smooth_r = vec![0.0; n];

    for _iter in 0..itmax {
        // Compute nonlinear residual: r = f - N(u)
        compute_residual(nx, ny, nz, ac, cc, fc, u, r);

        let rnorm = crate::blas::xnrm2(n, r, 0);
        if rnorm < errtol {
            return;
        }

        // Compute Jacobian: J = dN/du = A + cc * cosh(u) on the diagonal.
        // Linearize: solve J * du = r
        if n >= PAR_THRESHOLD {
            j_cc.par_iter_mut().enumerate().for_each(|(i, out)| {
                let u_val = u[i].clamp(crate::mgfas::SINH_MIN, crate::mgfas::SINH_MAX);
                *out = cc[i] * u_val.cosh();
            });
        } else {
            for i in 0..n {
                let u_val = u[i].clamp(crate::mgfas::SINH_MIN, crate::mgfas::SINH_MAX);
                // smooth()/mresid use (o_c + cc_param) as diagonal,
                // so pass only the reaction part here.
                j_cc[i] = cc[i] * u_val.cosh();
            }
        }

        // Solve with modified operator
        if n >= PAR_THRESHOLD {
            du.par_iter_mut().for_each(|v| *v = 0.0);
        } else {
            du.fill(0.0);
        }
        crate::smooth::smooth(
            nx, ny, nz, ipc, rpc,
            ac, &j_cc, r,
            &mut du, w1, w2,
            &mut smooth_r,
            ipc[0], nu1 * 5, omegan,
            1, 0,
        );

        // Update: u = u + du
        if n >= PAR_THRESHOLD {
            u.par_iter_mut().zip(&du).for_each(|(ui, dui)| *ui += *dui);
        } else {
            for i in 0..n {
                u[i] += du[i];
            }
        }
    }
}

fn compute_residual(
    nx: usize, ny: usize, nz: usize,
    ac: &[f64], cc: &[f64], fc: &[f64],
    u: &[f64], r: &mut [f64],
) {
    let n = nx * ny * nz;
    let o_c = &ac[0..n];
    let o_e = &ac[n..2 * n];
    let o_n = &ac[2 * n..3 * n];
    let u_c = &ac[3 * n..4 * n];

    // r = f - Au
    crate::blas::mresid(nx, ny, nz, &[], &[], o_c, o_e, o_n, u_c, cc, u, fc, r);

    // mresid already contributes linear +cc*u on diagonal.
    // Add only nonlinear increment cc*(sinh(u)-u).
    if n >= PAR_THRESHOLD {
        r.par_iter_mut().enumerate().for_each(|(i, ri)| {
            let u_val = u[i].clamp(crate::mgfas::SINH_MIN, crate::mgfas::SINH_MAX);
            *ri -= cc[i] * (u_val.sinh() - u_val);
        });
    } else {
        for i in 0..n {
            let u_val = u[i].clamp(crate::mgfas::SINH_MIN, crate::mgfas::SINH_MAX);
            r[i] -= cc[i] * (u_val.sinh() - u_val);
        }
    }
}
