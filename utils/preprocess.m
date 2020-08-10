% Author: Baihan Lin (doerlbh@gmail.com), Columbia University 
% Date: July 2017 (ABaCoDE paper), Dec 2019 (BerlinUCB paper)


addpath data
rng(666)

%%      'MNIST'

        load mnist_uint8;
        learn_x = double(train_x);
        learn_y = double(train_y);
        prior_x  = double(test_x);
        clearvars train_x train_y test_x test_y
        learn_y = vec2ind(learn_y');
        data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 784;
        opts.nOptions = 10;
        opts.epiReward = 1;
        save('processed/mnist.mat','data','opts')
        
%%     'MNIST-s'

        load mnist_uint8;
        range = 5000;
        pick = randi(60000,range,1);
        learn_x = double(train_x(pick,:));
        learn_y = double(train_y(pick,:));
        prior_x  = double(test_x);
        clearvars train_x train_y test_x test_y
        learn_y = vec2ind(learn_y');
        data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 784;
        opts.nOptions = 10;
        opts.epiReward = 1;
        save('processed/mnists.mat','data','opts')

%%     'CIFAR-10'
        load cifar-10-test_batch
        prior_x  = double(data(randi(10000,2000,1),:));
        clearvars data labels batch_label
        
        randBatch = randi(5,2,1);
        learn_x = [];
        learn_y = [];
        isGPU = 0;
        for b = 1:2
            switch randBatch(b)
                case 1
                    load cifar-10-data_batch_1
                    learn_x  = [learn_x; double(data)];
                    learn_y  = [learn_y; double(labels+1)];
                    clearvars data labels batch_label
                case 2
                    load cifar-10-data_batch_2
                    learn_x  = [learn_x; double(data)];
                    learn_y  = [learn_y; double(labels+1)];
                    clearvars data labels batch_label
                case 3
                    load cifar-10-data_batch_3
                    learn_x  = [learn_x; double(data)];
                    learn_y  = [learn_y; double(labels+1)];
                    clearvars data labels batch_label
                case 4
                    load cifar-10-data_batch_4
                    learn_x  = [learn_x; double(data)];
                    learn_y  = [learn_y; double(labels+1)];
                    clearvars data labels batch_label
                case 5
                    load cifar-10-data_batch_5
                    learn_x  = [learn_x; double(data)];
                    learn_y  = [learn_y; double(labels+1)];
                    clearvars data labels batch_label
                otherwise
                    disp('wrong pick')
            end
            pick = randi(size(learn_x,1),range,1);
            learn_x = learn_x(pick,:);
            learn_y = learn_y(pick,:);
        end
        
        data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 3072;
        opts.nOptions = 10;
        opts.epiReward = 1;
         save('processed/cifar10.mat','data','opts')

        
%%     'STL10'
        disp('picked dataset:');
        pick = randi(5)
        [learn_x,learn_y,prior_x] = K_readmatv73(['stl10_data_' num2str(pick)]);
        pick = randi(size(learn_x,1),range,1);
        learn_x = learn_x(pick,:);
        learn_y = learn_y(pick,:);
        
                        learn_y = vec2ind(learn_y');
                data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 3072;
        opts.nOptions = 10;
        opts.epiReward = 1;
         save('processed/stl10.mat','data','opts')
         
%%     'Caltech101S'
        load caltech101_silhouettes_28
        all_x = double(X);
        all_y = vec2mat(0,Y,length(unique(Y)));
        
        prior_x  = all_x(1:671,:);
        learn_x = all_x(672:end,:);
        learn_y = all_y(672:end,:);
        clearvars X Y all_x all_y classnames
   
                        learn_y = vec2ind(learn_y');
                data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 3072;
        opts.nOptions = 10;
        opts.epiReward = 1;
         save('processed/caltech101s.mat','data','opts')
         
%%     'warfarin'

        default_hidden = -1;
        x_y = csvread('warfarin.csv',1,0);
        all_x = x_y(:,1:93);
%         all_y = vec2mat(0,x_y(:,94)'+1,length(unique(x_y(:,94))));
        all_y = double(x_y(:,94)'+1);

        prior_x  = all_x(1:528,:);
        learn_x = all_x(529:end,:);
%         learn_y = all_y(529:end,:);
        learn_y = all_y(529:end);
        clearvars x_y all_x all_y
        
        data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 93;
        opts.nOptions = 3;
        opts.epiReward = 1;
        save('processed/warfarin.mat','data','opts')


%%      'MNISTwarfarin'

        load mnist_uint8;
        learn_x = zeros(10000,877);
        learn_y = zeros(1,10000);
        
        range = 5000;
        pick = randi(60000,range,1);
        train_x = double(train_x(pick,:));
        train_y = double(train_y(pick,:));

        learn_x(1:5000,1:784) = double(train_x);
        learn_yt = double(train_y);
%         prior_x  = double(test_x);
        learn_y(1,1:5000) = vec2ind(learn_yt');
        clearvars train_x train_y test_x test_y learn_yt
       
        x_y = csvread('warfarin.csv',1,0);
        all_x = x_y(:,1:93);
%         all_y = vec2mat(0,x_y(:,94)'+1,length(unique(x_y(:,94))));
        all_y = double(x_y(:,94)'+1);

        prior_x  = all_x(1:528,:);
        learn_x(5001:end,785:end) = all_x(529:end,:);
%         learn_y = all_y(529:end,:);
        learn_y(1,5001:end) = 10 + all_y(529:end);
        clearvars x_y all_x all_y
        
        new_idx = randperm(10000);
        learn_x = learn_x(new_idx,:);
        learn_y = learn_y(1,new_idx);

        data.rec = learn_x';
        data.full_y = string(learn_y');
        data.y = string(learn_y');
        data.t = length(learn_y);
        data.dim = 877;
        opts.nOptions = 13;
        opts.epiReward = 1;

        save('processed/mnistwarfarin.mat','data','opts')
