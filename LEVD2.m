function [output,newDC,Lmax,Lmin] = LEVD2(input,preDC)
%对输入的矩阵进行LEVD处理
%现在还没有将thr考虑进去
Lmax = max(input);
Lmin = min(input);
s = zeros(120,1); 
if Lmax-Lmin > 220
    newDC = ( 1 - 0.25)*preDC + 0.25*(Lmax+Lmin)/2;
    for t = 1:120
        s(t) = newDC;
    end
end
output = s;
end