
% Read in image
cd Bayes_Lena_Images;
img1 = imread('Lenanoise.png');
img2 = imread('Lena.png');
img1 = int16(img1);
img2 = int16(img2);
%img1 = int16(img1);
%imshow(img1)
[rows,columns] = size(img1);
state = 32;
scale = 255 / state;

for i = 1:rows
    for j = 1:columns
        img1(i,j) = round(img1(i,j) / scale);
        img2(i,j) = round(img2(i,j) / scale);
    end
end

%imshow(img1)
%mPotentialFunc = 'L1';
%imshow(uint8(im))



wrapN = @(x, N) (1 + mod(x-1, N));

lambda_data = 0.9;
lambda_smooth = 0.8;
step = 1;
% 
% switch mPotentialFunc
%     case 'L2'
%         PL2 = -lambda_data * (img1-img2).^2;
%     case 'L1'
%         PL1 = -lambda_data * abs(img1-img2);
% end
% 
% for i = 1:N-1
%     switch mPotentialFunc
%         case 'L2'
%             Psi{i} = -lambda_smooth*Dist.^2;
%         case 'L1'
%             Psi{i} = -lambda_smooth*Dist;
%     end
%     %Psi{i} = -lambda_smooth*min(abs(foo-foo'),10);
% end

change_flag=1;    
count = 0;


% 
% for L1
while (change_flag && count < 500) 
    count = count + 1;
    change_flag=0; 
    disp(count);
    for i=1:rows
        for j=1:columns
            sum = 0;
            xi = img1(i,j);
            yi = img2(i,j);
            a = img1(wrapN(i - 1, rows), j);
            b = img1(i, wrapN(j + 1, columns));
            c = img1(wrapN(i + 1,rows), i);
            d = img1(i, wrapN(j - 1, columns));
            
            
            
            no_change = (-(lambda_data * abs(xi - yi))) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d)));
            no_change2 = double(no_change);
            no_change1 = double(no_change);
            no_change1 = exp(no_change1);

            xi = min(255, xi + step);  
            positive_change = (-lambda_data * abs(xi - yi)) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d)));
            xi = img1(i,j);
            xi = max(0, xi - step);
            negative_change = (-lambda_data * abs(xi - yi)) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d)));
            xi = img1(i,j);
            
            sum = sum + no_change1;
            no_change2 = no_change2 / sum;
            
            if positive_change > no_change
                change_flag = 1;
                img1(i,j) = min(255, xi + step);
            end
            if negative_change > no_change
                change_flag = 1;
                img1(i,j) = max(0, xi - step);
            end
         
        end
    end
    
end

% for L2
% while (change_flag && count < 1000) 
%     count = count + 1;
%     change_flag=0; 
%     disp(count);
%     for i=1:rows
%         for j=1:columns
%             xi = img1(i,j);
%             yi = img2(i,j);
%             a = img1(wrapN(i - 1, rows), j);
%             b = img1(i, wrapN(j + 1, columns));
%             c = img1(wrapN(i + 1,rows), i);
%             d = img1(i, wrapN(j - 1, columns));
%             
%             no_change = (-(lambda_data * abs(xi - yi))) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d))).^2;
%             xi = min(255, xi + step);  
%             pos_change = (-lambda_data * abs(xi - yi)) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d))).^2;
%             xi = img1(i,j);
%             xi = max(0, xi - step);
%             neg_change = (-lambda_data * abs(xi - yi)) - (lambda_smooth * (abs(xi - a) + abs(xi - b) + abs(xi - c) + abs(xi - d))).^2;
%             xi = img1(i,j);
%             
%             if pos_change > no_change
%                 change_flag = 1;
%                 img1(i,j) = min(255, xi + step);
%             end
%             if neg_change > no_change
%                 change_flag = 1;
%                 img1(i,j) = max(0, xi - step);
%             end
%          
%         end
%     end
%     
% end

for i = 1:rows
    for j = 1:columns
        img1(i,j) = round(img1(i,j) * scale);
        img2(i,j) = round(img2(i,j) * scale);
    end
end

imshow(uint8(img1))

%correct = imread('images/lena.png');

% Calculate Accuracy
%accuracy = 1 - (sum(sum(abs(img1 - img2))) / (rows * columns));

counter = 0;
for i = 1:rows
    for j = 1:columns
        if img1(i,j) == img2(i,j)
            counter = counter + 1;
        end
    end
end
accuracy = counter / (rows*columns);
disp(accuracy);
% Display
%imshow(img1);

% Show original
%figure();
%imshow(uint8(y));
