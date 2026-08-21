#include "generic/valist.h"
#include "maloc/maloc.h"
#include "TABIPBWrap.h"

struct ApbsRustBemOutput {
    int ok_;
    double solvation_energy_;
    double coulombic_energy_;
    double free_energy_;
};

static int apbs_rust_bem_runtime_started = 0;

enum {
    APBS_RUST_INPUT_PQR = 0,
    APBS_RUST_INPUT_PDB = 1
};

static int apbs_rust_bem_load_molecule(Valist *alist, const char *path, int input_format) {
    Vio *sock = VNULL;
    int rc = 0;

    sock = Vio_ctor("FILE", "ASC", VNULL, path, "r");
    if (sock == VNULL) {
        return 0;
    }
    if (Vio_accept(sock, 0) < 0) {
        Vio_dtor(&sock);
        return 0;
    }

    switch (input_format) {
        case APBS_RUST_INPUT_PQR:
            rc = (Valist_readPQR(alist, VNULL, sock) == VRC_SUCCESS);
            break;
        case APBS_RUST_INPUT_PDB:
            rc = (Valist_readPDB(alist, VNULL, sock) == VRC_SUCCESS);
            break;
        default:
            rc = 0;
            break;
    }

    Vio_connectFree(sock);
    Vio_bufGive(sock);
    Vio_dtor(&sock);
    return rc;
}

struct ApbsRustBemOutput ApbsRustBem_run_from_file(const char *mol_path,
                                                   int input_format,
                                                   int mesh_flag,
                                                   double mesh_density,
                                                   double mesh_probe_radius,
                                                   double phys_temp,
                                                   double phys_eps_solute,
                                                   double phys_eps_solvent,
                                                   double phys_bulk_strength,
                                                   int tree_degree,
                                                   int tree_max_per_leaf,
                                                   double tree_theta,
                                                   int output_data) {
    struct ApbsRustBemOutput out;
    struct TABIPBInput in;
    struct TABIPBOutput tabi_out;
    Valist *alist = VNULL;

    out.ok_ = 0;
    out.solvation_energy_ = 0.0;
    out.coulombic_energy_ = 0.0;
    out.free_energy_ = 0.0;

    if (mol_path == VNULL) {
        return out;
    }

    if (!apbs_rust_bem_runtime_started) {
        Vio_start();
        apbs_rust_bem_runtime_started = 1;
    }

    alist = Valist_ctor();
    if (alist == VNULL) {
        return out;
    }
    if (!apbs_rust_bem_load_molecule(alist, mol_path, input_format)) {
        Valist_dtor(&alist);
        return out;
    }

    in.mesh_flag_ = mesh_flag;
    in.mesh_density_ = mesh_density;
    in.mesh_probe_radius_ = mesh_probe_radius;
    in.phys_temp_ = phys_temp;
    in.phys_eps_solute_ = phys_eps_solute;
    in.phys_eps_solvent_ = phys_eps_solvent;
    in.phys_bulk_strength_ = phys_bulk_strength;
    in.tree_degree_ = tree_degree;
    in.tree_max_per_leaf_ = tree_max_per_leaf;
    in.tree_theta_ = tree_theta;
    in.precondition_ = 0;
    in.nonpolar_ = 0;
    in.output_data_ = output_data;

    tabi_out = runTABIPBWrapAPBS(in, alist);
    out.ok_ = 1;
    out.solvation_energy_ = tabi_out.solvation_energy_;
    out.coulombic_energy_ = tabi_out.coulombic_energy_;
    out.free_energy_ = tabi_out.free_energy_;

    Valist_dtor(&alist);
    return out;
}
