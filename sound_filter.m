%%change the segment2.wav to an actual audio file.
[x1,fs] = audioread('segment2.wav');
x1 = x1(:,1);
N=length(x1);
t=0:1/fs:(N-1)/fs;
subplot(5,2,1);
plot(t,x1);
title('orignial sound signal');
xlabel('t(s)');ylabel('volume');

%plot the frequey domain
subplot(5,2,2);
x2=fftshift(fft(x1));
delta_fs = fs/N;
plot(-fs/2:delta_fs:fs/2-delta_fs,abs(x2).*1/N);%FFT=DFT*N
title('original amplitude spectrum');
xlabel('Hz');ylabel('amplitude');grid on;

%ifftshift from frequency to time domain
x1_new=ifft(ifftshift(x2));
subplot(5,2,3);
plot(t,x1_new);

subplot(5,2,4);
plot(-fs/2:delta_fs:fs/2-delta_fs,atan2(imag(x2),real(x2)));
title('original phase spectrum');
original_signal_amp=mean(abs(x2));


%lowpass filter design
Fpass=2e3;Rp=1;AST=80;%passband-edge frequency is 2kHz;The passband ripple is 0.01 dB and the stopband attenuation is 80 dB.
d = fdesign.lowpass('Fp,Fst,Ap,Ast',Fpass/(fs/2), (Fpass+1000)/(fs/2), Rp, AST);
Hd = design(d, 'butter');%filter desgin

%lowpass filtering
x_lowpass=filter(Hd,x1);
x3=fftshift(fft(x_lowpass));
subplot(5,2,5);
plot(-fs/2:delta_fs:fs/2-delta_fs, abs(x3).*1/N);
title('lowpass signal frequency spectrum');
xlabel('Hz');ylabel('amplitude');grid on;

lowpassfilteredSignal=ifft(ifftshift(x3));
subplot(5,2,6);plot(t,lowpassfilteredSignal);grid on;
lowpass_signal_amp=mean(abs(x3));

%calculate the signal after filtering
true_frequency=[];
sum_seq=0;
anv_seq=0;
for i = 1:N
    frequency_actual= (i-1-N/2)*delta_fs; 
    amplitude = abs(x3(i)); 
    if amplitude > 80
         true_frequency=[true_frequency,i];
         sum_seq=sum_seq+sqrt(amplitude.*1/N);       
    end
end
anv_seq=sum_seq/N;
fprintf('sum is %.4f, anverage is %.4f\n',sum_seq,anv_seq)

%bandpass filter design
fp2 = 2e3;fp3 = 3e3;fs2 = 2e3 - 500;fs3 = 3e3 + 500;Rp = 1;AST = 80;
d_2 = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2', ...
    fs2/(fs/2), fp2/(fs/2), fp3/(fs/2), fs3/(fs/2), AST,Rp,AST);
Hd2 = design(d_2, 'butter');

x_bandpass=filter(Hd2,x1);
x_bandpass=fftshift(fft(x_bandpass));
subplot(5,2,7);
plot(-fs/2:delta_fs:fs/2-delta_fs, abs(x_bandpass).*1/N);
title('bandpass signal frequency spectrum');
xlabel('Hz');ylabel('amplitude');grid on;

bandpassfilteredSignal=ifft(ifftshift(x_bandpass));
subplot(5,2,8);plot(t,bandpassfilteredSignal);grid on;
bandpass_signal_amp=mean(abs(x_bandpass));

%highpass filter desgin
fs_hp=2000;fp_hp=3000;Rp = 1;AST = 80;
d_3=fdesign.highpass('Fst,Fp,Ast,Ap',fs_hp/(fs/2),fp_hp/(fs/2),AST,Rp);
Hd3=design(d_3,'butter');
x_highpass=filter(Hd3,x1);
x_highpass=fftshift(fft(x_highpass));
subplot(5,2,9);
plot(-fs/2:delta_fs:fs/2-delta_fs, abs(x_highpass).*1/N);
title('highpass signal frequency spectrum');
xlabel('Hz');ylabel('amplitude');grid on;

highpassfilteredSignal=ifft(ifftshift(x_highpass));
subplot(5,2,10);plot(t,highpassfilteredSignal);grid on;
highpass_signal_amp=mean(abs(x_highpass));



