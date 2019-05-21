clear;
clc;

comparedImg=imread('101_2.tif');
srcFile=dir('FVC2002\*.tif');
finalScore = zeros(80,1);
matched="";
threshold=95;
count(1)=0;




for i=1:length(srcFile)

   filename=strcat('FVC2002\',srcFile(i).name);    
   disp(['processing '  filename]);

   I = imread(filename);
   
   disp(['score between choosen image and '  filename ' = ']);

   matching2(comparedImg,I);
   score=string(score);

   
   finalScore(i,1)=score;
   matched(i,:)=srcFile(i).name;

end

%get values under threshold
for i=1:length(matched)
    if(finalScore(i,1)<threshold)
        disp(matched(i,:));
        count(1)=count(1)+1;
    end
end
disp(count(1));