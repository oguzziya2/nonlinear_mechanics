function [dN_dxi] = get_shape_fnc_derv(quad_iterator,n_quad,element_node_number)

dN_dxi=zeros(element_node_number,2); 

N_xi= zeros(element_node_number,1);
N_nu= zeros(element_node_number,1);

[xi, nu] = get_xi_nu(quad_iterator,n_quad);

switch element_node_number
    
    case 8
        N_xi(5)= 1/2 * (-2*xi) * (1-nu);
        N_xi(6)= 1/2 * (1-nu.^2) * (1);
        N_xi(7)= 1/2 * (-2*xi) * (1+nu);
        N_xi(8)= 1/2 * (1-nu.^2) * (-1);
        
        N_xi(1)= 1/4 * (-1) * (1-nu) - 1/2 * (N_xi(5)+N_xi(8));
        N_xi(2)= 1/4 * (1) * (1-nu) - 1/2 * (N_xi(5)+N_xi(6));
        N_xi(3)= 1/4 * (1) * (1+nu) - 1/2 * (N_xi(6)+N_xi(7));
        N_xi(4)= 1/4 * (-1) * (1+nu) - 1/2 * (N_xi(7)+N_xi(8));
        
        N_nu(5)= 1/2 * (1-xi.^2) * (-1);
        N_nu(6)= 1/2 * (-2*nu) * (1+xi);
        N_nu(7)= 1/2 * (1-xi.^2) * (1);
        N_nu(8)= 1/2 * (-2*nu) * (1-xi);
        
        N_nu(1)= 1/4 * (1-xi) * (-1) - 1/2 * (N_nu(5)+N_nu(8));
        N_nu(2)= 1/4 * (1+xi) * (-1) - 1/2 * (N_nu(5)+N_nu(6));
        N_nu(3)= 1/4 * (1+xi) * (1) - 1/2 * (N_nu(6)+N_nu(7));
        N_nu(4)= 1/4 * (1-xi) * (1) - 1/2 * (N_nu(7)+N_nu(8));
        
        dN_dxi=[N_xi  N_nu];
        
    case  4
        N_xi(1)= 1/4 * (-1) * (1-nu);
        N_xi(2)= 1/4 * (1) * (1-nu);
        N_xi(3)= 1/4 * (1) * (1+nu);
        N_xi(4)= 1/4 * (-1) * (1+nu);
        
        N_nu(1)= 1/4 * (1-xi) * (-1);
        N_nu(2)= 1/4 * (1+xi) * (-1);
        N_nu(3)= 1/4 * (1+xi) * (1);
        N_nu(4)= 1/4 * (1-xi) * (1);
         
        dN_dxi=[N_xi  N_nu];

    otherwise
        error('shape function derivatives for this node numbers is not implemented')
end
        

end

