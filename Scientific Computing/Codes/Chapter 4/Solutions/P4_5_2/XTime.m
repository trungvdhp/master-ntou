function  [trace_static,trace_pool] = XTime(task_vec,p)
% ask_vec is a column n-vector of positive integers
% p is the number of processors, a positive integer.
% 
% trace_static is a column vector where trace_static(k) is the number of
%     processors busy during time step k, where
%     k = length(trace_static). Based on  static
%     wrap mapping assignment of tasks.
%
% trace_pool is a column vector where trace_pool(k) is the number of
%     processors busy during time step k, where
%     k = length(trace_pool). Based on the pool-of-task
%     paradigm.      

% Static assignment:

n = length(task_vec);
% How much work is each processor assigned?
proc_vec = zeros(p,1);
for k=1:p
   proc_vec(k) = sum(task_vec(k:p:n));
end

t = zeros(max(proc_vec),1);
for k=1:p
   t(1:proc_vec(k)) = t(1:proc_vec(k)) + ones(proc_vec(k),1);
end
trace_static = t;

% Pool-of-task assignment:	 

next = 1;
busy = zeros(p,1);
t = [];
while (next<=n) | any(busy>0)
   % Make sure all free processors are given a task if possible.
   [z,free] = min(busy);
   while (z==0) & (next<=n)
      % The first free processor is given a task
      busy(free) = task_vec(next);
      next = next + 1;
      [z,free] = min(busy);
   end			
   t = [t;sum(busy>0)];
   busy = busy-1;
end
trace_pool = t;