public class Exemplo_GetMessage {

    public static void main(String[] args) {
      try {
        int[] numero = new int[5];
  
        for(int i = 0; i <= 10; i++){
          numero[i] = i;
          System.out.println(i);
        }
      } catch (ArrayIndexOutOfBoundsException e) {
        System.out.println("Array fora do índice: "+e.getMessage());
      }
    }
  }