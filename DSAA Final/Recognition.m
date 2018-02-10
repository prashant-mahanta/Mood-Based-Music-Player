function [OutputName,OutputIndex] = Recognition(TestImage, m, A, Eigenfaces,TrainImage)
% Description: This function compares two faces by projecting the images into facespace and 
% measuring the Euclidean distance between them.
%
% Argument:      TestImage              - Path of the input test image
%
%                m                      - (M*Nx1) Mean of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                Eigenfaces             - (M*Nx(P-1)) Eigen vectors of the
%                                         covariance matrix of the training
%                                         database, which is output of 'EigenfaceCore' function.
%
%                A                      - (M*NxP) Matrix of centered image
%                                         vectors, which is output of 'EigenfaceCore' function.
% 
% Returns:       OutputName             - Name of the recognized image in the training database.              

%%% Projecting centered image vectors into facespace
% All centered images are projected into facespace by multiplying in
% Eigenface basis's. Projected vector of each face will be its corresponding
% feature vector.

ProjectedImages = [];
Train_Number = size(Eigenfaces,2);
for i = 1 : Train_Number
    temp = Eigenfaces'*A(:,i); % Projection of centered images into facespace
    ProjectedImages = [ProjectedImages temp]; 
end

%%%%%%%%%%%%%%%%%%%%%%%% Extracting the PCA features from test image
InputImage = imread(TestImage);
trainImg = imread(TrainImage);
l=size(InputImage);
q=size(trainImg);
if l(1) ~= q(1)
    InputImage = imresize(InputImage,[q(1) q(2)]);
end

temp = InputImage(:,:,1);
[irow icol] = size(temp);
InImage = reshape(temp',irow*icol,1);
Difference = double(InImage)-m; % Centered test image
ProjectedTestImage = Eigenfaces'*Difference; % Test image feature vector
%display(ProjectedTestImage);
%%%%%%%%%%%%%%%%%%%%%%%% Calculating Euclidean distances 
% Euclidean distances between the projected test image and the projection
% of all centered training images are calculated. Test image is
% supposed to have minimum distance with its corresponding image in the
% training database.

Euc_dist = [];
%emotion = [];
%count = 0;
%done = 0;
for i = 1 : Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    Euc_dist = [Euc_dist temp];
    %done = done + temp;
end
%{
done = 20;
count=0;
emotion=[];
for i = 1: Train_Number
    q = ProjectedImages(:,i);
    temp = ( norm( ProjectedTestImage - q ) )^2;
    count = count + temp;
if i == 20
        count = count/done;
        emotion = [emotion count];
        count =0 ;
    elseif i == 40
        count = count/done;
        emotion = [emotion count];
        count =0;
    elseif i == 60
        count = count/done;
        emotion = [emotion count];
        count = 0;
    elseif i == 80
        count = count/done;
        emotion = [emotion count];
    elseif i == 100
        count = count/done;
        emotion = [emotion count];
        count = 0;
end
end

display(emotion);
display(Euc_dist);
%}
[Euc_dist_min , Recognized_index] = min(Euc_dist);
%display(Euc_dist_min);
%display(Recognized_index);
OutputIndex = Recognized_index;
OutputName = strcat(int2str(Recognized_index),'.jpg');