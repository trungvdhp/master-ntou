% Problem P4_5_2
%
% Compare Static Scheduling and Pool-of-task scheduling.

p = 4;

close all

figure
task_vec = [1000; 100*ones(39,1)];
[tr1,tr2] = Xtime(task_vec,p);
subplot(2,1,1)
plot(tr1)
title(sprintf('Static Assignment. Total Time = %5.0f',length(tr1)))
ylabel('Procs Busy')
xlabel('Time Step')
axis([0 length(tr1) 0 p+1])
subplot(2,1,2)
plot(tr2)
title(sprintf('Pool-of-Task Assignment. Total Time = %5.0f',length(tr2)))
ylabel('Procs Busy')
xlabel('Time Step')
axis([0 length(tr1) 0 p+1])
figure
task_vec = [100*ones(39,1);1000];
[tr1,tr2] = Xtime(task_vec,p);
subplot(2,1,1)
plot(tr1)
title(sprintf('Static Assignment. Total Time = %5.0f',length(tr1)))
ylabel('Procs Busy')
xlabel('Time Step')
axis([0 length(tr1) 0 p+1])
subplot(2,1,2)
plot(tr2)
title(sprintf('Pool-of-Task Assignment. Total Time = %5.0f',length(tr2)))
ylabel('Procs Busy')
xlabel('Time Step')
axis([0 length(tr1) 0 p+1])
