% First Half
fileID = fopen("Input/input1.txt","r");
result1 = 0;
while ~feof(fileID)
    numbers = str2double(regexp(sscanf(fgetl(fileID),'%s'), '\d', 'match'));
    result1 = result1 + numbers(1) * 10 + numbers(end);
end
fclose(fileID);

% Second Half
fileID = fopen("Input/input1.txt", "r");
wordMap = containers.Map( ...
    {'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'}, ...
    {'o1e', 't2o', 't3e', '4', '5e', '6', '7n', 'e8t', '9e'});
result2 = 0;
while ~feof(fileID)
    str = sscanf(fgetl(fileID), '%s');
    for word = keys(wordMap)
        str = regexprep(str, word{1}, wordMap(word{1}));
    end
    numbers = str2double(regexp(str, '\d', 'match'));
    result2 = result2 + numbers(1) * 10 + numbers(end);
end
fclose(fileID);

% Output
disp("Answer 1: " + result1);
disp("Answer 2: " + result2);








