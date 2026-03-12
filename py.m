function surface_pt_y = py(theta,phi)
rE = 6371;
surface_pt_y= rE * cos(theta).*sin(phi);
% cos(theta) because latitude is 0 at equator, and 90 at North Pole