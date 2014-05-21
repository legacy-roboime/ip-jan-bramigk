#include <fann.h>

int main() {

  // 4 inputs, 8 hidden nodes, 4 outputs
  //   \- - - - 3 layers - - - - - /
  //
  struct fann *ann = fann_create_standard(3, 4, 8, 4);
  fann_set_activation_function_hidden(ann, FANN_SIGMOID_SYMMETRIC);
  fann_set_activation_function_output(ann, FANN_SIGMOID_SYMMETRIC);

  const unsigned int max_epochs = 500000;
  const unsigned int epoch_step = 1000;
  const float desired_error = 0.001;
  fann_train_on_file(ann, "train.data", max_epochs, epoch_step, desired_error);
  fann_save(ann, "train.net");
  fann_destroy(ann);

  return 0;
}
