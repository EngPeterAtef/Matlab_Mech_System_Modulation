%clear
close all
clear
close all
clc

% constants
K1 = 5;
K2 = 50;
K3 = 5;
F1 = 100;
F2 = 200;
M1 = 100;
M2 = 100;
%DEFINE BLOCKS
B1 = tf(1,1); %we will assume there is a unity block takes the input of the system
B2 = tf(K1,1); 
B3 = tf(K2,1); 
B4 = tf([F1,0],1); 
B5 = tf(1,[M1,0,0]); 
B6 = tf(K2,1); 
B7 = tf(K2,1); 
B8 = tf(K3,1); 
B9 = tf([F2,0],1); 
B10 = tf(1,[M1,0,0]); 
B11 = tf(K2,1);

%DEFINE SYSTEM to obtain X1/U and X2/U
BlockMat = append(B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11);
% DEFINE CONNECTIONS
connect_map =[
    2,5,0,0,0,0; ...
    3,5,0,0,0,0; ...
    4,5,0,0,0,0; ...
    5,1,11,-2,-3,-4; ...
    6,5,0,0,0,0; ...
    7,10,0,0,0,0; ...
    8,10,0,0,0,0; ...
    9,10,0,0,0,0; ...
    10,6,-7,-8,-9,0; ...
    11,10,0,0,0,0; ...
];
input_loc = 1; 
output_loc = [5,10]; %we get X1 from block 5 and X2 from block 10

sys=connect(BlockMat,connect_map,input_loc,output_loc);
% Define a transfer function
tf_sys = tf(sys);
% disp('Transfer Function2:');
% disp(tf_sys(1));
% Extract the numerator and denominator coefficients
[num1, den1] = tfdata(tf_sys(1),'v');
[num2, den2] = tfdata(tf_sys(2),'v');

disp('Numerator Coefficients:');
disp(num1);
disp('Denominator Coefficients:');
disp(den1);  
% we need to check the stability of the system before we can proceed to set the option of RiseTimeLimits
% because if the system is unstable, we will not proceed to get the T.R
% if z >1 overdamped system so we won't set the option of RiseTimeLimits but if 0< z <1 underdamped system so we will set the option of RiseTimeLimits

% Req 3:For any of the two transfer functions (i.e. X1/U) study the stability of the system. 
figure(1)
pzmap(sys);

% Req 4: If a fixed input force of 1N is applied to the system. Simulate the system under this value of 
% input force showing the response of X1, X2 also from the resulting responses calculate the steady 
% state values of these signals. 
figure(2)
p = stepplot(sys);
setoptions(p,'RiseTimeLimits' ,[0,1]);
% TODO: Compute the steady state values of the signals X1,X2

% [wn,z]=damp(sys(1));
% disp('Natural Frequency:');
% disp(wn);
% disp('Damping Ratio:');
% disp(z);


% Req 5: in report

% Req 6:Simulate the system for a desired level (Xd) of 2 m. showing the response of X2. 
H = tf(1,1);
modif = feedback(tf(num2,den2),H,-1);
opt = RespConfig;
opt.Amplitude = 2;

figure(3)
step(modif,opt);

% Req7 : For the response of X2 calculate the value of 
% the rise time, peak time, max peak, and settling time. Also calculate the value of ess. 

