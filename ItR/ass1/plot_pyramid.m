% Plots a 3-D-Pyramid
% Input:
%   vertices    a nx6 matrix [A B C D E M] (n >= 3)
%               whereas A,B,C,D form the base of the pyramid,
%               M the middle and E the top
%   color       a string containing the color of the pyramid
%  
% Output:
%   h           a handle for any line of the pyramid 
%               (needed for the legend)
%
function [h] = plot_pyramid(vertices,style)

    hold on
    
    % plot the lines of the base
    plot3( vertices(1,1:4), vertices(2,1:4), vertices(3,1:4), style)
    plot3( vertices(1,[4,1]), vertices(2,[4,1]), vertices(3,[4,1]), style)
    
    % plot the lines connecting the edges of the base with the top
    for i = 1:4
        plot3( vertices(1,[i,5]), vertices(2,[i,5]), vertices(3,[i,5]), style)
    end
    
    % plot the line connecting the middle and the top
    h = plot3( vertices(1,[5,6]), vertices(2,[5,6]), vertices(3,[5,6]), style);

    hold off
    
end