function [output] = calculateMAP(iou)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    totalAp = 0;

    for i = 0.05:0.05:0.95
        totalAp = totalAp + calculateAP(iou, i);
    end
    
    output = totalAp/18;
end

