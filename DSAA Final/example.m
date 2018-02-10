% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION
clear all
clc
close all
% You can customize and fix initial directory paths
tts('Mood Based Music Player');
tts('Please Choose Training images Directory');
TrainDatabasePath = uigetdir('C:\Users\USER\Desktop\Matlab\DSAA Final', 'Select training database path' );
tts('Please Choose Test Images Directory');
TestDatabasePath = uigetdir('C:\Users\USER\Desktop\Matlab\DSAA Final', 'Select test database path');
tts('Please Choose your test image file');
prompt = {'Enter test image name'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};

TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
%for i = 1: 100
    
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');
TrainImage =strcat(TrainDatabasePath,'\','1','.jpg');
im = imread(TestImage);
imshow(im);
sss=imread(TrainImage);
l=size(im);
q=size(sss);
if l(1) ~= q(1)
   im = imresize(im,[q(1) q(2)]);
end
T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
[OutputName, OutputIndex] = Recognition(TestImage, m, A, Eigenfaces,TrainImage);
%%
LabelPath = 'C:\Users\USER\Desktop\Matlab\DSAA Final\testimage.txt';
fid=fopen(LabelPath);
imageLabel=textscan(fid,'%s %s','whitespace',',');
fclose(fid);
Best_Match = cell2mat(imageLabel{1,1}(OutputIndex));
ExprLabel = cell2mat(imageLabel{1,2}(OutputIndex));
%display(i);
str2 = strcat('You seem to be:  ',ExprLabel);
disp(str2)
tts(str2);
%%
SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);
%imshow(im);
%title('Test Image');
%figure,imshow(SelectedImage);
%title('Equivalent Image');
figure;

 img = rgb2gray(SelectedImage);
 figure;
    imshow(img);
str = strcat('Matched image is :  ',OutputName);
disp(str)
if strcmp(ExprLabel, 'happy')
    [y, fs] = audioread('C:\Users\USER\Desktop\Matlab\DSAA Final\happy.mp3');
    sound(y, fs);
    openfig('C:\Users\USER\Desktop\Matlab\DSAA Final\audio_player.fig');
end
if strcmp(ExprLabel, 'sad')
    [y, fs] = audioread('C:\Users\USER\Desktop\Matlab\DSAA Final\sad.mp3');
    sound(y, fs);
    openfig('C:\Users\USER\Desktop\Matlab\DSAA Final\audio_player.fig');
end
if strcmp(ExprLabel, 'angry')
    [y, fs] = audioread('C:\Users\USER\Desktop\Matlab\DSAA Final\angry.mp3');
    sound(y, fs);
    openfig('C:\Users\USER\Desktop\Matlab\DSAA Final\audio_player.fig');
end
if strcmp(ExprLabel, 'digust')
    [y, fs] = audioread('C:\Users\USER\Desktop\Matlab\DSAA Final\disgust.mp3');
    sound(y, fs);
    openfig('C:\Users\USER\Desktop\Matlab\DSAA Final\audio_player.fig');
end
if strcmp(ExprLabel, 'neutral')
    [y, fs] = audioread('C:\Users\USER\Desktop\Matlab\DSAA Final\neutral.mp3');
    sound(y, fs);
    openfig('C:\Users\USER\Desktop\Matlab\DSAA Final\audio_player.fig');
end