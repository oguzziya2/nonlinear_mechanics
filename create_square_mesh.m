function create_square_mesh(n_el_x)
 
global n_el 
global n_np
global n_ed
global BC
global IEN
global ID
global node_coords


% n_el_x= 2;
n_el_y= n_el_x;
 
n_el=n_el_x*n_el_y;

n_rows= 2*n_el_y+1;
row_coords= linspace(0,1,n_rows);

for row=1:n_rows
    
    if (mod(row,2)==1)
        flag= 1; 
        n_cols=2*n_el_x+1;
    else
        flag=0;
        n_cols=n_el_x+1;
    end
       
    %create nodal coordinates
    col_coords = linspace(0,1,n_cols);
    add_n_coords= [ col_coords; repelem(row_coords(row),n_cols)];
    node_coords = [ node_coords add_n_coords];
        
    %create ID matrix from ones
    add_ID=zeros(3,n_cols);
    if (row_coords(row) == 0) || (row_coords(row) == 1)
        add_ID(3,1:2:n_cols)= 1;
    else
        add_ID(1:2,2:(end-1)) = 1;
        if(flag==1)
            add_ID(3,1:2:n_cols)= 1;
        end
    end
    ID= [ID add_ID] ;
    
    %create IEN 
    add_node_numbers=zeros(1, 2*n_el_x+1);
    if (flag==1)
        add_node_numbers(:)= 1; %1:n_cols;
    else
        add_node_numbers(1:2:end)= 1; %1:n_cols;
    end
    node_numbers(row,:) = add_node_numbers;
end 

% assign equation numbers to ID
[i,j]=find(ID) ; 
for k=1:length(j)
    ID(i(k), j(k)) = k ;
end
% ID hasn't finished yet


%assign node numbers  
[i, j]=find(node_numbers) ;
for k=1:length(j)
    node_numbers(j(k), i(k)) = k ;
end


[n_rows,n_cols]=size(node_numbers);
k=0;
for i=1:2:(n_rows-2)
    for j=1:2:(n_cols-2)
        k=k+1; %  element number counter 
        row_index=[i i    i+2  i+2  i    i+1  i+2  i+1];
        col_index=[j j+2  j+2  j    j+1  j+2  j+1  j];
        for l=1:8
            IEN(l,k)=node_numbers(row_index(l), col_index(l));
        end
    end
end

[~,n_np]=size(node_coords); %number of nodal points

BC= zeros (n_np, n_ed);

% fix Pressure to  zero at one node
ID(end,end) = 0;
BC(end,end) = 0; %indices have swithced

node_coords=node_coords'; %we need the transpose for the rest of the code. 
%fix this 
end