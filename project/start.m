clear;
clc;

comparedImg=imread('101_2.tif');

%DATABASE
srcFile=dir('FVC2002\*.tif');

%THRESHOLD
threshold=50;

%USED VARIABLES
finalScore = zeros(80,1);
matched="";

for i=1:length(srcFile)

   filename=strcat('FVC2002\',srcFile(i).name);    
   disp(['processing '  filename]);

   I = imread(filename);
   
   disp(['score between choosen image and '  filename ' = ']);

   score = matching(comparedImg,I);
   score=string(score);

   %score
   finalScore(i,1)=score;
   %filename    
   matched(i,:)=srcFile(i).name;
end

%getvalues under threshold
%choosen = zeros(80,1);

for i=1:length(matched)
    if(finalScore(i,1)<threshold)
        disp(matched(i,:));
        choosen(i,1)=matched(i,:);
    end
    
end