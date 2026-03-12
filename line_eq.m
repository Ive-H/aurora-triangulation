function [X,Y,Z] = line_eq(theta,phi,psi,lambda)
% Latitude: theta
% Longitude:phi
% Azimuth:  psi
% Altitude: lambda
X = @(d)  px(theta,phi) + d * Ax(theta,phi,psi,lambda);
Y = @(d)  py(theta,phi) + d * Ay(theta,phi,psi,lambda);
Z = @(d)  pz(theta    ) + d * Az(theta,    psi,lambda);