%function score = matching2( Image1, Image2 )
original = imread('101_2.tif');
distorted = imread('102_6.tif');
ptsOriginalBRISK  = detectBRISKFeatures(original,'MinContrast',0.01);
ptsDistortedBRISK = detectBRISKFeatures(distorted,'MinContrast',0.01);

ptsOriginalSURF  = detectSURFFeatures(original);
ptsDistortedSURF = detectSURFFeatures(distorted);

[featuresOriginalFREAK,validPtsOriginalBRISK]  =   extractFeatures(original,ptsOriginalBRISK);
[featuresDistortedFREAK,validPtsDistortedBRISK] =    extractFeatures(distorted,ptsDistortedBRISK);

[featuresOriginalSURF,validPtsOriginalSURF]  =   extractFeatures(original,ptsOriginalSURF);
[featuresDistortedSURF,validPtsDistortedSURF] =   extractFeatures(distorted,ptsDistortedSURF);

indexPairsBRISK = matchFeatures(featuresOriginalFREAK, featuresDistortedFREAK,'MatchThreshold',40,'MaxRatio',0.8);

indexPairsSURF = matchFeatures(featuresOriginalSURF,featuresDistortedSURF);

matchedOriginalBRISK  = validPtsOriginalBRISK(indexPairsBRISK(:,1));
matchedDistortedBRISK = validPtsDistortedBRISK(indexPairsBRISK(:,2));

matchedOriginalSURF  = validPtsOriginalSURF(indexPairsSURF(:,1));
matchedDistortedSURF = validPtsDistortedSURF(indexPairsSURF(:,2));

figure
showMatchedFeatures(original,distorted,matchedOriginalBRISK,...
            matchedDistortedBRISK)
title('Putative matches using BRISK & FREAK')
legend('ptsOriginalBRISK','ptsDistortedBRISK')

matchedOriginalXY  =   [matchedOriginalSURF.Location; matchedOriginalBRISK.Location];
matchedDistortedXY =   [matchedDistortedSURF.Location; matchedDistortedBRISK.Location];


[tformTotal,inlierDistortedXY,inlierOriginalXY] = estimateGeometricTransform(matchedDistortedXY, matchedOriginalXY,'similarity');

figure
showMatchedFeatures(original,distorted,inlierOriginalXY,inlierDistortedXY)
title('Matching points using SURF and BRISK (inliers only)')
legend('ptsOriginal','ptsDistorted')

% 
% score=0.0;
% arraySize=size(matchedPoints1.Location);
% arrSize=arraySize(1,1);
% for i=1:arrSize
%    score = score + sqrt(( matchedPoints1.Location(i,1)- matchedPoints2.Location(i,1) ).^2 + ( matchedPoints1.Location(i,2)- matchedPoints2.Location(i,2) ).^2);      
% end
% score=(1+(score/arrSize));
% disp(score);

%figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);



%end

