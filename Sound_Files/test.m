clear all
close all
clc
%%Selecting the necessary folder for processing and running a batch operation
% Specify the folder where the files live.
myFolder = ('D:\Ents\NG Challenge\Sound_Files');
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
uiwait(warndlg(errorMessage));
return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.wav'); % Change to whatever pattern you need.
LS = dir(filePattern);
STM=zeros(length(LS),35);
MTM=zeros(length(LS),35);
for k = 1 : length(LS);
  baseFileName = LS(k).name;
LungSounds = fullfile(myFolder, baseFileName);
fprintf(1, 'Now reading %s\n', LungSounds) 
  %This can be utsed to list directed files being processed
% The files are read in via 'audioread', listing the Sampled Data and Sampling Rate
[X, Fs] = audioread(LungSounds);
  stf=stFeatureExtraction(X,12000,9,9);
  STM(k,:)=stf';
    listOfStatistics={'mean','max','min','median','std','stdbymean'}; %Arithmetic mean
%         'kurtosis','geomean','harmean','skewness'}; 
    mtf=mtFeatureExtraction(stf,9,9,listOfStatistics(6)); 
MTM(k,:)=mtf';
%   M=[];
% %   ALL={STM;MTM};
% ALL = {stm;mtm};
%   for k=1:length(LS);
%       M=[M; ALL];
%   end
%   M %Clusters all extracted data into a cell
end