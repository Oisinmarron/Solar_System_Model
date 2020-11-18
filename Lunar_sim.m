function Lunar_sim(N, Initial_Cond)

Storage = RungeKutta(1/4,N,Initial_Cond);

AU = 149597870.700; %km

RS = 695700/AU;
Rmo = 2439.7/AU;
Re = 6371/AU;


scaleSu = 20;

RSs = RS*scaleSu; 

%Scaling Factors of the various planets

scaleMoon = 1000;
scaleEa = 1000;

%New radii after scaling

Rmoon = Rmo*scaleMoon;
Res = Re*scaleEa;


%Reading the image texures for the sun and each planet

S_im = imread('Sun.jpg');
Mo_im = imread('Moon.jpg');
Ea_im = imread('Ea.jpg');

%------ 
%Setting the positions of the bodies and reassigning them to take the suns 
%movement into account

NPosSun = [Storage(1,:); Storage(2,:); Storage(3,:)];

NPosMoon = [Storage(7,:); Storage(8,:); Storage(9,:)];

NPosEa  = [Storage(4,:); Storage(5,:); Storage(6,:)];


NPosEa = (NPosEa + NPosSun);

NPosMoon = (NPosMoon + NPosSun);

%--------------------------------------------------------------------------

[x,y,z] = sphere(50); % generate points on sphere

axis([-4 4 -4 4 -4 4]) %Defines the axis constraints axis on

%axis equal

hold on

%Generates the planets surfaces using the position and radii shown earlier

Sun = surf((x*RSs)+NPosSun(1,N),(y*RSs)+NPosSun(2,N), (z*RSs)+NPosSun(3,N)); 

Moon = surf((x*Rmoon)+NPosMoon(1,N)+50*(NPosEa(1,N)-NPosMoon(1,N)),(y*Rmoon)+NPosMoon(2,N)+50*(NPosEa(2,N)-NPosMoon(2,N)), (z*Rmoon)+NPosMoon(3,N)+50*(NPosEa(3,N)-NPosMoon(3,N)));
Ea = surf((x*Res)+NPosEa(1,N),(y*Res)+NPosEa(2,N), (z*Res)+NPosEa(3,N),'FaceAlpha',0);



%Setting the surface texture and edgecolours of the bodies

set(Sun,'facecolor','texturemap','cdata',S_im,'edgecolor','none'); 

set(Moon,'facecolor','texturemap','cdata',Mo_im,'edgecolor','none');  

set(Ea,'facecolor','texturemap','cdata',Ea_im,'edgecolor','none'); 



%Plotting the trace of the planets

%plot3(NPosSun(1,:), NPosSun(2,:),NPosSun(3,:))

%plot3(NPosEa(1,:), NPosEa(2,:),NPosEa(3,:))

%plot3(NPosMoon(1,:)+50*(NPosEa(1,:)-NPosMoon(1,:)), NPosMoon(2,:)+50*(NPosEa(2,:)-NPosMoon(2,:)),NPosMoon(3,:)+50*(NPosEa(3,:)-NPosMoon(3,:)))


NPosMoon=[NPosMoon(1,:)+50*(NPosEa(1,:)-NPosMoon(1,:));NPosMoon(2,:)+50*(NPosEa(2,:)-NPosMoon(2,:)); NPosMoon(3,:)+50*(NPosEa(3,:)-NPosMoon(3,:))];



%Giving each planet its relative brightness

set(Sun, 'AmbientStrength',1);

set(Moon,'AmbientStrength',0.2);

set(Ea,'AmbientStrength',0.2);

light('Style','local','Position',[NPosSun(1,1) NPosSun(2,1) NPosSun(3,1)]);

%position of camera
%Zoom=10;
%cva = get(gca,'CameraViewAngle');
%set(gca,'CameraViewAngle',cva/Zoom)

%view(3)

%set(gca,'color','k')



axis vis3d off
%set(gca,'Projection','perspective')
%camva(1)
campos([NPosEa(1,N),NPosEa(2,N),NPosEa(3,N)]);
camtarget([NPosMoon(1,N),NPosMoon(2,N),NPosMoon(3,N)]);
%daspect([1 1 1])
%view(30,10)
%camproj perspective
camlookat(Moon)
end