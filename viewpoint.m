% changes perspective to one of the locations (set by nr, 1=Lapua, 6=Juva)

% reset previous perspective
camva('auto')
camup('auto')
camtarget('auto')
campos('auto')
camproj('orthographic')

loc = readtable("original_locations.csv");

nr = 6;

theta_cam = rad(loc.N_deg(nr),loc.N_min(nr),loc.N_sec(nr));
phi_cam   = rad(loc.E_deg(nr),loc.E_min(nr),loc.E_sec(nr));

psi_cam   = rad(loc.p_center_deg(nr),loc.p_center_min(nr),loc.p_center_sec(nr));
lambda_cam= rad(loc.l_center_deg(nr),loc.l_center_min(nr),loc.l_center_sec(nr));

campos([px(theta_cam,phi_cam) py(theta_cam,phi_cam) pz(theta_cam)])
camtarget([px(theta_cam,phi_cam) + 200 * Ax(theta_cam,phi_cam,psi_cam,lambda_cam) ...
           py(theta_cam,phi_cam) + 200 * Ay(theta_cam,phi_cam,psi_cam,lambda_cam) ...
           pz(theta_cam        ) + 200 * Az(theta_cam    ,psi_cam,lambda_cam)])
camproj('perspective')
camzoom(loc.zoom_factor(nr))
camroll(loc.rotation(nr))