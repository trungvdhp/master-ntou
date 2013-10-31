% Script File: Dice  p.36
% Simulates 1000 rollings of a pair of dice.

% close all
first = 1 + floor(6*rand(1000, 1));
second = 1 + floor(6*rand(1000,1));
Throws = first + second;          % the total number of the two throws.
hist(Throws, linspace(2,12,11)) ;
title('Simulation Outcome of 1000 Dice Rolls.')


% compare 'floor' and 'ceil' functions
diceplay1 = 6*rand(1000, 1);
first1 = 1 + floor(diceplay1);
first2 = ceil(diceplay1);
err = (first1 - first2)';
