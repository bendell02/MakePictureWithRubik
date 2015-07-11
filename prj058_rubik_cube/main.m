% MAIN ... 
%  
%   ... 

%% AUTHOR    : Ben 
%% $DATE     : 15-Dec-2014 09:26:52 $ 
%% $Revision : 1.00 $ 
%% DEVELOPED : 8.1.0.604 (R2013a) 
%% FILENAME  : main.m 

%% 解析魔方各个面
qc

cell_puzzle = cell(1,6);                % cell_puzzle用于存储魔方的各个面
clr = zeros(6,3);                       % clr存储各个面的颜色值

for i = 1:6                             % 计算每个面的强度
    puzzle_temp = imread(['s',num2str(i) '.jpg']);
    cell_puzzle{i} = puzzle_temp;
    [rs,cs,~] = size(puzzle_temp);
    r1 = uint8(0.2*rs); r2 = uint8(0.8*rs);
    c1 = uint8(0.2*cs); c2 = uint8(0.8*cs);
    clr_temp = puzzle_temp(r1:r2,c1:c2,:);
    for j = 1:3
        clr(i,j) = mean2(clr_temp(:,:,j));
    end
end

I = cell_puzzle{1};
r_I = size(I,1);
c_I = size(I,2);

%% 对原图六值化
I_original = imread('obama.jpg');                 % I为原图，即需要制成的图
[rows,cols,~] = size(I_original);

clsf_I = zeros(rows,cols);
p = zeros(1,3);

for i = 1:rows
    for j = 1:cols
        p(:) = I_original(i,j,:);
        temp = zeros(1,6);
        for k = 1:6
            temp(k) = norm(clr(k,:)-p);
        end
        [~,idx] = min(temp);
        clsf_I(i,j) = idx;
    end
end

%% 制图
I_final = zeros(rows*r_I,cols*c_I,3);

for i = 1:rows
    for j = 1:cols
        r1 = (i-1)*r_I+1; r2 = i*r_I;
        c1 = (j-1)*c_I+1; c2 = j*c_I;
        switch clsf_I(i,j)
            case 1
                I_final(r1:r2,c1:c2,:) = cell_puzzle{1};
            case 2
                I_final(r1:r2,c1:c2,:) = cell_puzzle{2};
            case 3
                I_final(r1:r2,c1:c2,:) = cell_puzzle{3};
            case 4
                I_final(r1:r2,c1:c2,:) = cell_puzzle{4};
            case 5
                I_final(r1:r2,c1:c2,:) = cell_puzzle{5};
            case 6
                I_final(r1:r2,c1:c2,:) = cell_puzzle{6};
        end
    end
end
I_final = uint8(I_final);
imshow(I_final)

%% End_of_File  
% Created with NM.m by Ben  
% Contact...: pengyong@sia.cn  
% ===== EOF ====== [main.m] ======  
