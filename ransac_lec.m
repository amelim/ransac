%% RANSAC microlecture
% Andrew Melim

close all
% Create data
% Eq of line ax + by + c = 0

% Parameters
a = 20;
b = 5;
c = 0;

% Data points
P = [];

for x=-15:0.5:15
  y = (a*x + c)/b;
  
  % Add small noise
  x = x+randi(13,1,1);
  y = y+randi(13,1,1);
  
  P = [P; x,y];
end

outlier = [50,0];
P = [P;outlier];

plotPoints(P);
% leastsquares(P);
RANSAC(P,3);

% Data points

