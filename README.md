# ImageDenoise

BayesNoise.m and LenaNoise to denoise Bayesnoise_grayscale.png and Lenanoise.png respectively.


For Bayes image, following theory is applied:

The final energy function for the model takes the form E(x,y)=h∑xi −β∑xixj −η∑xiyi
i {i,j} i which defines a joint distribution over x and y given by
p(x, y) = 1 exp{−E(x, y)} Z
Now implement Coordinate-descent algorithm as below on this: 1. Initialize {xi} (xi = yi)
2. Loop over {xi}. For each xi, fix the neighborhood and see whether −xi would decrease the energy. If so, then flip xi; otherwise, continue.
3. Stop when no changes can be made for x.

For Lena image, following theory is applied:

Our graphical model is a simple pairwise MRF defined as
p(X|Y,λ ,λ )= 1 exp{−λ ∑ρ(x −y)−λ ∑ ρ(x −x )}
ddZdiisij i (i,j )∈ε
 where X = {xi} is the set of all the pixels in the image to restore, Y = {yi} denotes the input noisy image, i indexes the image lattice, ε is the set of all the edges (only adjacent pixels are considered), λd and λs are coefficients weighing the data term and smoothness term, respectively. ρ(·) is a penalty function. You can use ρ(z) = |z| (L1 norm) and ρ(z) = z2 (L2 norm).
