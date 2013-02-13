function [grade] = taketest (mean, stddev)

grade = mean + stddev.*randn;

    if (grade > 100)
        grade = 100;
    elseif (grade < 0)
        grade = 0;
    end
end