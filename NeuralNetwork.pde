//activation function
double sigmoid(double x)  {
  return (1/( 1 + Math.pow(Math.E,(-1*x))));
}

class NeuralNetwork  {
  int input_nodes = 0;
  int hidden_nodes = 0;
  int output_nodes = 0;  
  
  Matrix weights_ih;
  Matrix weights_ho;
  
  Matrix bias_h;
  Matrix bias_o;
  
  double learning_rate = 0.1;
  
  NeuralNetwork(int in, int hi, int ou)  {
    this.input_nodes = in;
    this.hidden_nodes = hi;
    this.output_nodes = ou;
    
    //initializing weights
    this.weights_ih = new Matrix(this.hidden_nodes, this.input_nodes);
    this.weights_ho = new Matrix(this.output_nodes, this.input_nodes);
    this.weights_ih.randomize();
    this.weights_ho.randomize();
    //println("the weights input -> hidden");
    //weights_ih.displayMatrix();
    
    //println("the weights hidde -> outputs");
    //weights_ho.displayMatrix();
     
    //initializing bias
    this.bias_h = new Matrix(this.hidden_nodes, 1);
    this.bias_o = new Matrix(this.output_nodes, 1);
    this.bias_h.randomize();
    this.bias_o.randomize();
  
    //println("the bias for hidden");
    //bias_h.displayMatrix();
    //println("the bias for output");
    //bias_o.displayMatrix();
  }
  
  
  //feedforward
  Matrix feedforward(double[] inputs)  {
    //convert array input to matrix
    Matrix inp = new Matrix(inputs.length, 1);
    for (int i = 0; i < inputs.length; i++)  {
      inp.data[i][0] = inputs[i]; 
    }
    
    Matrix hidden = this.weights_ih.multiply(inp);
    hidden.addMatrix(this.bias_h);
    
    //activation function
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        hidden.data[i][j] = sigmoid(hidden.data[i][j]);
      }
    }
    
    //hidden layer to output layer
    Matrix output = this.weights_ho.multiply(hidden);
    output.addMatrix(this.bias_o);
    
    //activation function for output layer
    for (int i = 0; i < output.rows; i++)  {
      for (int j = 0; j < output.cols; j++)  {
        output.data[i][j] = sigmoid(output.data[i][j]);
      }
    }
    return output;
  }
  
  
  void train(double[] inputs, double[] answers)  {
    //convert array input to matrix
    Matrix inp = new Matrix(inputs.length, 1);
    for (int i = 0; i < inputs.length; i++)  {
      inp.data[i][0] = inputs[i]; 
    }
    
    Matrix hidden = this.weights_ih.multiply(inp);
    hidden.addMatrix(this.bias_h);
    
    //activation function
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        hidden.data[i][j] = sigmoid(hidden.data[i][j]);
      }
    }
    //hidden layer to output layer
    Matrix outputs = this.weights_ho.multiply(hidden);
    outputs.addMatrix(this.bias_o);
    
    //activation function for output layer
    for (int i = 0; i < outputs.rows; i++)  {
      for (int j = 0; j < outputs.cols; j++)  {
        outputs.data[i][j] = sigmoid(outputs.data[i][j]);//changed the hidden.data to output.data
      }
    }
    
    
    Matrix targets = new Matrix(answers.length, 1);
    for (int i = 0; i < answers.length; i++)  {
      targets.data[i][0] = answers[i];
    }
    
    //calculate the output errors 
    Matrix out_errors = targets.subtractMatrix(outputs);
    
    //calculate gradient for outputs
    Matrix gradient = new Matrix(outputs.rows, outputs.cols);
    for (int i = 0; i < outputs.rows; i++)  {
      for (int j = 0; j < outputs.cols; j++)  {
        gradient.data[i][j] = sigmoid(outputs.data[i][j]) * (1 - sigmoid(outputs.data[i][j]));
      }
    }
    
    //calculate the gradient
    gradient.elimMult(out_errors);
    gradient.multiplyNum(this.learning_rate);
    
    //calculate deltas
    Matrix hidden_t = hidden.transpose();
    Matrix weights_ho_delta = gradient.multiply(hidden_t);
    
    //adjust the weights by the deltas
    this.weights_ho.addMatrix(weights_ho_delta);
    //adjust the bias by its deltas (gradient)
    this.bias_o.addMatrix(gradient);
    
    //calculate the hidden errors
    Matrix weights_ho_t = this.weights_ho.transpose();
    Matrix hidden_errors = weights_ho_t.multiply(out_errors);//multiply -> elimMult
    
    
    //calculate the hidden gradient
    Matrix hidden_gradient = new Matrix(hidden.rows, hidden.cols);
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        hidden_gradient.data[i][j] = sigmoid(hidden.data[i][j]) * (1 - sigmoid(hidden.data[i][j]));
      }
    }
    
    hidden_gradient.multiply(hidden_errors.transpose());//added transpose
    hidden_gradient.multiplyNum(this.learning_rate);
    
    //calculate input -> hidden deltas
    Matrix inputs_t = inp.transpose();
    Matrix weights_ih_delta = hidden_gradient.multiply(inputs_t);
    
    
    this.weights_ih.addMatrix(weights_ih_delta);
    //adjust the bias its deltas (hidden_gradient)
    this.bias_h.addMatrix(hidden_gradient);
  }
}
