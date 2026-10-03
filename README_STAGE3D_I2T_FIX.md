# Project Phoenix — Stage 3D fuse I2t closure

This pack corrects the LTspice current-squared expression from:

    I(VS)^2

to:

    I(VS)*I(VS)

Run:

    tools\run_stage3d_i2t_fix.bat

Return:

    test\results\stage3d_batch\PHX_ARCH_C_stage3d_04_fuse_i2t_fixed.log

If the resulting I2t values are consistent with the measured fault currents, use them
for final fuse coordination against the selected Littelfuse 451/453 62 mA part.
