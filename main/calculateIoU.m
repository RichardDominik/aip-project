function [iou] = calculateIoU(groundBox,box)
%CALCULATEIOU Summary of this function goes here
%   Detailed explanation goes here
    tp = 0;
    fp = 0;
    iou = [];
    for i = 1:size(groundBox, 1)
        A = groundBox(i,:);
        maxim = 0;
        for j = 1:size(box, 1)
            B = box(j, :);
            result = bboxOverlapRatio(A, B);
            if result > maxim
                maxim = result;
            end
        end
        if maxim >= 0.5
            tp = tp + 1;
        else 
            fp = fp + 1;
        end
        
        iou = [iou maxim];
        %disp(maxim);
    end
    disp("AP50: " + tp/(tp + fp));
end