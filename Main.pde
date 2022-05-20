NeuralNetwork nn = new NeuralNetwork(2,2,2);

void setup()  {
    size(500,500);
    
    double[] inputs = {0.05, 0.10};
    double[] answers = {1, 0};
    
    //Matrix output = nn.feedforward(inputs);
    //output.displayMatrix();
  
    nn.train(inputs,answers);
    
    exit();
}


void draw()  {
    
}
