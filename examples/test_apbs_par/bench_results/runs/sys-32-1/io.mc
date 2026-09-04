##############################################################################
# MC-shell I/O capture file.
# Creation Date and Time:  Fri Sep  4 19:13:29 2026

##############################################################################
Hello world from PE 0
Vnm_tstart: starting timer 26 (APBS WALL CLOCK)..
NOsh_parseInput:  Starting file parsing...
NOsh: Parsing READ section
NOsh: Storing molecule 0 path test.pqr
NOsh: Done parsing READ section
NOsh: Done parsing READ section (nmol=1, ndiel=0, nkappa=0, ncharge=0, npot=0)
NOsh: Parsing ELEC section
NOsh_parseMG: Parsing parameters for MG calculation
NOsh_parseMG:  Parsing mol...
PBEparm_parseToken:  trying mol...
NOsh_parseMG:  Parsing dime...
PBEparm_parseToken:  trying dime...
MGparm_parseToken:  trying dime...
NOsh_parseMG:  Parsing cglen...
PBEparm_parseToken:  trying cglen...
MGparm_parseToken:  trying cglen...
NOsh_parseMG:  Parsing fglen...
PBEparm_parseToken:  trying fglen...
MGparm_parseToken:  trying fglen...
NOsh_parseMG:  Parsing fgcent...
PBEparm_parseToken:  trying fgcent...
MGparm_parseToken:  trying fgcent...
NOsh_parseMG:  Parsing cgcent...
PBEparm_parseToken:  trying cgcent...
MGparm_parseToken:  trying cgcent...
NOsh_parseMG:  Parsing temp...
PBEparm_parseToken:  trying temp...
NOsh_parseMG:  Parsing pdie...
PBEparm_parseToken:  trying pdie...
NOsh_parseMG:  Parsing sdie...
PBEparm_parseToken:  trying sdie...
NOsh_parseMG:  Parsing npbe...
PBEparm_parseToken:  trying npbe...
NOsh: parsed npbe
NOsh_parseMG:  Parsing bcfl...
PBEparm_parseToken:  trying bcfl...
NOsh_parseMG:  Parsing srfm...
PBEparm_parseToken:  trying srfm...
NOsh_parseMG:  Parsing chgm...
PBEparm_parseToken:  trying chgm...
MGparm_parseToken:  trying chgm...
NOsh_parseMG:  Parsing swin...
PBEparm_parseToken:  trying swin...
NOsh_parseMG:  Parsing srad...
PBEparm_parseToken:  trying srad...
NOsh_parseMG:  Parsing sdens...
PBEparm_parseToken:  trying sdens...
NOsh_parseMG:  Parsing ion...
PBEparm_parseToken:  trying ion...
NOsh_parseMG:  Parsing ion...
PBEparm_parseToken:  trying ion...
NOsh_parseMG:  Parsing calcforce...
PBEparm_parseToken:  trying calcforce...
NOsh_parseMG:  Parsing calcenergy...
PBEparm_parseToken:  trying calcenergy...
NOsh_parseMG:  Parsing end...
MGparm_check:  checking MGparm object of type 1.
NOsh:  nlev = 4, dime = (97, 129, 129)
NOsh: Done parsing ELEC section (nelec = 1)
Valist_readPQR: Counted 3218 atoms
Valist_getStatistics:  Max atom coordinate:  (84.9, 87.94, 54.14)
Valist_getStatistics:  Min atom coordinate:  (47.1, 36.4, 1.56)
Valist_getStatistics:  Molecule center:  (66, 62.17, 27.85)
NOsh_setupCalcMGAUTO(./src/generic/nosh.c, 1868):  coarse grid center = 66 62.17 27.85
NOsh_setupCalcMGAUTO(./src/generic/nosh.c, 1873):  fine grid center = 66 62.17 27.85
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1885):  Coarse grid spacing = 1.2625, 1.26891, 1.29328
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1887):  Fine grid spacing = 0.525, 0.501094, 0.509219
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1889):  Displacement between fine and coarse grids = 0, 0, 0
NOsh:  2 levels of focusing with 0.415842, 0.394902, 0.393742 reductions
NOsh_setupMGAUTO:  Resetting boundary flags
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1983):  starting mesh repositioning.
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1985):  coarse mesh center = 66 62.17 27.85
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1990):  coarse mesh upper corner = 126.6 143.38 110.62
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 1995):  coarse mesh lower corner = 5.4 -19.04 -54.92
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 2000):  initial fine mesh upper corner = 91.2 94.24 60.44
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 2005):  initial fine mesh lower corner = 40.8 30.1 -4.74
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 2066):  final fine mesh upper corner = 91.2 94.24 60.44
NOsh_setupCalcMGAUTO (./src/generic/nosh.c, 2071):  final fine mesh lower corner = 40.8 30.1 -4.74
NOsh_setupMGAUTO:  Resetting boundary flags
NOsh_setupCalc:  Mapping ELEC statement 0 (1) to calculation 1 (2)
Vnm_tstart: starting timer 27 (Setup timer)..
Setting up PBE object...
Vpbe_ctor2:  solute radius = 38.695
Vpbe_ctor2:  solute dimensions = 40.4 x 54.14 x 55.18
Vpbe_ctor2:  solute charge = 4.99999
Vpbe_ctor2:  bulk ionic strength = 0.15
Vpbe_ctor2:  xkappa = 0.127002
Vpbe_ctor2:  Debye length = 7.87391
Vpbe_ctor2:  zkappa2 = 1.26455
Vpbe_ctor2:  zmagic = 6999.55
Vpbe_ctor2:  Constructing Vclist with 75 x 75 x 75 table
Vclist_ctor2:  Using 75 x 75 x 75 hash table
Vclist_ctor2:  automatic domain setup.
Vclist_ctor2:  Using 2.31 max radius
Vclist_setupGrid:  Grid lengths = (49.4724, 63.2124, 64.2524)
Vclist_setupGrid:  Grid lower corner = (41.2638, 30.5638, -4.2762)
Vclist_assignAtoms:  Have 4964168 atom entries
Vacc_storeParms:  Surf. density = 10
Vacc_storeParms:  Max area = 212.272
Vacc_storeParms:  Using 2140-point reference sphere
Setting up PDE object...
Vpmp_ctor2:  Using meth = 1, mgsolv = 0
Setting PDE center to local center...
Vpmg_fillco:  filling in source term.
fillcoCharge: Calling fillcoPermanentMultipole...
fillcoPermanentMultipole:  filling in source term.
Vpmg_fillco:  marking ion and solvent accessibility.
fillcoCoef:  Calling fillcoCoefMol...
Vacc_SASA: Time elapsed: 0.347024
Vpmg_fillco:  done filling coefficient arrays
Vpmg_fillco:  filling boundary arrays
Vpmg_fillco:  done filling boundary arrays
Vnm_tstop: stopping timer 27 (Setup timer).  CPU TIME = 3.095962e+00
Vnm_tstart: starting timer 28 (Solver timer)..
Vnm_tstart: starting timer 30 (Vnewdrv2: fine problem setup)..
Vbuildops: Fine: (097, 129, 129)
Vbuildops: Operator stencil (lev, numdia) = (1, 4)
Vnm_tstop: stopping timer 30 (Vnewdrv2: fine problem setup).  CPU TIME = 1.979800e-02
Vnm_tstart: starting timer 30 (Vnewdrv2: coarse problem setup)..
Vbuildops: Galer: (049, 065, 065)
Vbuildops: Galer: (025, 033, 033)
Vbuildops: Galer: (013, 017, 017)
Vnm_tstop: stopping timer 30 (Vnewdrv2: coarse problem setup).  CPU TIME = 2.959970e-01
Vnm_tstart: starting timer 30 (Vnewdrv2: solve)..
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 3.605980e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vnewton: Damping enabled
Vnewton: Using errtol_s: 1248699.665802
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 4.191651e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 7.045899e+04
Vprtstp: contraction number = 7.045899e+04
Vnewton: Attempting damping, relres = 0.052332
Vnewton: Attempting damping, relres = 0.519285
Vnewton: Damping accepted, relres = 0.052332
Vnewton: Damping disabled
Vprtstp: iteration = 1
Vprtstp: relative residual = 5.233233e-02
Vprtstp: contraction number = 5.233233e-02
Vnewton: Using errtol_s: 65347.363855
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 5.766742e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 8.430250e+03
Vprtstp: contraction number = 8.430250e+03
Vprtstp: iteration = 2
Vprtstp: relative residual = 6.079414e-03
Vprtstp: contraction number = 1.161694e-01
Vnewton: Using errtol_s: 7591.362494
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 6.970466e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 1.230942e+03
Vprtstp: contraction number = 1.230942e+03
Vprtstp: iteration = 3
Vprtstp: relative residual = 8.872482e-04
Vprtstp: contraction number = 1.459430e-01
Vnewton: Using errtol_s: 1107.906573
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 8.595904e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 2.112298e+02
Vprtstp: contraction number = 2.112298e+02
Vprtstp: iteration = 4
Vprtstp: relative residual = 1.522451e-04
Vprtstp: contraction number = 1.715924e-01
Vnewton: Using errtol_s: 190.108363
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 9.746259e+00
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 4.158433e+01
Vprtstp: contraction number = 4.158433e+01
Vprtstp: iteration = 5
Vprtstp: relative residual = 2.997194e-05
Vprtstp: contraction number = 1.968664e-01
Vnewton: Using errtol_s: 37.425952
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.093101e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 9.062059e+00
Vprtstp: contraction number = 9.062059e+00
Vprtstp: iteration = 6
Vprtstp: relative residual = 6.531478e-06
Vprtstp: contraction number = 2.179198e-01
Vnewton: Using errtol_s: 8.155855
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.206629e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 2.115587e+00
Vprtstp: contraction number = 2.115587e+00
Vprtstp: iteration = 7
Vprtstp: relative residual = 1.524809e-06
Vprtstp: contraction number = 2.334554e-01
Vnewton: Using errtol_s: 1.904029
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.374056e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 5.236620e-01
Vprtstp: contraction number = 5.236620e-01
Vprtstp: iteration = 8
Vprtstp: relative residual = 3.774292e-07
Vprtstp: contraction number = 2.475255e-01
Vnm_tstop: stopping timer 30 (Vnewdrv2: solve).  CPU TIME = 1.114532e+01
Vnm_tstop: stopping timer 28 (Solver timer).  CPU TIME = 1.164591e+01
Vpmg_setPart:  lower corner = (5.4, -19.04, -54.92)
Vpmg_setPart:  upper corner = (126.6, 143.38, 110.62)
Vpmg_setPart:  actual minima = (5.4, -19.04, -54.92)
Vpmg_setPart:  actual maxima = (126.6, 143.38, 110.62)
Vpmg_setPart:  bflag[FRONT] = 0
Vpmg_setPart:  bflag[BACK] = 0
Vpmg_setPart:  bflag[LEFT] = 0
Vpmg_setPart:  bflag[RIGHT] = 0
Vpmg_setPart:  bflag[UP] = 0
Vpmg_setPart:  bflag[DOWN] = 0
Vnm_tstart: starting timer 29 (Energy timer)..
Vpmg_energy:  calculating full PBE energy
Vpmg_qmEnergy:  Calculating nonlinear energy
Vpmg_energy:  qmEnergy = 1.869298718229E+00 kT
Vpmg_energy:  qfEnergy = 8.231509353669E+03 kT
Vpmg_energy:  dielEnergy = 1.864952073585E+03 kT
Vpmg_qmEnergy:  Calculating nonlinear energy
Vnm_tstop: stopping timer 29 (Energy timer).  CPU TIME = 2.806900e-02
Vnm_tstart: starting timer 30 (Force timer)..
Vnm_tstop: stopping timer 30 (Force timer).  CPU TIME = 1.000000e-06
Vnm_tstart: starting timer 27 (Setup timer)..
Setting up PBE object...
Vpbe_ctor2:  solute radius = 38.695
Vpbe_ctor2:  solute dimensions = 40.4 x 54.14 x 55.18
Vpbe_ctor2:  solute charge = 4.99999
Vpbe_ctor2:  bulk ionic strength = 0.15
Vpbe_ctor2:  xkappa = 0.127002
Vpbe_ctor2:  Debye length = 7.87391
Vpbe_ctor2:  zkappa2 = 1.26455
Vpbe_ctor2:  zmagic = 6999.55
Vpbe_ctor2:  Constructing Vclist with 75 x 75 x 75 table
Vclist_ctor2:  Using 75 x 75 x 75 hash table
Vclist_ctor2:  automatic domain setup.
Vclist_ctor2:  Using 2.31 max radius
Vclist_setupGrid:  Grid lengths = (49.4724, 63.2124, 64.2524)
Vclist_setupGrid:  Grid lower corner = (41.2638, 30.5638, -4.2762)
Vclist_assignAtoms:  Have 4964168 atom entries
Vacc_storeParms:  Surf. density = 10
Vacc_storeParms:  Max area = 212.272
Vacc_storeParms:  Using 2140-point reference sphere
Setting up PDE object...
Vpmp_ctor2:  Using meth = 1, mgsolv = 0
Setting PDE center to local center...
Vpmg_ctor2:  Filling boundary with old solution!
VPMG::focusFillBound -- New mesh mins = 40.8, 30.1, -4.74
VPMG::focusFillBound -- New mesh maxs = 91.2, 94.24, 60.44
VPMG::focusFillBound -- Old mesh mins = 5.4, -19.04, -54.92
VPMG::focusFillBound -- Old mesh maxs = 126.6, 143.38, 110.62
VPMG::extEnergy:  energy flag = 2
Vpmg_setPart:  lower corner = (40.8, 30.1, -4.74)
Vpmg_setPart:  upper corner = (91.2, 94.24, 60.44)
Vpmg_setPart:  actual minima = (5.4, -19.04, -54.92)
Vpmg_setPart:  actual maxima = (126.6, 143.38, 110.62)
Vpmg_setPart:  bflag[FRONT] = 0
Vpmg_setPart:  bflag[BACK] = 0
Vpmg_setPart:  bflag[LEFT] = 0
Vpmg_setPart:  bflag[RIGHT] = 0
Vpmg_setPart:  bflag[UP] = 0
Vpmg_setPart:  bflag[DOWN] = 0
VPMG::extEnergy:   Finding extEnergy dimensions...
VPMG::extEnergy    Disj part lower corner = (40.8, 30.1, -4.74)
VPMG::extEnergy    Disj part upper corner = (91.2, 94.24, 60.44)
VPMG::extEnergy    Old lower corner = (5.4, -19.04, -54.92)
VPMG::extEnergy    Old upper corner = (126.6, 143.38, 110.62)
Vpmg_qmEnergy:  Calculating nonlinear energy
VPMG::extEnergy: extQmEnergy = 0.0873445 kT
VPMG::extEnergy: extQfEnergy = 0 kT
VPMG::extEnergy: extDiEnergy = 0.19282 kT
Vpmg_fillco:  filling in source term.
fillcoCharge: Calling fillcoPermanentMultipole...
fillcoPermanentMultipole:  filling in source term.
Vpmg_fillco:  marking ion and solvent accessibility.
fillcoCoef:  Calling fillcoCoefMol...
Vacc_SASA: Time elapsed: 0.355050
Vpmg_fillco:  done filling coefficient arrays
Vnm_tstop: stopping timer 27 (Setup timer).  CPU TIME = 1.040812e+00
Vnm_tstart: starting timer 28 (Solver timer)..
Vnm_tstart: starting timer 30 (Vnewdrv2: fine problem setup)..
Vbuildops: Fine: (097, 129, 129)
Vbuildops: Operator stencil (lev, numdia) = (1, 4)
Vnm_tstop: stopping timer 30 (Vnewdrv2: fine problem setup).  CPU TIME = 2.048200e-02
Vnm_tstart: starting timer 30 (Vnewdrv2: coarse problem setup)..
Vbuildops: Galer: (049, 065, 065)
Vbuildops: Galer: (025, 033, 033)
Vbuildops: Galer: (013, 017, 017)
Vnm_tstop: stopping timer 30 (Vnewdrv2: coarse problem setup).  CPU TIME = 5.501590e-01
Vnm_tstart: starting timer 30 (Vnewdrv2: solve)..
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.646595e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vnewton: Damping enabled
Vnewton: Using errtol_s: 4373942.868798
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.697864e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 5.621484e+05
Vprtstp: contraction number = 5.621484e+05
Vnewton: Attempting damping, relres = 0.116086
Vnewton: Attempting damping, relres = 0.555189
Vnewton: Damping accepted, relres = 0.116086
Vnewton: Damping disabled
Vprtstp: iteration = 1
Vprtstp: relative residual = 1.160856e-01
Vprtstp: contraction number = 1.160856e-01
Vnewton: Using errtol_s: 507751.630086
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 1.997020e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 7.265618e+04
Vprtstp: contraction number = 7.265618e+04
Vprtstp: iteration = 2
Vprtstp: relative residual = 1.495060e-02
Vprtstp: contraction number = 1.287895e-01
Vnewton: Using errtol_s: 65393.080834
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.244708e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 1.057768e+04
Vprtstp: contraction number = 1.057768e+04
Vprtstp: iteration = 3
Vprtstp: relative residual = 2.176518e-03
Vprtstp: contraction number = 1.455806e-01
Vnewton: Using errtol_s: 9519.964488
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.367149e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 1.683531e+03
Vprtstp: contraction number = 1.683531e+03
Vprtstp: iteration = 4
Vprtstp: relative residual = 3.464105e-04
Vprtstp: contraction number = 1.591581e-01
Vnewton: Using errtol_s: 1515.179692
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.612521e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 2.854390e+02
Vprtstp: contraction number = 2.854390e+02
Vprtstp: iteration = 5
Vprtstp: relative residual = 5.873309e-05
Vprtstp: contraction number = 1.695477e-01
Vnewton: Using errtol_s: 256.895160
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.729682e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 4.956588e+01
Vprtstp: contraction number = 4.956588e+01
Vprtstp: iteration = 6
Vprtstp: relative residual = 1.019887e-05
Vprtstp: contraction number = 1.736479e-01
Vnewton: Using errtol_s: 44.609294
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.848259e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 8.263735e+00
Vprtstp: contraction number = 8.263735e+00
Vprtstp: iteration = 7
Vprtstp: relative residual = 1.700379e-06
Vprtstp: contraction number = 1.667222e-01
Vnewton: Using errtol_s: 7.437361
Vnm_tstop: stopping timer 40 (MG iteration).  CPU TIME = 2.962490e+01
Vprtstp: iteration = 0
Vprtstp: relative residual = 1.000000e+00
Vprtstp: contraction number = 1.000000e+00
Vprtstp: iteration = 1
Vprtstp: relative residual = 1.284006e+00
Vprtstp: contraction number = 1.284006e+00
Vprtstp: iteration = 8
Vprtstp: relative residual = 2.642023e-07
Vprtstp: contraction number = 1.553785e-01
Vnm_tstop: stopping timer 30 (Vnewdrv2: solve).  CPU TIME = 1.419019e+01
Vnm_tstop: stopping timer 28 (Solver timer).  CPU TIME = 1.483330e+01
Vpmg_setPart:  lower corner = (40.8, 30.1, -4.74)
Vpmg_setPart:  upper corner = (91.2, 94.24, 60.44)
Vpmg_setPart:  actual minima = (40.8, 30.1, -4.74)
Vpmg_setPart:  actual maxima = (91.2, 94.24, 60.44)
Vpmg_setPart:  bflag[FRONT] = 0
Vpmg_setPart:  bflag[BACK] = 0
Vpmg_setPart:  bflag[LEFT] = 0
Vpmg_setPart:  bflag[RIGHT] = 0
Vpmg_setPart:  bflag[UP] = 0
Vpmg_setPart:  bflag[DOWN] = 0
Vnm_tstart: starting timer 29 (Energy timer)..
Vpmg_energy:  calculating full PBE energy
Vpmg_qmEnergy:  Calculating nonlinear energy
Vpmg_energy:  qmEnergy = 1.751089647703E+00 kT
Vpmg_energy:  qfEnergy = 1.110378228192E+05 kT
Vpmg_energy:  dielEnergy = 3.687896593934E+04 kT
Vpmg_qmEnergy:  Calculating nonlinear energy
Vnm_tstop: stopping timer 29 (Energy timer).  CPU TIME = 2.444400e-02
Vnm_tstart: starting timer 30 (Force timer)..
Vnm_tstop: stopping timer 30 (Force timer).  CPU TIME = 0.000000e+00
Vnm_tstop: stopping timer 26 (APBS WALL CLOCK).  CPU TIME = 3.070156e+01
