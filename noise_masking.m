% noise masking for TMS -> method based on https://www.jneurosci.org/content/jneuro/35/43/14435.full.pdf
% read the audio file and fourier transform it
% fs is sampling rate - 48000 on iphone memos
[x, Fs] = audioread('click.m4a');
trimmedX=x(16130:25000); % trim to capture only the click sound and not the environment noise

y = fft(trimmedX,Fs);  % Compute DFT of x
Xf_mag = abs(y); % amplitude of the sound
Xf_phase = angle(y); % the phase of the sound

% Auditory targets consisted of transient fluctuations in noise volume for 
% 500 ms at a 30 Hz rate (Fig. 1B). In otherwords, the volume of the noise 
% was reduced andincreased30 times per second.
FluctMag=[ones(Fs/30,1)*max(Xf_mag); ones(Fs/30,1)*min(Xf_mag)]; 
NewMag=[];
for f=1:15
    NewMag=[NewMag;FluctMag];
end
% the phase of each resulting frequency bin is randomly shuffled
% concetanate all new shuffled samples
NewAudio=[]; Xf_phase_new=[];Xf_new=[];x_new=[]; 
for i=1:1000
Xf_phase_new=shuffle(Xf_phase);
% The phase-shuffled frequency domain data were then back-transformed to 
% the time domain using an inverse Fourier transform
Xf_new = NewMag.*exp(1i*Xf_phase_new);
x_new = real(ifft(Xf_new));
NewAudio=[NewAudio;x_new];
end

% write a new sound file
filename = 'NoisedClick.m4a';
audiowrite(filename,NewAudio,Fs);

% plot the original and the transformed audio signal
subplot(2,4,1)
plot(trimmedX)
xlabel('time'); ylabel('amplitude')
title('original sound')
subplot(2,4,2)
plot(y)
xlabel('frequency'); ylabel('magntitude')
title('fft of the sound')
subplot(2,4,3)
plot(Xf_mag)
xlabel('time'); ylabel('magntitude')
title('magnitude of the sound')
subplot(2,4,4)
plot(Xf_phase)
xlabel('time'); ylabel('angle')
title('phase of the sound')
subplot(2,4,5)
plot(NewMag)
xlabel('time'); ylabel('magntitude')
title('transformed magnitude of the sound')
subplot(2,4,6)
plot(Xf_phase_new)
xlabel('time'); ylabel('angle')
title('transformed phase of the sound')
subplot(2,4,7)
plot(Xf_new(1:length(trimmedX)))
xlabel('frequency'); ylabel('magntitude')
title('the transformed sound fft')
subplot(2,4,8)
plot(x_new(1:length(trimmedX)))
xlabel('time'); ylabel('amplitude')
title('transformed sound')





