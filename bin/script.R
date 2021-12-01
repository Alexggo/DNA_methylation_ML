library(tidyverse)
library(keras)

#The file has 656 rows and 473,037 columns. 
#The first column is sex (0:female, 1:male), 
#and the second column is age.


#Load data.
input_data<-read_csv("/gpfs/projects/BEE690/Datasets/out.csv",col_names = FALSE)

#Shuffling.
vector<-1:656
random<-sample(vector)
shuffled_data<-input_data[random,]

##Separate train and test.
#For age. 
x_train <- shuffled_data[1:525,3:437037] #80%, CpG data
y_train <- shuffled_data[1:525,2] #labels, age.
x_test <- shuffled_data[526:656,3:437037] #20%, CpG data
y_test <- shuffled_data[5256:656,2] #labels
#Single output, numerical value.

# For sex
x_train <- shuffled_data[1:525,3:437037] #80%, CpG data
y_train <- shuffled_data[1:525,1] #labels, sex
x_test <- shuffled_data[526:656,3:437037] #20%, CpG data
y_test <- shuffled_data[5256:656,1] #labels

#Ages.
y_train <- to_categorical(y_train, 2) 
y_test <- to_categorical(y_test, 2)

#Define the model
model <- keras_model_sequential() 
model %>% 
  layer_dense(units = 256, activation = 'relu', input_shape = c(784)) %>% 
  layer_dropout(rate = 0.4) %>% 
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = 'softmax')

 summary(model)

#Compile the model
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  metrics = c('accuracy')
)

#Training and evaluation
history <- model %>% fit(
  x_train, y_train, 
  epochs = 30, batch_size = 128, 
  validation_split = 0.2
)

plot(history)

#Evaluate
model %>% evaluate(x_test, y_test)

model %>% predict_classes(x_test)









