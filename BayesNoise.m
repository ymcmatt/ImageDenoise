
cd Bayes_Lena_Images;
%S = dir(fullfile(dir,'Bayesnoise_grayscale.png'));
img1 = imread('Bayesnoise_grayscale.png');
img2 = imread('Bayes_grayscale.png');
[rows,columns] = size(img1);
img = zeros(rows,columns);
img3 = zeros(rows,columns);
beta = 2.1;
h = 1.4;
eta = 4.5;
for i = 1:rows
    for j = 1:columns
        if img1(i,j) == 0
            img(i,j) = -1;
        else
            img(i,j) = 1;
        end
        
    end
end

for i = 1:rows
    for j = 1:columns
        if img2(i,j) == 0
            img3(i,j) = -1;
        else
            img3(i,j) = 1;
        end
    end
end

for i = 1:rows
    for j = 1:columns
        xi = img(i,j);
        val = 0;
        hxi = h * xi;
        if i-1 >= 1
            val = val + xi * img(i-1,j);
        end
        if i+1 <= rows
            val = val + xi * img(i+1,j);
        end
        if j-1 >= 1
            val = val + xi * img(i,j-1);
        end
        if j+1 <= columns
            val = val + xi * img(i,j+1);
        end
        val = beta * val;
            
        etafunc = eta * xi * img2(i,j);
        energyfunc1 = hxi - val - etafunc;
        
        % flip xi
        minusxi = 0;
        if img(i,j) == 1
            minusxi = -1;
        end
        if img(i,j) == -1
            minusxi = 1;
        end
        val1 = 0;
        hxi = h * minusxi;
        if i-1 >= 1
            val1 = val1 + minusxi * img(i-1,j);
        end
        if i+1 <= rows
            val1 = val1 + minusxi * img(i+1,j);
        end
        if j-1 >= 1
            val1 = val1 + minusxi * img(i,j-1);
        end
        if j+1 <= columns
            val1 = val1 + minusxi * img(i,j+1);
        end
        val1 = beta * val1;
            
        etafunc2 = eta * minusxi * img2(i,j);
        energyfunc2 = hxi - val1 - etafunc2;
        
        if energyfunc2 < energyfunc1
            img(i,j) = img(i,j) * -1;
        end   
    end
end
imshow(img);

counter = 0;
for i = 1:rows
    for j = 1:columns
        if img(i,j) == img3(i,j)
            counter = counter + 1;
        end
    end
end
accuracy = counter / (rows*columns);
disp(accuracy);
