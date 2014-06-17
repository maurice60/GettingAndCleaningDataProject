library(reshape2)

datTest <- read.table("X_test.txt")
datTrain <- read.table("X_train.txt")
datHeadings <- read.table("features.txt")
actLabel <- read.table("activity_labels.txt")
subTest <- read.table("subject_test.txt")
subTrain <- read.table("subject_train.txt")
actTest <- read.table("y_test.txt")
actTrain <- read.table("y_train.txt")

datTest <- cbind(actTest, subTest, datTest)
datTrain <- cbind(actTrain, subTrain, datTrain)
datMerge <- rbind(datTest, datTrain)

names(datMerge) <- c("activityCode", "subject", as.vector(datHeadings$V2))
names(actLabel) <- c("activityCode", "activity")

datMerge <- datMerge[,grep("subject|activityCode|-mean\\(|-std\\(", names(datMerge))]
datMerge <- merge(actLabel, datMerge)

datMelt <- melt(datMerge, id.vars = c("activityCode", "activity", "subject"))
datOutput <- dcast(datMelt, activityCode+activity+subject ~ variable, mean)

rm(datTest, datTrain, datHeadings, subTest, subTrain, actTest, actTrain, actLabel, datMelt, datMerge)
