function [output] = calculateAP(iou, P)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    tp = 0;
    fp = 0;

    for i = iou
        if i >= P
            tp = tp + 1;
        else 
            fp = fp + 1;
        end
    end
    
    output = tp/(tp + fp);
end

