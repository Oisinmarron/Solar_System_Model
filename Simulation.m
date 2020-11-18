function Simulation(scenario, step, N, Storage)
% Simulation(scenario, step, N, Storage) 
% Function simulates 3 different scenarios. 1) The three body system
% consisting of the sun, moon and earth. 2) The ISS added to scenario 1 and
% zoomed into the Earth. 3) The phases of the Moon
% Input: scenario = which of the three simulation scenario's we are
% simulating
% Input: N = Number of steps to be simulated
% Input: step = Time step in days
% Input: Storage = Runge Kutta Storage matrix
%--------------------------------------------------------------------------
% Version 1: created 12/04/2019. Authors: James Doogan, Oisín Marron,
% Teresa Connell, UCD
%--------------------------------------------------------------------------
% This MATLAB function M-file is not flexible.

AU = 149597870.700; %Astronomical Unit in kilometres
RS = 695700/AU;     %Radius of Sun in terms of AU
Rmoon = 2439.7/AU;  %Radius of Moon in terms of AU
Rearth = 6371/AU;   %Radius of Earth in terms of AU
Riss = 0.109/AU;    %Radius of ISS in terms of AU

ScaleSun = 25;              % Scaling factor for Sun's radius
ScaleMoon = 1800;           % Scaling factor for Moon's radius
ScaleEarth = 1800;          % Scaling factor for Earth's radius
ScaleIss = 3000000;         % Scaling factor for ISS's radius

RSs = RS*ScaleSun; 
NRmoon = Rmoon*ScaleMoon;
NRearth = Rearth*ScaleEarth;
NRiss = Riss*ScaleIss;
   
S_im = imread('Sun.jpg');   % Reading in Sun's image data
Moon_im = imread('Moon.jpg'); % Reading in Moons's image data
Earth_im = imread('Earth.jpg');   % Reading in Earth's image data
stars = imread('stars.jpg');% Reading in background image data

% Set the positions of the bodies
PosSun = [Storage((1:3),(1:N))];
PosEa  = [Storage((4:6),(1:N))];
PosMoon = [Storage((7:9),(1:N))];
PosIss = [Storage((10:12),(1:N))];

%--------------------------------------------------------------------------
[x,y,z] = sphere(100); % generate points on sphere
axis([-4 4 -4 4 -4 4]) %Defines the axis constraints

hold on

% THREE BODY 
if scenario == 1
    % Create surfaces for each body for the given position of N. Position
    % of Moon is scaled by 80 times the distance between the Earth and Moon
    Sun = surf((x*RSs)+PosSun(1,N),(y*RSs)+PosSun(2,N), (z*RSs)+PosSun(3,N)); 
    Moon = surf((x*NRmoon)+PosMoon(1,N)+(80*(PosEa(1,N)-PosMoon(1,N))),(y*NRmoon)+PosMoon(2,N)+(80*(PosEa(2,N)-PosMoon(2,N))), (z*NRmoon)+PosMoon(3,N)+(80*(PosEa(3,N)-PosMoon(3,N))));
    Ea = surf((x*NRearth)+(PosEa(1,N)),(y*NRearth)+(PosEa(2,N)), (z*NRearth)+(PosEa(3,N)));
    
    % Wrapping textures around surfaces
    set(Sun,'facecolor','texturemap','cdata',S_im,'edgecolor','none'); 
    set(Moon,'facecolor','texturemap','cdata',Moon_im,'edgecolor','none');  
    set(Ea,'facecolor','texturemap','cdata',Earth_im,'edgecolor','none'); 
    
    %Creating traces for each body
    plot3(PosSun(1,:), PosSun(2,:),PosSun(3,:))
    plot3(PosEa(1,:), PosEa(2,:),PosEa(3,:), "b")
    plot3(PosMoon(1,:)+(80*(PosEa(1,:)-PosMoon(1,:))), PosMoon(2,:)+(80*(PosEa(2,:)-PosMoon(2,:))), PosMoon(3,:)+(80*(PosEa(3,:)-PosMoon(3,:))), "w");
    
    % Getting camera angles and setting camera angle
    Zoom=8;
    cva = get(gca,'CameraViewAngle');
    set(gca,'CameraViewAngle',cva/Zoom)
    
    % Creating a surface slightly below the planets to replicate a starry
    % background
    [Xm,Ym] = meshgrid(-3:0.01:3);
    Zm = zeros(size(Xm, 1))-0.1; 
    Stars = surf(Xm, Ym, Zm);
    set(Stars,'facecolor','texturemap','cdata',stars,'edgecolor','none');
    set(gca,'color','k')
    
    material dull % Reduce reflectivity of planets so they are more realistic
    
    % Reduce brightness of bodies so suns light shining on then is clear
    set(Sun, 'AmbientStrength',1);
    set(Moon,'AmbientStrength',0.3);
    set(Ea,'AmbientStrength',0.5);
    
    % Set sun as the light source
    light('Style','local','Position',[PosSun(1,1) PosSun(2,1) PosSun(3,1)]);

