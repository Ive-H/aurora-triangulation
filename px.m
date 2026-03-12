function surface_pt_x = px(theta,phi)
rE = 6371;
surface_pt_x = rE * cos(theta).*cos(phi);
% cos(theta) because latitude is 0 at equator, and 90 at North Pole