#!/usr/bin/env python
# -*- encoding: utf-8 -*-
import h2o
from h2o.estimators.glm import H2OGeneralizedLinearEstimator
from tests import pyunit_utils


def test_benign():
    training_data = h2o.import_file(pyunit_utils.locate("smalldata/gbm_test/BostonHousing.csv"))
    My_model_id = ' test -  june/fifteenth '
    My_model_id = "Wendy /Wong"

    Y = 13
    X = list(range(13))

    model = H2OGeneralizedLinearEstimator(family="Gaussian", nfolds=2, fold_assignment="Modulo", keep_cross_validation_predictions=True, model_id=My_model_id)
    model.train(x=X, y=Y, training_frame=training_data)
    print("Wow")


if __name__ == "__main__":
    pyunit_utils.standalone_test(test_benign)
else:
    test_benign()
