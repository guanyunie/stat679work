#chromosome2
#(a)
a = read.table("trees/RAxML_RF-Distances.chr2dist")
colnames(a) = c("block1", "block2", "distance", "scaled")
n = 216
set.seed(1001)
#produce the random sequence under the distribution.
S = rpois(10000, lambda = 1/8)
D = 2*(n-3-S)
#plot the density of the the theoretical distribution.
plot(density(D, bw = 2), xlim = c(350, 427), main = "chromosome2 part(a) with mean")
#plot the empirical distribution.
lines(density(a$distance, bw = 2), col = "red")
mean_D = mean(D)
mean_observed = mean(a$distance)
# add the mean line.
abline(v = mean_D, lty = 3)
abline(v = mean_observed, col = "red", lty =3)
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("D", "observed"))

#For chr2, yes, the observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly.

#(b)
a$block2 = as.integer(gsub("(\\d):", "\\1", a$block2))
a = a[which(abs(as.vector(a$block1) - as.vector(a$block2)) == 1),]
#plot the consecutive one.
plot(density(a$distance, bw = 5), xlim = c(200, 440), ylim = c(0,0.05), main = "chromosome2 part(b) with mean")
mean_consecutive = mean(a$distance)
a = read.table("trees/RAxML_RF-Distances.chr2dist")
colnames(a) = c("block1", "block2", "distance", "scaled")
#plot the random one.
lines(density(a$distance, bw = 5), col = "red")
mean_randomly = mean(a$distance)
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("consecutive", "randomly chosen"))
abline(v = mean_consecutive, lty = 3)
abline(v = mean_randomly, col = "red", lty = 3)

# For chr2, yes, trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks.

#chromosomeC
#(a)
a = read.table("trees/RAxML_RF-Distances.chrCdist")
colnames(a) = c("block1", "block2", "distance", "scaled")
n = 216
set.seed(1001)
S = rpois(10000, lambda = 1/8)
D = 2*(n-3-S)
plot(density(D, bw = 1), xlim = c(360, 440), main = "chromosomeC part(a) with mean")
lines(density(a$distance, bw = 1), col = "red")
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("D", "observed"))
mean_D = mean(D)
mean_observed = mean(a$distance)
abline(v = mean_D, lty = 3)
abline(v = mean_observed, col = "red", lty = 3)

#For chrC, yes, the observed tree distances are closer to 0 than expected if the 2 trees were chosen at random uniformly.

#(b)
a$block2 = as.integer(gsub("(\\d):", "\\1", a$block2))
a = a[which(abs(as.vector(a$block1) - as.vector(a$block2)) == 1),]
plot(density(a$distance, bw = 5), xlim = c(360, 440), ylim = c(0,0.05), main = "chromosomeC part(b) with mean")
mean_consecutive = mean(a$distance)
a = read.table("trees/RAxML_RF-Distances.chrCdist")
colnames(a) = c("block1", "block2", "distance", "scaled")
lines(density(a$distance, bw = 5), col = "red")
mean_randomly = mean(a$distance)
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("consecutive", "randomly chosen"))
abline(v = mean_consecutive, lty = 3)
abline(v = mean_randomly, col = "red", lty = 3)

# For chrC, yes, trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks, but the trend is much less than that of chr2.

#chromosomeM
#(a)
a = read.table("trees/RAxML_RF-Distances.chrMdist")
colnames(a) = c("block1", "block2", "distance", "scaled")
n = 216
set.seed(1001)
S = rpois(10000, lambda = 1/8)
D = 2*(n-3-S)
plot(density(D, bw = 0.5), xlim = c(400, 430), main = "chromosomeM part(a) with mean")
lines(density(a$distance, bw = 0.5), col = "red")
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("D", "observed"))
mean_D = mean(D)
mean_observed = mean(a$distance)
abline(v = mean_D, lty = 3)
abline(v = mean_observed, col = "red", lty = 3)

#For chrM, yes, the observed tree distances closer to 0 than expected if the 2 trees were chosen at random uniformly, but the trend is much less than that of chr2.

#(b)
a$block2 = as.integer(gsub("(\\d):", "\\1", a$block2))
a = a[which(abs(as.vector(a$block1) - as.vector(a$block2)) == 1),]
plot(density(a$distance, bw = 0.5), xlim = c(400, 430), ylim = c(0,0.6), main = "chromosomeM part(b) with mean")
mean_consecutive = mean(a$distance)
a = read.table("trees/RAxML_RF-Distances.chrMdist")
colnames(a) = c("block1", "block2", "distance", "scaled")
lines(density(a$distance, bw = 0.5), col = "red")
mean_randomly = mean(a$distance)
legend("topleft", lty = c(1, 1), col = c("black", "red"), c("consecutive", "randomly chosen"))
abline(v = mean_consecutive, lty = 3)
abline(v = mean_randomly, col = "red", lty = 3)

#For chrM, yes, trees from 2 consecutive blocks tend to be more similar to each other than trees from 2 randomly chosen blocks, but the trend is much less than that of chr2.
