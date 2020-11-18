function [vel_acc] = Accelerations(Initial_Conditions) 
% [vel_acc] = Accelerations(Initial_Conditions):
% Function that finds the acceleration of each body with respect to its
% current position, current velocity and the position of the surrounding masses.
% Input Initial_Conditions = Coordinates and velocities of masses currently.
% Output vel_acc = Initial velocities and calculated accelerations of
% masses.
%--------------------------------------------------------------------------
% Version 1: created 02/04/2019. Author: Teresa Connell, Oisin Marron and
% James Doogan
%--------------------------------------------------------------------------
% This MATLAB function M-file is not flexible. It only works to find the  
% current acceleration of the sun, earth, moon and international space
% station given their initial velocities and positions.

% Display error if less than or more than one input to function
if nargin<1; error ('Not enough input arguments.'); end 
if nargin>1; error ('Too many input arguments.'); end

M_sun = 1.988500e30;        % Mass of the sun (kg)
M_moon = 7.34767309e22;     % Mass of the moon
M_earth = 5.97237e24;       % Mass of the earth

G = 6.672e-11;              % Gravitational constant
AU = 149597870700;          % Astronomical Unit (km)
TU = 86400.0;               % Time Unit (s)

C_sun = ((G*M_sun*TU^2)/AU^3);          % C-Values of the sun
C_moon = ((G*M_moon*TU^2)/AU^3);        % C-Values of the moon
C_earth  = ((G*M_earth*TU^2)/AU^3);     % C-Values of the earth

Sun_Pos = Initial_Conditions(1:3)';       % Coordinate position of sun
Earth_Pos = Initial_Conditions(4:6)';     % Coordinate position of earth
Moon_Pos = Initial_Conditions(7:9)';      % Coordinate position of moon
Iss_Pos = Initial_Conditions(10:12)';     % Coordinate position of space station


% Three Body Formula to find accelerations of each mass
Sun_Acc = -((C_moon/(norm(Sun_Pos-Moon_Pos))^3)*(Sun_Pos-Moon_Pos)) - ((C_earth/(norm(Sun_Pos-Earth_Pos))^3)*(Sun_Pos-Earth_Pos));

Moon_Acc = -((C_sun/(norm(Moon_Pos-Sun_Pos))^3)*(Moon_Pos-Sun_Pos)) - ((C_earth/(norm(Moon_Pos-Earth_Pos))^3)*(Moon_Pos-Earth_Pos)); 

Earth_Acc = -((C_sun/(norm(Earth_Pos-Sun_Pos))^3)*(Earth_Pos-Sun_Pos)) - ((C_moon/(norm(Earth_Pos-Moon_Pos))^3)*(Earth_Pos-Moon_Pos));

Iss_Acc = -((C_earth/(norm(Iss_Pos-Earth_Pos))^3)*(Iss_Pos-Earth_Pos)) - ((C_moon/(norm(Iss_Pos-Moon_Pos))^3)*(Iss_Pos-Moon_Pos)) - ((C_sun/(norm(Iss_Pos-Sun_Pos))^3)*(Iss_Pos-Sun_Pos));


% Output storing initial velocity's and current acceleration's of each mass 
vel_acc = [Initial_Conditions(13:24);Sun_Acc(1:3)';Earth_Acc(1:3)';Moon_Acc(1:3)';Iss_Acc(1:3)'];
end