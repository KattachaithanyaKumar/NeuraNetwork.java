
class Matrix {
  int rows = 1;
  int cols = 1;
  double[][] data = new double[rows][cols];

  Matrix(int r, int c)  {
    rows = r;
    cols = c;
    data = new double[rows][cols];
    
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        data[i][j] = 0;
      }
    }
 
  }
  
  Matrix arrayToMatrix(int[] n)  {
    Matrix m = new Matrix(n.length, 1);
    for (int i = 0; i < n.length; i++)  {
      m.data[i][0] = n[i]; 
    }
    return m;
  }
  
  void displayMatrix()  {
    println("displaying matrix!");
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        print("| " + data[i][j] + "\t |");
      }
      print("\n");
    }
  }
  
  void randomize()  {
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        data[i][j] = (random(-1, 1));
      }
    }
  }
  
  void addNum(int n)  {
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        data[i][j] += n;
      }
    }
  }
  
  void addMatrix(Matrix n)  {
    if (rows != n.rows || cols != n.cols)  {
      println("ERROR: rows and cols should match");
      exit();
    }else{
      for (int i = 0; i < rows; i++)  {
        for (int j = 0; j < cols; j++)  {
          data[i][j] += n.data[i][j];
        }
      }
    }
  }
  
  void multiplyNum(int n)  {
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        data[i][j] *= n;
      }
    }
  }
  
 
 Matrix multiply(Matrix b)  {
   if (cols != b.rows)  {
     println("cols of a must match rows of b");
     println("A cols: " + cols);
     println("B rows: " + b.rows);
     exit();
   }  
   Matrix result = new Matrix(rows, b.cols);
    for (int i = 0; i < result.rows; i++)  {
      for (int j = 0; j < result.cols; j++)  {
        int sum = 0;
        for (int k = 0; k < cols; k++)  {
          sum += data[i][k] * b.data[k][j];
        }
        result.data[i][j] = sum;
      }
    }
    return result;  
  }
  
  Matrix transpose()  {
    Matrix result = new Matrix(cols, rows);
    
    for (int i = 0; i < rows; i++)  {
      for (int j = 0; j < cols; j++)  {
        result.data[j][i] = data[i][j]; 
      }
    }
    
    return result;
  }
  
}
