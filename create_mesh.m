function create_mesh(mesh_choice , renumbering_type)

global n_ed 
global n_el 
global n_en
global n_en_u
global n_en_p
global n_ee
global n_ee_u
global n_ee_p
global n_np
global LM
global IEN
global ID
global BC
global node_coords
global dim

n_ed=3;  %number of element dofs
n_en_u=8;%number of displacement element nodes
n_en_p=4;%number of pressure element nodes
n_en=max(n_en_u, n_en_p);

n_ee_u=n_en_u*dim;
n_ee_p=n_en_p;
n_ee=n_ee_u+n_ee_p; %number of element equations

switch mesh_choice
    case 1 % 2x2=4 elements, clamped sides
        create_square_mesh(2);
         
    case 2 %4x4=16 elements, clamped sides
        create_square_mesh(4);
        
    case 3 %8x8=64 elements, clamped sides
        create_square_mesh(8);
        
    case 4 %16x16=256 elements, clamped sides
        create_square_mesh(16);
        
    case 5 %32x32=1024 elements, clamped sides
        create_square_mesh(32);
        
    case 6 %case for test, clamped top and bottom 

        n_el=1;  %number of elements
        n_np=8; %number of nodal points
        
        node_coords = [ 0.00  0.50 1.00 0.00 1.00 0.00 0.50 1.00;
                        0.00  0.00 0.00 0.50 0.50 1.00 1.00 1.00 ]' ;
        
        ID = [0  0  0  3  5  0  0  0 ;
              0  0  0  4  6  0  0  0 ;
              1  0  2  0  0  7  0  0 ];
        
        IEN=[ 1 3 8 6 2 5 7 4 ]' ;
        
        BC = zeros(n_np, n_ed);
        %boundary conditions are all zero
        % to modify, enough to fill non zero boundary conditions
    case 7 %case for test, clamped left and right

        n_el=1;  %number of elements
        n_np=8; %number of nodal points
        
        node_coords = [ 0.00  0.50 1.00 0.00 1.00 0.00 0.50 1.00;
                        0.00  0.00 0.00 0.50 0.50 1.00 1.00 1.00 ]' ;
        
        ID = [0  2  0  0  0  0  6  0 ;
              0  3  0  0  0  0  7  0 ;
              1  0  4  0  0  5  0  0 ];
        
        IEN=[ 1 3 8 6 2 5 7 4 ]' ;
        
        BC = zeros(n_np, n_ed);
        %boundary conditions are all zero
        % to modify, enough to fill non zero boundary conditions
    otherwise
        error('choice of mesh is not there yet')
end


if ( exist('renumbering_type','var') ) 
    %renumber global eqns  according to  displacement and pressure comeponents
    index_map=dof_renumbering(renumbering_type);
end

LM=zeros(n_ed, n_en, n_el);
for i=1:n_ed
    for a=1:n_en
        for e=1:n_el
            LM(i,a,e)= ID(i,IEN(a,e));
        end
    end
end

end



