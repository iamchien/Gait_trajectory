%% Chuong trinh giai bai toan ROBOT bang MATLAB SYMBOLIC TOOLBOX
close all; clear all; clc;
rotate3d on;

% Khai bao cac symbolic variables cung cac dieu kien cua bien
syms q1 q2 a1 a2 a3
% q1, q2 la cac bien khop 
% a1, a2, a3 la do dai cac thanh
% t : bien thoi gian

assume(a1,'real');assume(a1>0); assume(a2,'real'); assume(a2>0);
assume(a3,'real');assume(a3>0); assume(q1,'real'); assume(q2,'real');
q = [q1;q2];     % Vector cac toa do suy rong q

% Tao mo hinh Robot trong Robotics toolbox
L(1)=Link([0,1,0,0,0]); % tao mot khau cua Robot
L(2)=Link([0,0,5.2,0,0]);
L(3)=Link([0,0,4.1,0,0]);
rob=SerialLink(L); % Tao cac khau noi tiep L
% rob.plot([0 pi/2 0],'workspace',[-10 10 -10 10 0 3]);

%% Bai toan dong hoc thuan
t=linspace(0,1,100);l1=5.2;l2=4.1;
[xE,yE]=elliptical_function_improved(l1,l2);
sub_q1=zeros(1,length(t)); sub_q2=zeros(1,length(t));

for i=1:length(t)
    sub_q2(i) = acos( (xE(i)^2+yE(i)^2-l1^2-l2^2) / (2*l1*l2) );
    beta = acos( (xE(i)^2+yE(i)^2+l1^2-l2^2) / (2*l1*sqrt(xE(i)^2+yE(i)^2)) );
    sub_q1(i) = atan2(yE(i),xE(i)) - beta;
end

subplot(211)
plot(t,sub_q1)
grid on
subplot(212)
plot(t,sub_q2)
grid on

figure(2)
clf
title('Quy dao cua khau tac dong cuoi trong bai toan nguoc')
hold on
grid on
axis([-10 10 -10 10 0 3]);
pause on
rotate3d on

for i=1:length(t)
    plot(xE(i),yE(i),'.');
    plot(rob,[0, sub_q1(1,i), sub_q2(1,i)]); % Ve hinh 3D chuyen dong cua robot voi quy dao
    pause(1/500);
end