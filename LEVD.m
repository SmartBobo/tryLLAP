function [output] = LEVD(input)
%对输入的矩阵进行LEVD处理
%现在还没有将thr考虑进去
LMax = islocalmax(input);
LMin = islocalmin(input);
tempMin = input(1);
tempMax = input(1);
flag = -1;
s = zeros(120,1);
s(1) = input(1);
for a = 2:120
    if LMax(a) ~= 1 && LMin(a) ~=1
        s(a) = 0.9*s(a-1) + 0.05*(tempMin + tempMax);
    elseif LMax(a) == 1 && flag ~=1
        tempMax = input(a);
        s(a) = 0.9*s(a-1) + 0.05*(tempMin + tempMax);
        flag = 1;
    elseif LMin(a) == 1 && flag ~=0
        tempMin = input(a);
        s(a) = 0.9*s(a-1) + 0.05*(tempMin + tempMax);
        flag = 0;
    end
    a = a + 1;
    
end
output = s;
end

