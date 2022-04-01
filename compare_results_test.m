function  L2error= compare_results(n_quad_u)

global n_el %number of elements
global n_en_u %number of displacement element nodes
global dim  % number of spatial dimensions
global n_ee_u % number of disp eqns for one element
global IEN % element nodes matrix 
global node_coords % coordinates of the  nodes 


N_u_vec     = zeros(n_ee_u,2); %vector
integration = 0;

for element_iterator=1:n_el
    
%     E_soln_u=get_element_displacements(element_iterator);
    E_soln_u=ones(16,1);
    
    nodes_of_element= IEN (:,element_iterator);
    element_coords = node_coords(nodes_of_element,:);

    for quad_iterator_u=1:n_quad_u
        
        N_u=get_shape_fnc_vals(quad_iterator_u,n_quad_u, n_en_u);
        N_u=repelem(N_u,dim);%repeat each for x&y so that N_u is 16x1
        N_u_vec(1:2:end,1)= N_u(1:2:end);  N_u_vec(2:2:end,2)= N_u(2:2:end);
        JxW_u=get_JxW(quad_iterator_u,n_quad_u,n_en_u,element_coords);
        quad_coords_u= get_quad_point_coords(quad_iterator_u,n_quad_u, ...
            n_en_u,element_coords);
        
%         u_exact = get_exact_solution(quad_coords_u(1),quad_coords_u(2));
        u_exact= [ 1 1 ]; 
        
        ux= E_soln_u'* N_u_vec(:,1);
        uy= E_soln_u'* N_u_vec(:,2);
        
        ux_diff=ux-u_exact(1);
        uy_diff=uy-u_exact(2);
                
        integration= (ux^2+uy^2)*JxW_u +integration;
    end
end
disp('L2 norm of velocity :')
L2error=sqrt(integration)
end

