clear;
clc;

g=9.81;
d=10/1000;  %skok sruby
n=0.6*0.9;  %wspolczynnik maks obciazenia silnika

lo=750/1000;
lc=150/1000;
ls=450/1000;

px=190/1000;
py=450/1000;

Fc=450;
Fo=80;
eps_r=7;
mo=Fo/g;

mr=Fc/g;
I=8.4+mr*(lc)^2;
Mb=I*eps_r;
Fb=eps_r*lo*mo;

fi_r=linspace(deg2rad(25),deg2rad(105),100);
Fsy=zeros(1,100);
alfa=zeros(1,100);
Fs=zeros(1,100);

for i=1:100
    alfa(i)=atan2(ls*cos(fi_r(i)-pi/2)-px,py-sin(fi_r(i)-pi/2)*ls);
    Fsy(i)=(Fc*lc+(Fo+Fb)*lo+Mb/sin(fi_r(i)))/ls;
    Fs(i)=Fsy(i)/(cos(alfa(i))+sin(alfa(i))*tan(fi_r(i)-pi/2));
end

figure(1);
plot(rad2deg(fi_r),Fsy,rad2deg(fi_r),Fs);
title("Wykresy sił od kąta")
xlabel("fi [deg]");
ylabel("F [N]");
legend("Fsy","Fs")
Ms=max(Fs)*d/(2*pi)/n %wymagany moment silnika

t=linspace(0,1263,1264);
eps_r=zeros(1,1264);
om_r=zeros(1,1264);
fi_r=zeros(1,1264);
eps_r(1:632)=7*180/2/pi;
eps_r(633:1264)=-7*180/2/pi;
om_r(1)=1/1000*eps_r(1);
fi_r(1)=om_r(1)*1/1000;
for i=2:1264
    om_r(i)=om_r(i-1)+eps_r(i)*1/1000;
    fi_r(i)=fi_r(i-1)+om_r(i)*1/1000;
end

figure(2)
tiledlayout(3,1);
nexttile
plot(t,fi_r);
title("Kąt ramienia")
ylabel("fi [deg]")
xlabel("t [ms]")
nexttile
plot(t,om_r)
title("Prędkość kątowa ramienia")
ylabel("om [deg/s]")
xlabel("t [ms]")
nexttile
plot(t,eps_r);
title("Przyspieszenie kątowe ramienia")
ylabel("eps [deg/s^2]")
xlabel("t [ms]")

eps_s=zeros(1,1264);
om_s=zeros(1,1264);
fi_s=zeros(1,1264);
for i=1:1264
    eps_s(i)=eps_r(i)*ls/d;
    om_s(i)=om_r(i)*ls/d;
    fi_s(i)=fi_r(i)*ls/d;
end

figure(3)
tiledlayout(3,1);
nexttile
plot(t,fi_s);
title("Kąt skręcenia śruby")
ylabel("fi [deg]")
xlabel("t [ms]")
nexttile
plot(t,om_s)
title("Prędkość kątowa wału")
ylabel("om [deg/s]")
xlabel("t [ms]")
nexttile
plot(t,eps_s);
title("Przyspieszenie kątowe wału")
ylabel("eps [deg/s^2]")
xlabel("t [ms]")