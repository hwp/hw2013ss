%   Introduction to Robotics
%   Assignment 1, Task 1
%
%   Solution by
%       Philipp Ruppel
%       Weipeng He
%       Luisa Zintgraf
%
% -------------------------------------------------------------------------
%
% Output:
%   vertices_13     (solution of 1.1.1)
%                   holds (columnwise) the final coordinates of
%                   the vertices A,B,C,D,E,M after rotating the
%                   pyramid in the coordinate frame M_uvw
%   vertices_23     (solution of 1.1.2)
%                   like vertices_13, but after rotations in M_xyz
%
function [vertices_13, vertices_23] = assignment1task1

    % 1.1
    % Set up the vectors representing the vertices of the Pyramid 
    
    A = [ -5 -5 0 1 ]';
    B = [ +5 -5 0 1 ]';
    C = [ +5 +5 0 1 ]';
    D = [ -5 +5 0 1 ]';
    E = [ 0 0 30 1 ]';
    M = [ 0 0 0 1 ]';    
    vertices = [ A B C D E M ];
    
    % 1.1.1
    % Rotate around M_w, M_u, M_v 
    % (in relation to the current, newly defined coordinate system)  
    % (we need 11 and 12 for the visualization)
    
    vertices_11 = rot_zw(45) * vertices;
    vertices_12 = rot_zw(45) * rot_xu(30) * vertices;
    vertices_13 = rot_zw(45) * rot_xu(30) * rot_yv(-30) * vertices;
    
    % 1.1.2
    % Rotate around M_z, M_x, M_y 
    % (in relation to the fixed coordniate system)
    % (we need 21 and 22 for the visualization)
    
    vertices_21 = rot_zw(45) * vertices;
    vertices_22 = rot_xu (30) * rot_zw(45) * vertices;
    vertices_23 = rot_yv(-30) * rot_xu (30) * rot_zw(45) * vertices;
        
    % ---------------------------------------------------------------------
    % Visualization

    figure
    axis([-15 10 -20 10 -5 31])
    title('Rotate the pyramid in relation to the current coordinate system')
    p11 = plot_pyramid(vertices,'b*-');
    p12 = plot_pyramid(vertices_11,'c--');
    p13 = plot_pyramid(vertices_12,'y--');
    p14 = plot_pyramid(vertices_13,'r*-');
    legend([p11,p12,p13,p14],'original','rot by +45° around M_w','rot by +30° around M_u', 'rot by -30° around M_v')
    
    figure
    axis([-15 10 -20 10 -5 31])
    title('Rotate the pyramid in relation to the fixed coordinate system')
    p21 = plot_pyramid(vertices,'b*-');
    p22 = plot_pyramid(vertices_21,'c--');
    p23 = plot_pyramid(vertices_22,'y--');
    p24 = plot_pyramid(vertices_23,'r*-');
    legend([p21,p22,p23,p24],'original','rot by +45° around M_z','rot by +30° around M_x', 'rot by -30° around M_y')
    
    figure
    axis([-15 10 -20 10 -5 31])
    title('Compare the two types of rotation')
    p31 = plot_pyramid(vertices,'b*-');
    p32 = plot_pyramid(vertices_13,'m*-');
    p33 = plot_pyramid(vertices_23,'r*-');
    legend([p31,p32,p33],'original','rotation in M_u_v_w', 'rotation in M_x_y_z');   
    
    % ---------------------------------------------------------------------
    % Help functions for the rotations
    
    function R_xu = rot_xu(psi)
        R_xu = [ 1   0         0          0 ;
                 0   cosd(psi) -sind(psi) 0 ;
                 0   sind(psi) cosd(psi)  0 ;
                 0   0         0          1 ];
    end

    function R_yv = rot_yv(theta)
        R_yv = [ cosd(theta)  0   sind(theta)  0 ;
                 0            1   0            0 ;
                 -sind(theta) 0   cosd(theta)  0 ;
                 0            0   0            1 ];
    end

    function R_zw = rot_zw(phi)
        R_zw = [ cosd(phi)    -sind(phi)  0   0 ;
                 sind(phi)    cosd(phi)   0   0 ;
                 0            0           1   0 ;
                 0            0           0   1 ];
    end
end