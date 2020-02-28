function Comp = ReImToComp(Re, Im)
Comp = zeros(120,1);
for a = 1:120
    Comp(a) = Re(a) + Im(a)*1i;
end
end

