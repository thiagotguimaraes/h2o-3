setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")

# Test PCA on car.arff.txt
test.pca.slow <- function() {

  data = h2o.uploadFile(locate("bigdata/laptop/jira/re0.wc.arff.txt.zip"),destination_frame = "data",header = T)
  data = data[,-2887]

  data2 = as.data.frame(data)
  print("Running R PCA...")
  ptm <- proc.time()
  fitR <- prcomp(data2, center = T, scale. = T)
  timepassed = proc.time() - ptm
  print(timepassed)

  #  ptm <- proc.time()
  print("Running H2O PCA with GLRM...")
  mm = h2o.prcomp(data,transform = "STANDARDIZE",k =1504, pca_method="GLRM", use_all_factor_levels=TRUE)
  h2otimepassed = proc.time() - ptm
  print(h2otimepassed)
  h2o.rm(mm)
  h2o.rm(data)

  print("Running H2O PCA with Randomized...")
  ptm <- proc.time()
  mm = h2o.prcomp(data,transform = "STANDARDIZE",k =1504, max_iterations=10, pca_method="Randomized")
  h2otimepassed = proc.time() - ptm
  print(h2otimepassed)
  h2o.rm(mm)

  print("Running H2O PCA with GramSVD...")
  ptm <- proc.time()
  mm = h2o.prcomp(data,transform = "STANDARDIZE",k =1504, pca_method="GramSVD")
  h2otimepassed = proc.time() - ptm
  print(h2otimepassed)
  h2o.rm(mm)

  print("Running H2O PCA with Power...")
  ptm <- proc.time()
  mm = h2o.prcomp(data,transform = "STANDARDIZE",k =1504, pca_method="Power")
  h2otimepassed = proc.time() - ptm
  print(h2otimepassed)
  h2o.rm(mm)
}

doTest("PCA Test: rec0.wc.arff.txt", test.pca.slow)
