function edusim (numstudents,yearstotest)
%
% DESCRIPTION
% 
% 
% 
% 
% RETURNS
% 
% 
% 
% 
% ARGUMENTS
% 
% 
% 
% AUTHOR
%     Kevin Granger
%     kmg2728@rit.edu
%     2013-02-21


% grades = zeros(1,students);

students = [75*ones(1,numstudents); zeros(yearstotest,numstudents)];

for i=2:yearstotest+1
    
    for j=1:numstudents
        students(i,j) = taketest(mean([students(i-1,j) 75]),15);
    end
    
    fprintf('Year %u', i-1);
    students(i,:)
    
end
    
end
% 
% Notes:
% 
% for gaussian distribution:
%     
% randomvalue = MEAN + STDDEV.*randn(X,Y);
% 
% 
% 
% Possible sims:
% 
% FOR THE SAME CLASS:
% how many sections, how many years must be watched to determine
% which class is underperforming?
% 
% 
% how reliable is using standardized testing to rank teachers?
% 
% 
