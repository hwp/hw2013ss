function [] = rotationtask()

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

    function R = rot(yaw, pitch, roll)
        R = rot_zw(yaw) * rot_yv(pitch) * rot_xu(roll);
    end

    disp('90 degrees to the left');
    disp(rot(90, 0, 0));
    
    disp('90 degrees up');
    disp(rot(0, -90, 0));
    
    disp('90 degrees to the left and 90 degrees up');
    disp(rot(90, -90, 0));
    
end