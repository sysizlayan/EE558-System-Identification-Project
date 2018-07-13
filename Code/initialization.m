clc;
clear;

load('measurements1.mat')

%%SUBTRACT THE MEANS
if mean(u1) == 1500
    u1 = u1-1500;
end
if t1(1) ~= 0
    t1=t1-t1(1);
end

% figure
% subplot(2,1,1)
% plot(t1,u1)
% xlabel('Time(ms), Ts=89ms')
% ylabel('Input1(us)')
% legend('Applied pulse width to the Esc (Zero centered)')
% subplot(2,1,2)
% plot(t1,y1)
% xlabel('Time(ms), Ts=89ms')
% ylabel('Output1(Gram)')
% legend('Generated Thrust')

%%DISPATCH
% I will dispatch the input for linear system identification for each small
%region, it is like small signal analysis. The system acts linear in small
%regions.

patches = (1:600:10200);
u_vec = zeros(600,17);
y_vec = zeros(600,17);

sigma = 1e-3;

for i = 1:17
    u_vec(:,i) = u1(patches(i):patches(i)+600-1);
    y_vec(:,i) = y1(patches(i):patches(i)+600-1);
end
clear patches
% u1 = u1(1:10200);
% y1 = y1(1:10200);

% h=gcf;
% set(h,'PaperOrientation','landscape');
% set(h,'PaperPosition', [1 1 28 19]);
% figure
% subplot(1,2,1)
% plot(1:600,y_vec)
% xlabel('Time (89ms each step)')
% ylabel('Thrust (Gram)')
% title('Patched Input and Output Signals')
% hold on
% 
% subplot(1,2,2)
% plot(1:600,u_vec)
% xlabel('Time (89ms each step)')
% ylabel('Speed Input (\mus)')
% title('Patched Input and Output Signals')
% % 
% print(h,'IOPatched','-dpng')
% print(h,'IOPatched','-dpdf')
