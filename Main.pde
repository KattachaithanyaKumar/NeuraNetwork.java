NeuralNetwork nn = new NeuralNetwork(2,2,1);

void setup()  {
    size(500,500);
    
    double[] inputs = {0.05, 0.10};
    
    Matrix output = nn.feedforward(inputs);
    output.displayMatrix();
    exit();
}


void draw()  {
    
}
