function [E_soln_p] = get_element_pressures(element_iterator)

global n_en_p
global n_ee_p
global IEN
global LM
global BC
global G_soln

E_soln_p=zeros(n_ee_p,1);

for i=1:size(E_soln_p,1) %local node iterator
    j=3;  %dof number for pressure
    
    global_eqn_index= LM(j,i,element_iterator);
    
    if (global_eqn_index~=0)
        E_soln_p(i,1) = G_soln(global_eqn_index);
        
    elseif (global_eqn_index==0)
        global_node_num=IEN(i, element_iterator);
        E_soln_p(i,1)=BC(global_node_num,j);
        
    else
        error('coulnt find solution value for this elemnt node')
    end
    
end

end
