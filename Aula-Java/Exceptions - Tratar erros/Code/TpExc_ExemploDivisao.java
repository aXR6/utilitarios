import java.util.InputMismatchException;
import java.util.Scanner;

public class ExemploDivisao {

  public static int calculaQuociente(int numerador, int denominador) throws ArithmeticException{
    return numerador / denominador;
  }

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);
    boolean continua = true;

    do{
      try{
        System.out.print("Numerador: ");
        int numerador = sc.nextInt();

        System.out.print("Denominador: ");
        int denominador = sc.nextInt();

        int resultador = calculaQuociente(numerador, denominador);
        System.out.println("Resultado: "+resultador);

        continua = false;

      }catch (InputMismatchException erro1) {
        System.err.println("Não é permitido inserir letras, informe apenas números inteiros!");
        sc.nextLine(); //descarta a entrada errada do usuário
      }catch(ArithmeticException erro2){
        System.err.println("O número do divisor deve ser diferente de 0!");
      }finally{
        System.out.println("Execução do Finally!");
      }
    }while(continua);
  }
}