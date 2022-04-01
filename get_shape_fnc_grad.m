function [N_grad] = get_shape_fnc_grad(quad_iterator, n_quad, ...
    element_node_number, node_coordinates)

N_derv= get_shape_fnc_derv(quad_iterator,n_quad, element_node_number);

dx_dxi= get_dx_dxi(quad_iterator, n_quad, element_node_number, node_coordinates);

dxi_dx= inv(dx_dxi);

N_grad=N_derv*dxi_dx;

end