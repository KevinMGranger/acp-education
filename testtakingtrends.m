function testtakingtrends
%
% DESCRIPTION
% 
%     Illustrate the issues with using the past grades of a student to
%     influence their new grades.
% 
% AUTHOR
%     Kevin Granger
%     kmg2728@rit.edu
%     2013-02-21


TESTSTOTAKE=300;

grades = [90 zeros(1,TESTSTOTAKE-1)];


% Control Group

for i=2:TESTSTOTAKE
    grades(i)=taketest(75,1,1);
end

figure(1);
plot(grades);
xlabel('Test Number');
ylabel('Grade');
title('Non-influenced control group'); 


% Illustrate the self-influencing trend issue

for i=2:TESTSTOTAKE
    grades(i)=taketest(grades(i-1),1,1);
end

figure(2);
plot(grades);
xlabel('Test Number');
ylabel('Grade');
title('Self-influenced grade trends over time'); 


% Illustrate how semi-self-influencing grades help, by averaging the past
% grade with a good mean (75)

for i=2:TESTSTOTAKE
    grades(i)=taketest( ...
        mean( [grades(i-1) 75] ) ...
        ,1,1);
end

figure(3);
plot(grades);
xlabel('Test Number');
ylabel('Grade');
title('Semi-self-influenced grade trends over time'); 
