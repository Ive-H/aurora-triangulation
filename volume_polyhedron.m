function volume = volume_polyhedron(K,shape_pts)
% https://nurnberg.maths.unitn.it/centroid.pdf

% e_d = e_x || e_y || e_z

% Volume = 1/6 sum_{i=1}^{N} [ a_i . n_hat_i ]

TR = triangulation(K,shape_pts);

N_triangles = size(TR.ConnectivityList,1);

volume = 0;

for tr = 1:N_triangles
    a = TR.Points(TR.ConnectivityList(tr,1),:);
    b = TR.Points(TR.ConnectivityList(tr,2),:);
    c = TR.Points(TR.ConnectivityList(tr,3),:);
    
    n_hat = cross(b-a,c-a);
    
    volume = volume + dot(a,n_hat);
end

volume = volume/6;