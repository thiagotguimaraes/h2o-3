setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")
### This tests to fix the model extraction failure if backslash used in model name ######

test <- function() {
#	My_model_id = ' test -  june/fifteenth '
  My_model_id = 'wendy wong'
	boston = h2o.uploadFile(locate("smalldata/gbm_test/BostonHousing.csv"))
	browser()
	predictors = 1:13
	response = 14
	#interactions_list = ['crim', 'dis']
	boston_glm = h2o.glm(x = predictors, y = response,training_frame = boston, model_id = My_model_id,nfolds=2,family="gaussian",
	                                           fold_assignment="Modulo", keep_cross_validation_predictions=TRUE)
	print("wow")
}

doTest("GLM tweedie Test: GLM w/ offset and weights", test)
