clc; clear; close all;

%% Step 1: Create synthetic dataset
n = 300;
FrontDist = 10*rand(n,1); 
SideDist  = 10*rand(n,1);

TurnAngle = -80*exp(-0.5*FrontDist) + 60*exp(-0.5*SideDist) + 10*randn(n,1);

data = [FrontDist SideDist TurnAngle];

% Split into training/testing
idx = randperm(n);
train = data(idx(1:round(0.7*n)),:);
test  = data(idx(round(0.7*n)+1:end),:);

%% Step 2: Train ANFIS (genfis1 & genfis2)
in_fismat1 = genfis1(train, 3, 'gbellmf'); 
in_fismat2 = genfis2(train(:,1:2), train(:,3), 0.5);

[trFIS1,trError1,~,~,chkError1] = anfis(train,in_fismat1,[50 0 0.01 0.9 1.1],[],test);
[trFIS2,trError2,~,~,chkError2] = anfis(train,in_fismat2,[50 0 0.01 0.9 1.1],[],test);

%% Step 3: Compare RMSE and R²
pred1 = evalfis(test(:,1:2), trFIS1);
pred2 = evalfis(test(:,1:2), trFIS2);

rmse1 = sqrt(mean((pred1 - test(:,3)).^2));
rmse2 = sqrt(mean((pred2 - test(:,3)).^2));

SSres1 = sum((test(:,3)-pred1).^2); SStot = sum((test(:,3)-mean(test(:,3))).^2);
R2_1 = 1 - SSres1/SStot;

SSres2 = sum((test(:,3)-pred2).^2);
R2_2 = 1 - SSres2/SStot;

fprintf('genfis1: RMSE=%.3f  R2=%.3f\n', rmse1, R2_1);
fprintf('genfis2: RMSE=%.3f  R2=%.3f\n', rmse2, R2_2);

%% Step 4: Surface visualization
figure;
subplot(1,2,1); gensurf(trFIS1); title('Surface: genfis1');
subplot(1,2,2); gensurf(trFIS2); title('Surface: genfis2');

%% Step 5: Select best FIS
if rmse1 < rmse2
    fis = trFIS1;
    disp('Selected genfis1 as best model');
else
    fis = trFIS2;
    disp('Selected genfis2 as best model');
end

%% Step 6: Define obstacles
% [x y radius]
obstacles = [5 5 0.5;
             8 2 0.5;
             3 7 0.7];

%% Step 7: Drone simulation
x=0; y=0; theta=0; v=0.1; dt=0.1;
steps = 300; path = zeros(steps,2);

for k=1:steps
    [fd, sd] = measureFrontSide(x,y,theta,obstacles); % LOS sensing
    ang = evalfis([fd sd], fis); 
    theta = theta + deg2rad(ang)*dt;
    x = x + v*cos(theta)*dt;
    y = y + v*sin(theta)*dt;
    path(k,:) = [x y];
end

figure; hold on; axis equal
plot(path(:,1), path(:,2), 'b-', 'LineWidth', 1.5)
viscircles(obstacles(:,1:2), obstacles(:,3), 'Color','r');
title('Drone Path with Obstacle Avoidance (ANFIS)')
