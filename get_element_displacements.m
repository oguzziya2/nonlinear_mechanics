function [E_soln_u] = get_element_displacements(element_iterator)

global n_en_u
global n_ee_u
global IEN
global LM
global BC
global G_soln
global dim

E_soln_u=zeros(n_ee_u,1);

for i=1:n_en_u %local node iterator
    for j=1:dim %dof iterator
        
        E_soln_index = (i-1)*dim+j; 
        global_eqn_index  = LM(j,i,element_iterator);
        
        if (global_eqn_index~=0)
            E_soln_u(E_soln_index) = G_soln(global_eqn_index);
            
        elseif (global_eqn_index==0)
            global_node_num=IEN(i, element_iterator);
            E_soln_u(E_soln_index) = BC(global_node_num,j);
            
        else
            error('coulnt find solution value for this elemnt node')
        end
    end
end

end

