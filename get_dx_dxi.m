function [dx_dxi] = get_dx_dxi(quad_point, n_quad, element_node_number,...
    node_coordinates)

% node coordinates size = (node_number,2 ).
% it  may receive coordinates for 8  element but we use first 4 for pressure
% field calculations.


dN_dxi=get_shape_fnc_derv(quad_point, n_quad, element_node_number);

x_coordinates=node_coordinates(1:element_node_number,1);
y_coordinates=node_coordinates(1:element_node_number,2);

x_xi=dN_dxi(:,1)'*x_coordinates;
x_nu=dN_dxi(:,2)'*x_coordinates;

y_xi=dN_dxi(:,1)'*y_coordinates;
y_nu=dN_dxi(:,2)'*y_coordinates;

dx_dxi=[x_xi, x_nu ; y_xi y_nu ];

end

