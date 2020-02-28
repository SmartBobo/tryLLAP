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
Hm = mfilt.cicdecim(16,17,4);%����CICFilter����
Distance = 0;
tic;
while toc<30
    
    audio = step(Microphone);%����Ƶ����֡����
    sin1 = step(sine);
    cos1 = step(cos);
    InPhase = audio.*sin1;
    Quard = audio.*cos1;
    %����·�ź���CICfilter����
    InPhaseFi = filter(Hm,InPhase);
    QuardFi = filter(Hm,Quard);
    InPhasePro = double(InPhaseFi);
    QuardPro = double(QuardFi);
    %����·�ź���LEVD�㷨����
    ESCInPhase = LEVD(InPhasePro);
    ESCQuard = LEVD(QuardPro);
    %��ȥ�ź��е�static vector ������·�ź�ת���baseband 
    DVInPhase = InPhasePro - ESCInPhase;
    DVQuard = QuardPro - ESCQuard;
    DVBaseband = ReImToComp(DVInPhase, DVQuard);
    % ��λ�����㲢ͨ����λ����о������
    PhDiff = phdiffmeasure(DVBaseband,cos1);
    Distance = PhDiff*340/(2*pi*175);
    % display the phase difference
    DistanceStr = num2str(Distance);
    disp(['The distance is ' DistanceStr ' centimeter']);
            
end