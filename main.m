clear all
close all

%Setting x and y coordinate for the piggie

a=10;
b=100;
c=0;
d=100;

pig_x=round(a+(b-a).*rand(1));
pig_y=round(c+(d-c).*rand(1));

%Constants

g=9.81;

%inputs 
% Cheat while troubleshooting
v = 50 + 10*rand-2.5 
theta = 180*atan2(pig_y, pig_x) / pi + 10*rand-2.5

% v=input('What velocity would you like to launch your bird (in m/s)?');
% 
% theta=input('What angle would you like to launch your bird (in degress)?');

theta=pi*theta/180;

tmax=(2*v/g)*sin(theta);

xmax=tmax*v*cos(theta);

dt=tmax/100;

t=0:dt:tmax-dt;

x=(v*cos(theta)).*t;

y=(v*sin(theta)).*t-g*.5*t.^2;

% Check Limits
xy_max = [max(x) max(y)];
xypig_max = [max([x pig_x]) max([y pig_y])];
% break

vx=x/(cos(theta).*t.^2);

vy=(.5*g*t.^2+y)/(sin(theta).*t);

vfinal=sqrt(vx.^2+vy.^2);

% plot(x,y,pig_x,pig_y)

vxpig=pig_x./(t.*cos(theta));

vypig=(.5*g*t.^2+pig_y)/(sin(theta).*t);

vpig=sqrt(vxpig.^2+vypig.^2);


for i =1 :length(t)
    plot(x(i),y(i),'o','LineWidth',1,'MarkerEdgeColor','r')
    if i == length(t)
        plot(x(i),y(i),'*r', 'MarkerSize', 10, 'LineWidth', 2) % Bird splat!
    end
    axis([0,max([x,pig_x]),0,max([y,pig_y])])
    hold on
    plot(pig_x,pig_y,'-go')
    collision(i) = 0;
    if abs(y(i)-pig_y)<2 && abs(x(i)-pig_x)<2
        plot(x(i),y(i),'*g', 'MarkerSize', 40, 'LineWidth', 2) % Pig explodes!
        collision (i) = 1;
    end
    xlabel('x (m)')
    ylabel('y (m)')
    plot(xlim, [0 0], '-k')
% xylim = [xlim; ylim]
    axis equal
% axis([0,1.01*max(x),0,1.2*max(y)])
    M(i)=getframe;
    hold off
end


movie(M,2)


pig_hit = find(collision == 1)