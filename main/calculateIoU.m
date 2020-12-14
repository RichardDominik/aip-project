function [iou] = calculateIoU(groundBox,box)
%CALCULATEIOU Summary of this function goes here
%   Detailed explanation goes here
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
        iou = [iou maxim];
    end
end