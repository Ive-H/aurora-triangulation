# import apexpy
import aacgmv2
import datetime as dt
import numpy as np
import csv
import pandas as pd
import matplotlib.pyplot as plt

plt.close("all")

t_utc = pd.date_range("3/4/2025 21:05:33", periods=19, freq="17s")



plt.figure()

####################################################################################################################

df2 = pd.read_csv('bead2_height_theta_phi.csv')
df4 = pd.read_csv('bead4_height_theta_phi.csv')

mlat = np.zeros([19,2])
mlon = np.zeros([19,2])
mlt  = np.zeros([19,2])

print(df2.theta_pt[0])
for t in range(0,19):
    th = df2.theta_pt[t]
    ph = df2.phi_pt[t]
    h  = df2.heights[t]
    mlat[t,0], mlon[t,0], mlt[t,0] = aacgmv2.get_aacgm_coord(th, ph, h, t_utc[t])
    
    th = df4.theta_pt[t]
    ph = df4.phi_pt[t]
    h  = df4.heights[t]
    mlat[t,1], mlon[t,1], mlt[t,1] = aacgmv2.get_aacgm_coord(th, ph, h, t_utc[t])

plt.plot(mlt[:,0], mlat[:,0], label="b2-sh", color=[0,1,0]  , linestyle=':')
plt.plot(mlt[:,1], mlat[:,1], label="b4-sh", color=[0,0,1], linestyle=':')

####################################################################################################################

df = pd.read_csv('bead_pts_height_theta_phi.csv')
start_idx = [  0,  0,  0,  0,  3,  0,  2];
end_idx   = [ 19, 19,  8, 19,  9, 19, 11];
n_shapes = 7;

mlat = np.zeros([19,n_shapes])
mlon = np.zeros([19,n_shapes])
mlt  = np.zeros([19,n_shapes])

for t in range(0,19):
    for s in range(0,n_shapes):
        
        th = df[f'theta_pt_{t+1}'][s]
        ph = df[f'phi_pt_{t+1}'][s]
        h  = df[f'heights_{t+1}'][s]
        if th == 0.0:
            continue
        mlat[t,s], mlon[t,s], mlt[t,s] = aacgmv2.get_aacgm_coord(th, ph, h, t_utc[t])


clr = [[1,0,0],[0,1,0],[.8,.6,0],[0,0,1],[0,.8,.6],[.2,.2,.2],[.6,0,.8]]
for s in range(0,n_shapes):
    plt.plot(mlt[ start_idx[s]:end_idx[s] , s] , mlat[ start_idx[s]:end_idx[s] ,s], label="b"+str(s+1), color=clr[:][s])

####################################################################################################################

df = pd.read_csv('stick_pts_height_theta_phi.csv')
n_shapes = 3;

mlat = np.zeros([19,n_shapes])
mlon = np.zeros([19,n_shapes])
mlt  = np.zeros([19,n_shapes])

for t in range(0,19):
    for s in range(0,n_shapes):
        
        th = df[f'theta_pt_{t+1}'][s]
        ph = df[f'phi_pt_{t+1}'][s]
        h  = df[f'heights_{t+1}'][s]
        
        mlat[t,s], mlon[t,s], mlt[t,s] = aacgmv2.get_aacgm_coord(th, ph, h, t_utc[t])


clr = [[1,0,0],[0,1,0],[0,0,1]]

for s in range(0,n_shapes):
    plt.plot(mlt[:,s] , mlat[:,s], label="st"+str(s+1), color=clr[:][s], linestyle='--')



plt.xlabel("Magnetic Local Time (hours)")
plt.ylabel("Magnetic Latitude (°)")
plt.grid("True")
plt.xlim([22.6, 24])
plt.ylim([60, 61])
plt.legend()
plt.show()


