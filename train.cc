#include <fann.h>

int main() {

  // 5 inputs, 6 hidden nodes, 4 outputs
  //   \- - - - 3 layers - - - - - /
  //
  struct fann *ann = fann_create_standard(3, 5, 6, 4);
  fann_set_activation_function_hidden(ann, FANN_SIGMOID_SYMMETRIC);
  fann_set_activation_function_output(ann, FANN_SIGMOID_SYMMETRIC);

  const unsigned int max_epochs = 50000;
  const unsigned int epoch_step = 100;
  const float desired_error = 5.0;
  fann_train_on_file(ann, "train.data", max_epochs, epoch_step, desired_error);
  fann_save(ann, "train.net");
  fann_destroy(ann);

  return 0;
}
