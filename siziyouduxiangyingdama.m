clc 
clear all;
close all; 
format short
ms=1815;%mass-kg
I=1910;%The moment of inertia of the car around the center of mass-kg*m^2
muf=51.5;%Front axle mass-kg
mur=49.5;%Rear axle mass-kg
kf=17500;%Front suspension stiffness-N/m
kr=22500;%Rear suspension stiffnessN/m
ktf=322340;%Front tire stiffness-N/m
ktr=493000;%Rear tire stiffness-N/m
cf=1450;%Front suspension damping-N*s*m^-1
cr=1450;%Rear suspension damping-N*s*m^-1
a=1.26;%Distance from front axle to center of mass-m
b=1.53;%Distance from rear axle to center of mass-m
%%%%%%the mass, damping, stiffness matrix, and tire stiffness matrix
M=diag([ms I muf mur]);
C=[cr+cf -a*cf+b*cr -cf -cr;
    -a*cf+b*cr a^2*cf+b^2*cr a*cf -b*cr;
    -cf a*cf cf 0;
    -cr -b*cr 0 cr];
K=[kf+kr -a*kf+b*kr -kf -kr;
    -a*kf+b*kr a^2*kf+b^2*kr a*kf -b*kr;
    -kf a*kf kf+ktf 0;
    -kr -b*kr 0 kr+ktr];
Kt=[0 0;0 0;ktf 0;0 ktr];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Q, D]=eig(inv(M)*K);

syms w
h1=(-w^2).*M+(1i*w)*C+K;
h2=Kt;
G=inv(h1)*h2;%%%%%%transfer function
G(1,1);%Transfer function of body vertical vibration to front wheel excitation
G(1,2);%Transfer function of body vertical vibration to rear wheel excitation
G(2,1);%Transfer function of body pitch vibration to front wheel excitation
G(2,2);%Transfer function of body pitch vibration to rear wheel excitation

w1=0:0.1:30;
figure(1)
G1=subs(G(1,1),w,w1);
G2=subs(G(1,2),w,w1);
plot(w1,G1,'--',w1,G2);
grid on
xlabel('excitation frequency w/Hz');
ylabel('amplitude relations z');
title('Transfer function of body vertical vibration to (front - rear) wheel excitation');

figure(2)
G3=subs(G(2,1),w,w1);
G4=subs(G(2,2),w,w1);
plot(w1,G3,'--',w1,G4);
grid on
xlabel('excitation frequency w/Hz');
ylabel('amplitude relations z');
title('Transfer function of body pitch motion to (front-rear) wheel excitation');



