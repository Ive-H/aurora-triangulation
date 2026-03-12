function L = distance_at_110km(lambda)
% lambda (rad), angle above horizon
R = 6371; % (km) Earth radius
h = 110;  % (km) altitude

x = R/(R+h) .* cos(lambda);
beta = asin(x); % angle between 2 lines from position at altitude: pointing to Earth center ; pointing to viewing location
L = (R+h) * cos(beta + lambda) ./ cos(lambda);