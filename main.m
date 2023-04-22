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
B1 = tf([K1],1); %block 1
B2 = tf([K2],1); %block 2
B3 = tf([F1,0],1); %block 3
B4 = tf(1,[M1,0,0]); %block 4
B5 = tf([K2],1); %block 4
B6 = tf([K2],1); %block 5
B7 = tf([K3],1); %block 6
B8 = tf([F2,0],1); %block 7
B9 = tf(1,[M1,0,0]); %block 8
B10 = tf([K2],1); %block 10

%DEFINE SYSTEM to obtain X1/U
BlockMat = append(B1,B2,B3,B4,B5,B6,B7,B8,B9,B10);
connect_ma =[ 
];
input_loc = 0; %??????????????
Output_loc = 0; %?????????????

sys=connect(BlockMat,connect_map,input_loc,output_loc);

[wn,z]=damp(sys);

disp([wn,z]);

p = stepplot(sys);
setoptions(p,'RiseTimeLimits' ,[0,1]);

pzmap(sys);





