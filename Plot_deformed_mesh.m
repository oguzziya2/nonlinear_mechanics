function  Plot_deformed_mesh(scale)

global dim
global ID
global node_coords
global n_np
global BC
global G_soln

G_disp= zeros (n_np, dim);
exact_disp= zeros (n_np, dim);

for i=1:dim
    for j=1:n_np
        Disp_soln_index= ID(i,j);
        
        if (Disp_soln_index~=0) 
            G_disp(j,i) = G_soln ( Disp_soln_index);
        elseif (Disp_soln_index==0) %if index is zero,it is dirichlet boundary
            G_disp(j,i) = BC(j,i) ;
        else
            error('coulnt find solution value for this node and  dof')
        end
    end
end

Displaced_coords= node_coords + scale * G_disp ; 

for i=1:n_np
    exact_disp(i,:)=get_exact_solution(node_coords(i,1),node_coords(i,2));
end

exact_Displaced_coords= node_coords + scale * exact_disp ;


hold on 
plot(node_coords(:,1), node_coords(:,2), '*')
plot(Displaced_coords(:,1), Displaced_coords(:,2), 'ro')
plot(exact_Displaced_coords(:,1), exact_Displaced_coords(:,2), 'k+')
legend('undeformed nodes', 'deformed nodes', 'exact solution')


 end