% ISS ORBIT
elseif scenario == 2
    
    % Create surfaces for each body for the given position of N. Position
    % of Moon is scaled by 80 times the distance between the Earth and Moon
    Ea = surf((x*NRearth)+(PosEa(1,N)),(y*NRearth)+(PosEa(2,N)), (z*NRearth)+(PosEa(3,N)));
    Iss = surf((x*NRiss)+PosIss(1,N)+(2400*(PosEa(1,N)-PosIss(1,N))),(y*NRiss)+PosIss(2,N)+(2400*(PosEa(2,N)-PosIss(2,N))), (z*NRiss)+PosIss(3,N)+(2400*(PosEa(3,N)-PosIss(3,N))));
    Moon = surf((x*NRmoon)+PosMoon(1,N)+(60*(PosEa(1,N)-PosMoon(1,N))),(y*NRmoon)+PosMoon(2,N)+(60*(PosEa(2,N)-PosMoon(2,N))), (z*NRmoon)+PosMoon(3,N)+(60*(PosEa(3,N)-PosMoon(3,N))));
    
    % Wrapping textures around surfaces
    set(Ea,'facecolor','texturemap','cdata',Earth_im,'edgecolor','none'); 
    set(Iss,'facecolor','w','edgecolor','none');
    set(Moon,'facecolor','texturemap','cdata',Moon_im,'edgecolor','none');  
    
    %Creating traces for each body
    plot3(PosEa(1,:), PosEa(2,:),PosEa(3,:), "b")
    plot3(PosIss(1,:)+(2400*(PosEa(1,:)-PosIss(1,:))), PosIss(2,:)+(2400*(PosEa(2,:)-PosIss(2,:))), PosIss(3,:)+(2400*(PosEa(3,:)-PosIss(3,:))), "c");
    
    % Rotating Earth around its axis of rotation, once per day
    rotate(Ea, [0 0 1],(360*N*step),PosEa);

    % Creating a surface slightly below the planets to replicate a starry
    % background    
    [Xm,Ym] = meshgrid(-3:0.01:3);
    Zm = zeros(size(Xm, 1))-0.1; 
    Stars = surf(Xm, Ym, Zm);
    set(Stars,'facecolor','texturemap','cdata',stars,'edgecolor','none');
    set(gca,'color','k')
    
    camlookat(Ea); % Zooming into Earth
    
    material dull  % Reduce reflectivity of planets so they are more realistic
    
    % Reduce brightness of bodies so suns light shining on then is clear
    set(Moon,'AmbientStrength',0.4);
    set(Ea,'AmbientStrength',0.5);
    set(Iss,'AmbientStrength',0.3);
    
    % Set sun as the light source
    light('Style','local','Position',[PosSun(1,1) PosSun(2,1) PosSun(3,1)]);

% LUNAR ORBIT
elseif scenario == 3
    
    % Create surfaces for each body for the given position of N. Position
    % of Moon is scaled by 80 times the distance between the Earth and Moon
    Sun = surf((x*RSs)+PosSun(1,N),(y*RSs)+PosSun(2,N), (z*RSs)+PosSun(3,N)); 
    Moon = surf((x*NRmoon)+PosMoon(1,N)+(60*(PosEa(1,N)-PosMoon(1,N))),(y*NRmoon)+PosMoon(2,N)+(60*(PosEa(2,N)-PosMoon(2,N))), (z*NRmoon)+PosMoon(3,N)+(60*(PosEa(3,N)-PosMoon(3,N))));
    Ea = surf((x*NRearth)+(PosEa(1,N)),(y*NRearth)+(PosEa(2,N)), (z*NRearth)+(PosEa(3,N)));
    
    % Rotate Moon about its axis of rotation once every 27.3 days 
    rotate(Moon, [0 0 1],((360*N*step)/(27.3)),PosMoon);
    
    % Wrapping textures around surfaces
    set(Sun,'facecolor','texturemap','cdata',S_im,'edgecolor','none'); 
    set(Moon,'facecolor','texturemap','cdata',Moon_im,'edgecolor','none');  
    set(Ea,'facecolor','texturemap','cdata',Earth_im,'edgecolor','none','FaceAlpha',0); 
    
    % Creating a surface slightly below the planets to replicate a starry
    % background
    [Xm,Ym] = meshgrid(-3:0.01:3);
    Zm = zeros(size(Xm, 1))-0.1; 
    Stars = surf(Xm, Ym, Zm);
    set(Stars,'facecolor','texturemap','cdata',stars,'edgecolor','none');
    set(gcf,'color','k')
    
    material dull % Reduce reflectivity of planets so they are more realistic
    
    % Reduce brightness of bodies so suns light shining on then is clear
    set(Sun, 'AmbientStrength',1);
    set(Moon,'AmbientStrength',0.3);
    set(Ea,'AmbientStrength',0.5);
    
    % Set sun as the light source
    light('Style','local','Position',[PosSun(1,1) PosSun(2,1) PosSun(3,1)]);
    
    axis vis3d off
    
    % Position Camera in the Earth and point it towards current position of
    % moon
    campos([PosEa(1,N),PosEa(2,N),PosEa(3,N)]);
    camtarget([PosMoon(1,N),PosMoon(2,N),PosMoon(3,N)]);
    camlookat(Moon)
    
else   
    
end
end