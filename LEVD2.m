function [output,newDC,Lmax,Lmin] = LEVD2(input,preDC)
%������ľ������LEVD����
%���ڻ�û�н�thr���ǽ�ȥ
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