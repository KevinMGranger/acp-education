function [grades, teacherAverages] = edusim (yearsToTest, studentNormal, gradeInfluence, teacherInfluence, randomFuzzing)
%
% DESCRIPTION
% 
%     Simulate students receiveing grades in a course / taking standardized
%     tests each year, with certain influences applied.
% 
% 
% RETURNS
% 
%     grades    =    an m-by-n array of student grades, where m is the
%     number of years tests are taken (plus one for the starting grades /
%     skills. If this data is unwanted, shave off the top row of the
%     returned data), and where n is the number of students
% 
%     teacherAverages    =    the averages for each class / year that the
%     teachers achieved.
% 
% 
% ARGUMENTS
% 
%     yearsToTest = the number of years to test the students / the number
%     of courses the students take
% 
%     studentNormal = true/false, whether students all start at an average
%     ability level, or if there's a standard distribution of student
%     skills.
% 
%     gradeInfluence = true/false, whether or not previous grades influence
%     the student's performance in the next test / course.
% 
%     teacherInfluence = truefalse, whether there are teachers of varying
%     "abilities" in teaching.
% 
%     randomFuzzing = true/false, whether test grades are randomly fuzzed.
%     Students could be having a bad day when taking a test, or get lucky,
%     etc.
% 
% 
% AUTHOR
%     Kevin Granger
%     kmg2728@rit.edu
%     2013-02-21


NUMSTUDENTS=90; % the number of students in the entire "grade"

global FUZZING;
FUZZING = randomFuzzing;

% Set up student's starting grades, either with a normal distribution or
% with everyone starting on the same skill level.
if studentNormal == true
    grades = [75 + 15.*randn(1,NUMSTUDENTS); zeros(yearsToTest, NUMSTUDENTS)];
elseif studentNormal == false
    grades = [75 .* ones(1,NUMSTUDENTS); zeros(yearsToTest, NUMSTUDENTS)];
end

% Set up teacher influences, or "disable" them by setting their values to 1
if teacherInfluence == true
    teacherSkills = [0.9 1.0 1.1];
elseif teacherInfluence == false
    teacherSkills = ones(1,3);
end

% Pre-allocate arrays.
% class grades are as big as a single class (all students / number of
% teachers)
% teacher averages are the number of years testing occurs, by the number of
% teachers
classGrades = zeros(1, NUMSTUDENTS ./ size(teacherSkills,2));
classSize = size(classGrades,2);
teacherAverages = zeros(yearsToTest, size(teacherSkills,2));


for i=2:yearsToTest+1 % for each year of testing
    
    % Randomly assign each teacher many different students. Basically gives
    % a bunch of exclusive, different indexes to access with.
    assignedStudents = randperm(NUMSTUDENTS);
    
    
    for j=1:size(teacherSkills,2) % for teach teacher,
        
        % "These are the students I have in my class"
        % The j*whatnot is to jump to the next fraction of assignments
        myStudents = ...
            assignedStudents( (((j-1)*classSize)+1):(j*classSize) ); 
        
        
        for k=1:classSize % for each student,
            
            % If we're using semi-self-influenced grading, set it up.
            % If we're not, just center the possible grade around good 'ol
            % average 75.
            if gradeInfluence == true
                mu = mean([grades(i-1,myStudents(k)) 75]);
            elseif gradeInfluence == false
                mu = 75;
            end
            
            % Take the test / get a grade for the course, factoring in what
            % the grade will *likely* be (mu), how much your teacher
            % influences your grade (if at all), and whether or not it will
            % be randomly fuzzed.
            grades(i,myStudents(k)) = ...
                taketest(mu, teacherSkills(j), randFuzz);
            
            % Compile the grades for each student in the class, so that a
            % class average can be established.
            classGrades(k) = grades(i,myStudents(k));
            
        end % student loop
        
        
        % Compile the class averages for each teacher for each year.
        teacherAverages(i-1,j) = mean(classGrades);
    
        
    end % teacher loop
    
end % yearly testing loop
    

end % main edusim function


function [fuzz] = randFuzz
% 
% DESCRIPTION
%     
%     Give a value to randomly fuzz a test by, unless fuzzing is disabled.
% 
% RETURNS
%     
%     The value to fuzz by (or 1, for not fuzzing)

global FUZZING;
SIGMA = 0.04; % The standard deviation for the fuzzing

if FUZZING == true
    fuzz = 1 + SIGMA.*randn;
elseif FUZZING == false
    fuzz = 1;
end
    

end % fuzzing function