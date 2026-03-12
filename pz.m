function surface_pt_z = pz(theta)
rE = 6371;
surface_pt_z = rE * sin(theta);
% sin(theta) because latitude is 0 at equator, and 90 at North Pole