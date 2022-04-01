function [dof,local_node, comp_idx] = eqn_to_dof (element_eqn)

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

switch element_eqn
    case 1
        dof=1; local_node=1; comp_idx=1;
    case 2
        dof=2; local_node=1; comp_idx=2;
    case 3
        dof=1; local_node=2; comp_idx=3;
    case 4
        dof=2; local_node=2; comp_idx=4;
    case 5
        dof=1; local_node=3; comp_idx=5;
    case 6
        dof=2; local_node=3; comp_idx=6;
    case 7
        dof=1; local_node=4; comp_idx=7;
    case 8
        dof=2; local_node=4; comp_idx=8;
    case 9
        dof=1; local_node=5; comp_idx=9;
    case 10
        dof=2; local_node=5; comp_idx=10;
    case 11
        dof=1; local_node=6; comp_idx=11;
    case 12
        dof=2; local_node=6; comp_idx=12;
    case 13
        dof=1; local_node=7; comp_idx=13;
    case 14
        dof=2; local_node=7; comp_idx=14;
    case 15
        dof=1; local_node=8; comp_idx=15;
    case 16
        dof=2; local_node=8; comp_idx=16;
    case 17
        dof=3; local_node=1; comp_idx=1;
    case 18
        dof=3; local_node=2; comp_idx=2;
    case 19
        dof=3; local_node=3; comp_idx=3;
    case 20
        dof=3; local_node=4; comp_idx=4;
    otherwise
        error('exceeded number of element equations')
end
end



