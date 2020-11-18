function Animation(scenario, step, N, Initial_Conditions) 
% Animation(step, N, Initial_Conditions):
% Function that creates an animated video file, demonstating how the
% respective masses move within the solar system and tracking their paths
% during this movement.
% Input N = Number of days to be animated (if step = 1).
% Input step = Fraction of N to be animated.
% Input Initial_Conditions = Coordinates and velocities of masses.
%--------------------------------------------------------------------------
% Version 1: created 12/04/2019. Authors: Oisin Marron, James Doogan and
% Teresa Connell
%--------------------------------------------------------------------------
% This MATLAB function M-file is not flexible. It only works to create a 
% video file animating the motion of the earth and moon around the sun, 
% the movement of the moon around the earth or the movement of the
% international space station around the earth, each possible animation 
% depending on the current make up of the Planet_Sim function.
% The function creates a video file: SolarSystemAnimation.avi

% Display error if less than or more than three inputs to function
if nargin<4; error ('Not enough input arguments.'); end 
if nargin>4; error ('Too many input arguments.'); end

Storage = RungeKutta(step, N, Initial_Conditions); %Uses Runge Kutta method and 
                                             %stores every coordinate value
                                             %of each mass for entire orbit. 
skip_frames = 10; % Used to animate only every 5th frame.
anim_frames = N/skip_frames; % Number of frames to include in animation. 
video = VideoWriter('SolarSystemAnimation.avi'); % Variable created to hold
                                                 % video.
open(video);
 
% Writes the each frame to animation file
for frame = 1:anim_frames  
    skipped_frame = skip_frames*frame; % Current column being used from 
                                       % Storage
    use_fig = figure(); % Opens a figure to simulate on.
    Simulation(scenario, step, skipped_frame, Storage) % Creates frame simulation for the 
                                       % figure
    writeVideo(video, getframe(use_fig)); % Adds frame to animation file 
    close(use_fig) % Closes figure
end
close(video); % Closes the animation file, finished adding frames
end


