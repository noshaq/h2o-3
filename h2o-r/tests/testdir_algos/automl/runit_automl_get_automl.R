setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")

automl.get.automl.test <- function() {

    # Load data and split into train, valid and test sets
    train <- h2o.uploadFile(locate("smalldata/testng/higgs_train_5k.csv"),
    destination_frame = "higgs_train_5k")
    test <- h2o.uploadFile(locate("smalldata/testng/higgs_test_5k.csv"),
    destination_frame = "higgs_test_5k")
    ss <- h2o.splitFrame(test, seed = 1)
    valid <- ss[[1]]
    test <- ss[[1]]

    y <- "response"
    x <- setdiff(names(train), y)
    train[,y] <- as.factor(train[,y])
    test[,y] <- as.factor(test[,y])
    max_runtime_secs <- 10
    max_models <- 2

    aml1 <- h2o.automl(y = y,
                        training_frame = train,
                        max_runtime_secs = max_runtime_secs,
                        project_name = "aml1")

    #Use h2o.getAutoML to get previous automl instance
    get_aml1 <- h2o.getAutoML(aml1@automl_key)
    
    expect_equal(aml1@project_name, get_aml1@project_name)
    expect_equal(aml1@automl_key, get_aml1@automl_key)
    expect_equal(aml1@leader, get_aml1@leader)
    expect_equal(aml1@leaderboard, get_aml1@leaderboard)

}

doTest("AutoML h2o.getAutoML Test", automl.get.automl.test)