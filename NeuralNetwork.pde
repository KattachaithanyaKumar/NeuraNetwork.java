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
  
  NeuralNetwork(int in, int hi, int ou)  {
    this.input_nodes = in;
    this.hidden_nodes = hi;
    this.output_nodes = ou;
    
    //initializing weights
    weights_ih = new Matrix(this.hidden_nodes, this.input_nodes);
    weights_ho = new Matrix(this.output_nodes, this.input_nodes);
    weights_ih.randomize();
    weights_ho.randomize();
     
    //initializing bias
    bias_h = new Matrix(this.hidden_nodes, 1);
    bias_o = new Matrix(this.output_nodes, 1);
    bias_h.randomize();
    bias_o.randomize();

  }
  
  
  //feedforward
  Matrix feedforward(double[] inputs)  {
    //convert array input to matrix
    Matrix inp = new Matrix(inputs.length, 1);
    for (int i = 0; i < inputs.length; i++)  {
      inp.data[i][0] = inputs[i]; 
    }
    
    Matrix hidden = weights_ih.multiply(inp);
    hidden.addMatrix(bias_h);
    
    
    //activation function
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        hidden.data[i][j] = sigmoid(hidden.data[i][j]);
      }
    }
    
    //hidden layer to output layer
    Matrix output = weights_ho.multiply(hidden);
    output.addMatrix(bias_o);
    
    //activation function for output layer
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        output.data[i][j] = sigmoid(hidden.data[i][j]);
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
    
    Matrix hidden = weights_ih.multiply(inp);
    hidden.addMatrix(bias_h);
    
    
    //activation function
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        hidden.data[i][j] = sigmoid(hidden.data[i][j]);
      }
    }
    
    //hidden layer to output layer
    Matrix outputs = weights_ho.multiply(hidden);
    outputs.addMatrix(bias_o);
    
    //activation function for output layer
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        outputs.data[i][j] = sigmoid(hidden.data[i][j]);
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
    //outputs.displayMatrix();
    for (int i = 0; i < hidden.rows; i++)  {
      for (int j = 0; j < hidden.cols; j++)  {
        gradient.data[i][j] = sigmoid(outputs.data[i][j]) * (1 - sigmoid(outputs.data[i][j]));
      }
    }
    //gradient.displayMatrix();
    
    //calculate the hidden errors
    Matrix weights_ho_t = weights_ho.transpose();
    Matrix hidden_errors = weights_ho_t.multiply(out_errors);
    
    
  }
}
