function x = closest_pt(loc, orie, i1,j1,i2,j2)
% solves: A1 x1 + A3 x3 + p1 == A2 x2 + p2 for x

% j1, j2: location indices
% i1, i2: orientation indices

I = [i1 i2];
J = [j1 j2];

p = zeros(2,3); % location vectors
A = zeros(3,3); % direction vectors

for i = 1:2
    theta = rad(loc.N_deg(J(i)),loc.N_min(J(i)),loc.N_sec(J(i)));
    phi   = rad(loc.E_deg(J(i)),loc.E_min(J(i)),loc.E_sec(J(i)));
    
    psi   = rad(orie.p_deg(I(i)),orie.p_min(I(i)),orie.p_sec(I(i)));
    lambda= rad(orie.l_deg(I(i)),orie.l_min(I(i)),orie.l_sec(I(i)));

    p(i,1) = px(theta,phi);
    p(i,2) = py(theta,phi);
    p(i,3) = pz(theta    );

    A(i,1) = Ax(theta,phi,psi,lambda);
    A(i,2) = Ay(theta,phi,psi,lambda);
    A(i,3) = Az(theta    ,psi,lambda);
end

% closest pt of 2 skew lines means: connecting line is perp to both lines
A(3,:) = cross(A(1,:),A(2,:));
matrix = zeros(3);

matrix(:,1) =  A(1,:); 
matrix(:,2) = -A(2,:); 
matrix(:,3) =  A(3,:);

b = p(2,:) - p(1,:);

[x,~] = cgs(matrix,b'); % solves: A1 x1 + A3 x3 + p1 == A2 x2 + p2
% x(1) = closest pt on line 1
% x(2) = closest pt on line 2
% x(3) = distance between the 2 lines ; length of connecting line

% X = @(d) p(1,1) + A(1,1) * x(1) + d * A(3,1);
% Y = @(d) p(1,2) + A(1,2) * x(1) + d * A(3,2);
% Z = @(d) p(1,3) + A(1,3) * x(1) + d * A(3,3);