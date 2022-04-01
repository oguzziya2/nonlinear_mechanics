function [element_eqn] = dof_to_eqn (dof,local_node)

% Q2Q1 8 node velocity- 4 node pressure element.
%      dofs:(u1,u2,p)
%
%
%  4(7,8,20)    7(13,14)     3(5,6,19)
% o------------o------------o
% |            |            |
% |8(15,16)    |            |6(11,12)
% o------------+------------o
% |            |            |
% |1(1,2,17)   |5(9,10)     |2(3,4,18)
% o------------o------------o

switch local_node
    case 1
        switch dof
            case 1
                element_eqn=1;
            case 2
                element_eqn=2;
            case 3
                element_eqn=17;
        end
    case 2
        switch dof
            case 1
                element_eqn=3;
            case 2
                element_eqn=4;
            case 3
                element_eqn=18;
        end
    case 3
        switch dof
            case 1
                element_eqn=5;
            case 2
                element_eqn=6;
            case 3
                element_eqn=19;
        end
    case 4
        switch dof
            case 1
                element_eqn=7;
            case 2
                element_eqn=8;
            case 3
                element_eqn=20;
        end
    case 5
        switch dof
            case 1
                element_eqn=9;
            case 2
                element_eqn=10;
            otherwise
                error('exceeded number of dofs for this node')
        end
    case 6
        switch dof
            case 1
                element_eqn=11;
            case 2
                element_eqn=12;
            otherwise
                error('exceeded number of dofs for this node')
        end
    case 7
        switch dof
            case 1
                element_eqn=13;
            case 2
                element_eqn=14;
            otherwise
                error('exceeded number of dofs for this node')
        end
    case 8
        switch dof
            case 1
                element_eqn=15;
            case 2
                element_eqn=16;
            otherwise
                error('exceeded number of dofs for this node')
        end
    otherwise
        error('exceeded number of local node numbers')
end
end