% 选择Excel文件
[filename, filepath] = uigetfile('*.xlsx', '选择要转换的Excel文件');
if isequal(filename, 0)
    disp('用户取消操作');
    return;
end

% 提取无扩展名的文件名
[~, baseName, ~] = fileparts(filename);

% 强制将变量名设为与文件名一致
validVarName = baseName;
validVarName = regexprep(validVarName, '[^a-zA-Z0-9_]', '_'); % 替换非法字符为下划线

% 读取Excel数据并转换为数组
excelData = readmatrix(fullfile(filepath, filename));  

% 将数据保存为数组
output.(validVarName) = excelData;

% 保存为.mat文件
matFilePath = fullfile(filepath, [baseName '.mat']);
save(matFilePath, '-struct', 'output', validVarName);

disp(['转换完成！文件已保存为: ' matFilePath]);