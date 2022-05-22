

void setup()  {
    NeuralNetwork nn = new NeuralNetwork(2,2,1);
    
    
    double[] inputs = {0, 1};
    double[] targets = {1};
    
    double[] inputs1 = {1, 0};
    double[] targets1 = {1};
    
    double[] inputs2 = {1, 1};
    double[] targets2 = {0};
    
    double[] inputs3 = {0, 0};
    double[] targets3 = {0};
    
    for (int i = 0; i < 100; i++)  {
      //training
      int ran = floor(random(4));
      switch (ran)  {
        case 0: 
        nn.train(inputs, targets);
        break;
        
        case 1:
        nn.train(inputs1, targets1);
        break;
        
        case 2:
        nn.train(inputs2, targets2);
        break;
        
        case 3:
        nn.train(inputs3, targets3);
        break;
      }
      
    }
    
    println("\n the checking");
    Matrix one = nn.feedforward(inputs);
    Matrix two = nn.feedforward(inputs1);
    Matrix three = nn.feedforward(inputs2);
    Matrix four = nn.feedforward(inputs3);
    
    //one.multiplyNum(100);
    //two.multiplyNum(100);
    //three.multiplyNum(100);
    //four.multiplyNum(100);
    
    one.displayMatrix();
    two.displayMatrix();
    three.displayMatrix();
    four.displayMatrix();
    
    exit();
}


void draw()  {
    
}
