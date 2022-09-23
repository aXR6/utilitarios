import java.util.InputMismatchException;
import java.util.Scanner;

public class Exemplo_PrintStrackTrace {

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    try {
      System.out.print("Digite a idade: ");
      int idade = sc.nextInt();

      System.out.println(idade);
    } catch (InputMismatchException e) {
      e.printStackTrace();
    }
  }
}