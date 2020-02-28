clc;
clear;
Microphone = audioDeviceReader;
Microphone.SampleRate = 48000;
audio = Microphone;
Microphone.SamplesPerFrame = 1920;
[y,fs]= audioread('coswave17500Hz.wav');  
sound(y,fs);
sine = dsp.SineWave(1,2*pi*17500,pi,'SampleRate',48000);
sine.SamplesPerFrame = 1920;
cos = dsp.SineWave(1,2*pi*17500,pi/2,'SampleRate',48000);
cos.SamplesPerFrame = 1920;
scope = dsp.TimeScope;
scope.SampleRate = 48000;
Hm = mfilt.cicdecim(16,17,4);%设置CICFilter参数
Distance = 0;
tic;
while toc<30
    
    audio = step(Microphone);%将音频进行帧处理
    sin1 = step(sine);
    cos1 = step(cos);
    InPhase = audio.*sin1;
    Quard = audio.*cos1;
    %将两路信号用CICfilter处理
    InPhaseFi = filter(Hm,InPhase);
    QuardFi = filter(Hm,Quard);
    InPhasePro = double(InPhaseFi);
    QuardPro = double(QuardFi);
    %将两路信号用LEVD算法处理
    ESCInPhase = LEVD(InPhasePro);
    ESCQuard = LEVD(QuardPro);
    %除去信号中的static vector 并将两路信号转变成baseband 
    DVInPhase = InPhasePro - ESCInPhase;
    DVQuard = QuardPro - ESCQuard;
    DVBaseband = ReImToComp(DVInPhase, DVQuard);
    % 相位差运算并通过相位差进行距离测算
    PhDiff = phdiffmeasure(DVBaseband,cos1);
    Distance = PhDiff*340/(2*pi*175);
    % display the phase difference
    DistanceStr = num2str(Distance);
    disp(['The distance is ' DistanceStr ' centimeter']);
            
end