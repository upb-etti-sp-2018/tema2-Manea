%Numar de ordine: 12
%Semnal triunghiular 


%Date initiale 
%Perioada T= 40 s
%Durata semnalelor D = 12
%Rezolutie temporara adecvata
%Numar de coeficienti N = 50


T = 40;
D = 12;
N = 50;
w0 = 2*pi/T; %pulsatia unghiulara a semnalului
t_tri = 0:0.002:D;  %esantionarea semnalului original 
x_tri = sawtooth(2*pi*(1/T)*t_tri,D/T)/2+1/2;  %semnalul triunghiular original
t_m = 0:0.002:T;  %esantionarea semnalului modificat
x_m = zeros(1,length(t_m)); %initializare a semnalului modificat cu valori nule
x_m(t_m<=D) = x_tri;  %modifica valorile nule cu valori din semnalul original 

figure(1);
plot(t_m,x_m),title('Semnalul x(t)'); %afisare x(t)
hold on;


for j = -N:N   %j este variabila dupa care se realizeaza suma
x_t = x_tri;
x_t = x_t .* exp(-1i*j*w0*t_tri);
X(j+N+1)=0 ; %initializare cu 0
 for i = 1:length(t_tri)-1
        X(j+N+1) = X(j+N+1) + (t_tri(i+1)-t_tri(i)) * (x_t(i)+x_t(i+1))/2;
    end
end

for i = 1:length(t_m) 
    x_finit(i) = 0;
    for j=-N:N
        x_finit(i) = x_finit(i) + (1/T) * X(j+N+1) * exp(1i*j*w0*t_m(i));
    end
end
plot(t_m,x_finit,'--'); 

figure(2);
w=-50*w0:w0:50*w0;
stem(w/(2*pi),abs(X)),title('Spectrul lui x(t)');
