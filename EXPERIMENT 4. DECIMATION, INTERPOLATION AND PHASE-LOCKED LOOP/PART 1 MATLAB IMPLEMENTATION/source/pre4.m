clear; clc; close all;
% Q3a
fs = 8000;
T = 1/fs;
t = 0:T:5;
mychirp = chirp(t,500,5,1000);
sound(mychirp,8000);

% Q3b
sound(mychirp,4000);

% Q3c
sound(mychirp,16000);

% Q3d
y = resample(mychirp,2,1);
sound(y,8000);

% Q3e
sound(y,16000);

% Q3f
y = resample(mychirp,1,2);
sound(y,4000);
