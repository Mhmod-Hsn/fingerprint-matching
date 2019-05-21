function score = matching( I1, I2 )

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

%euclidian distance
score=0.0;
arraySize=size(matchedPoints1.Location);
arrSize=arraySize(1,1);

for i=1:arrSize
   score = score + sqrt(( matchedPoints1.Location(i,1)- matchedPoints2.Location(i,1) ).^2 + ( matchedPoints1.Location(i,2)- matchedPoints2.Location(i,2) ).^2);      
end

%NORMALIZZATION
score=(1+(score/arrSize));
disp(score);

%figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);



end

