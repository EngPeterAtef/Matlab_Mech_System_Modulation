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
% Extract the numerator and denominator coefficients
[num, den] = tfdata(tf_sys,'v');
disp('Numerator Coefficients:');
disp(num);
disp('Denominator Coefficients:');
disp(den);  
% we need to check the stability of the system before we can proceed to set the option of RiseTimeLimits
% because if the system is unstable, we will not proceed to get the T.R
% if z >1 overdamped system so we won't set the option of RiseTimeLimits but if 0< z <1 underdamped system so we will set the option of RiseTimeLimits

figure(1)
p = stepplot(sys);

setoptions(p,'RiseTimeLimits' ,[0,1]);
figure(2)
pzmap(sys);

[wn,z]=damp(sys);

disp([wn,z]);





