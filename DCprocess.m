function [ph,newDCR,newDCI] = DCprocess(x,maxR,minR,preDCR,maxI,minI,preDCI)
%process the DC with the angle
ph = angle(x);
unwrap(ph);
for i = 2:120
    if abs(ph(i)-ph(i-1)) > pi/4
        newDCR = (1 - 0.5)*preDCR + (maxR + minR)/2*0.5;
        newDCI = (1 - 0.5)*preDCI + (maxI + minI)/2*0.5;
    else
        newDCR = preDCR;
        newDCI = preDCI;
    end
    
end




end