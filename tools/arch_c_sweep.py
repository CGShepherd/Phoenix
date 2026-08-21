from itertools import product

VZ = 24.0
VBE = 0.70
RZ = 4700.0
beta = 15.0
vpre = VZ - VBE
loads_mA = [0.0, 4.7, 8.0, 10.0]
raws = [48.0, 55.0, 60.0]

print('vraw_v,load_mA,vpre_v,rz_current_mA,base_current_mA,zener_current_mA,pass_W')
for vraw, load_mA in product(raws, loads_mA):
    iload = load_mA / 1000
    ib = iload / beta
    irz = (vraw - VZ) / RZ
    iz = irz - ib
    ppass = (vraw - vpre) * iload
    print(f'{vraw:.1f},{load_mA:.1f},{vpre:.3f},{irz*1000:.3f},{ib*1000:.3f},{iz*1000:.3f},{ppass:.4f}')
