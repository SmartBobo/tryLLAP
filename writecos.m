clear;
close all;
clc;

Df = 1;
fs = 48000;
T = 1/fs;
N = fs/Df;
time = (N-1)*T*30;
t = 0:T:time;

coswave_fs = 17500;
vol = 1;
bd2mag_val = (db2mag(vol));
y = cos(2*pi*coswave_fs*t)*(db2mag(vol));

filename = 'coswave17500Hz.wav';
audiowrite(filename,y,fs);
info = audioinfo(filename);