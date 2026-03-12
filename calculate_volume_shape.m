function volume = calculate_volume_shape(center_pt, volume_convhull, Lapua_loc, Juva_loc, N1, N2)
% calculates the approximate volume of the shape by taking the volume of
% the polyhedron and rescaling it with the help of another polyhedron
% that is generated using a sphere of known volume

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
center_sphere = center_pt;

R = 20; % km, initial guess
[~, ~, ~, ~, rays1, dir1, ~] = pt_sphere_circle_of_intersection(center_sphere, R, Lapua_loc, N1);
[~, ~, ~, ~, rays6, dir6, ~] = pt_sphere_circle_of_intersection(center_sphere, R, Juva_loc , N2);

shape_pts_sphere = intersection_shape_rays(rays1, rays6, dir1, dir6, N1, N2);

Ks = convhull(shape_pts_sphere(:,1), shape_pts_sphere(:,2), shape_pts_sphere(:,3));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
volume_sphere_polyhedron = volume_polyhedron(Ks,shape_pts_sphere);

volume_ratio = volume_convhull/volume_sphere_polyhedron;
R = R * volume_ratio^(1/3); 
% new sphere radius, which makes a polyhedron with the same volume as the shape

volume = 4/3 * R^3;
% you could iterate multiple times to get a more accurate value for R, 
% but after only 1 rescaling, it's already within 1% accurate