% % 4 elements, clamped sides
%         
%         n_el=4;  %number of elements
%         n_np=21; %number of nodal points
% 
%         node_coords= [0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%                       0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%                       0.00 0.25 0.50 0.75 1.00 ; 
%                       0.00 0.00 0.00 0.00 0.00 0.25 0.25 0.25 ...
%                       0.50 0.50 0.50 0.50 0.50 0.75 0.75 0.75 ...
%                       1.00 1.00 1.00 1.00 1.00                    ]'; %!Transpose!
%                   % plot(n_coors(1,:), n_coors(2,:), '*')
%              error('check this')
%         ID=[0 0 0 0 0 0 4 0 0 7 9  12 0  0 15 0 0  0 0  0 0 ;
%             0 0 0 0 0 0 5 0 0 8 10 13 0  0 16 0 0  0 0  0 0 ;
%             1 0 2 0 3 0 0 0 6 0 11 0  14 0 0  0 17 0 18 0 19 ];
%         
%         IEN=[1  3  9  11 ;
%              3  5  11 13 ;
%              11 13 19 21 ;
%              9  11 17 19 ;
%              2  4  10 12 ;
%              7  8  15 16 ;
%              10 12 18 20 ;
%              6  7  14 15  ];
%          
%          BC= zeros(n_np, n_ed);
%          %boundary conditions are all zero
%          % to modify, enough to fill non zero boundary conditions
% 
% 
%          
%          
%          
%          %case for 1 element mesh
%         n_el=1;  %number of elements
%         n_np=8; %number of nodal points
%         
%         node_coords = [ 0.00  0.50 1.00 0.00 1.00 0.00 0.50 1.00;
%             0.00  0.00 0.00 0.50 0.50 1.00 1.00 1.00 ]' ;
%         
%         ID = [0 0 0 2 4 0 0 0 ;
%             0 0 0 3 5 0 0 0 ;
%             0 0 1 0 0 6 0 7 ];
%         
%         IEN=[ 1 3 8 6 2 5 7 4 ]' ;
%         
%         BC = zeros(n_np, n_ed);
%         %boundary conditions are all zero
%         % to modify, enough to fill non zero boundary conditions
%         
%         
%         
%         
%         
%         
%         
%         
%         
%         
%         
%         %case for 4 elements
%         
%         n_el=4;  %number of elements
%         n_np=21; %number of nodal points
%         
%         node_coords= [0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%             0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%             0.00 0.25 0.50 0.75 1.00 ;
%             0.00 0.00 0.00 0.00 0.00 0.25 0.25 0.25 ...
%             0.50 0.50 0.50 0.50 0.50 0.75 0.75 0.75 ...
%             1.00 1.00 1.00 1.00 1.00                    ]'; %!Transpose!
%         % plot(n_coors(1,:), n_coors(2,:), '*')
%         
%         ID=[0 0 0 0 0 4 6 8 10 13 15 18 20 23 25 27 0  0 0  0 0 ;
%             0 0 0 0 0 5 7 9 11 14 16 19 21 24 26 28 0  0 0  0 0 ;
%             1 0 2 0 3 0 0 0 12 0  17 0  22 0  0  0  29 0 30 0 0 ];
%         
%         IEN=[1  3  9  11 ;
%             3  5  1 13 ;
%             11 13 19 21 ;
%             9  11 17 19 ;
%             2  4  10 12 ;
%             7  8  15 16 ;
%             10 12 18 20 ;
%             6  7  14 15  ];
%         
%         BC= zeros(n_np, n_ed);
%         %boundary conditions are all zero
%         % to modify, enough to fill non zero boundary conditions
%         
%         
%         
%         
%         
%         
%         case for 4 elements
%         
%         n_el=4;  %number of elements
%         n_np=21; %number of nodal points
%         
%         node_coords= [0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%             0.00 0.25 0.50 0.75 1.00 0.00 0.50 1.00 ...
%             0.00 0.25 0.50 0.75 1.00 ;
%             0.00 0.00 0.00 0.00 0.00 0.25 0.25 0.25 ...
%             0.50 0.50 0.50 0.50 0.50 0.75 0.75 0.75 ...
%             1.00 1.00 1.00 1.00 1.00                    ]'; %!Transpose!
%         % plot(n_coors(1,:), n_coors(2,:), '*')
%         error('check this')
%         ID=[0 0 0 0 0 0 4 0 0 7 9  12 0  0 15 0 0  0 0  0 0 ;
%             0 0 0 0 0 0 5 0 0 8 10 13 0  0 16 0 0  0 0  0 0 ;
%             1 0 2 0 3 0 0 0 6 0 11 0  14 0 0  0 17 0 18 0 19 ];
%         
%         IEN=[1  3  9  11 ;
%             3  5  1 13 ;
%             11 13 19 21 ;
%             9  11 17 19 ;
%             2  4  10 12 ;
%             7  8  15 16 ;
%             10 12 18 20 ;
%             6  7  14 15  ];
%         
%         BC= zeros(n_np, n_ed);
%         %boundary conditions are all zero
%         % to modify, enough to fill non zero boundary conditions