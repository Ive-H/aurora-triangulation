function A_z = Az(theta,psi,lambda)
% coordinate transform: Azimuth, Altitute, Latitude, Longitude -> Cartesian
A_z = cos(lambda)*cos(psi)*cos(theta) ...
    + sin(lambda)         *sin(theta);