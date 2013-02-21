function [grade] = taketest (mu, teacherInfluence, randomFuzzing)
%
% DESCRIPTION
% 
%     Take a test with optional influencing information, giving back the
%     recieved grade.
% 
% 
% RETURNS
% 
%     grade    =    the recieved grade.
% 
% 
% ARGUMENTS
% 
%     mu    =    the median/mena value to focus the standard distribution
%     around. For a standard grade, use 75.
%
%     teacherInfluence    =    the amount a teacher's "skill" influences a
%     student's grade. For no influence, use 1. For a "good" teacher, a
%     value of 1.1 would work. For a "bad" one, 0.9.
%
%     randomFuzzing    =    a value to randomly fuzz by. A student could be
%     having a really bad day when taking the test, or be sick, or get
%     really lucky with some questions. Use 1 for no influence. For a good
%     small influence, a standard distribution centered around 1 with a
%     standard deviation of something around 0.04 works.
%
% 
% AUTHOR
%     Kevin Granger
%     kmg2728@rit.edu
%     2013-02-21


SIGMA = 15; % standard deviation

grade = mu + SIGMA.*randn; % pull a value from a normal distribution

grade = grade * teacherInfluence * randomFuzzing; % apply influences

% format the grade so it's realistic
    if (grade > 100)
        grade = 100;
    elseif (grade < 0)
        grade = 0;
    end
    
end