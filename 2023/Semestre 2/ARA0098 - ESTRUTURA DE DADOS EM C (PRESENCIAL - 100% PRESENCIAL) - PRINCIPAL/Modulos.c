#include <stdio.h>
#include <string.h>

// Função que retorna a quantidade de caracteres em uma string
int contarCaracteres(char str[]) {
    return strlen(str);
}

// Procedimento para determinar se um número é par ou ímpar
void verificarParImpar(int num) {
    if (num % 2 == 0) {
        printf("O número %d é par.\n", num);
    } else {
        printf("O número %d é ímpar.\n", num);
    }
}

int main() {
    char frase[100];
    int numero;

    // Coleta e processa uma string
    printf("Digite uma frase: ");
    fgets(frase, sizeof(frase), stdin);
    frase[strcspn(frase, "\n")] = 0;  // Retira o '\n' do final da string
    printf("A frase tem %d caracteres.\n", contarCaracteres(frase));

    // Coleta e processa um número
    printf("Digite um número: ");
    scanf("%d", &numero);
    verificarParImpar(numero);

    return 0;
}



// Neste código:

// A função 'contarCaracteres' é usada para calcular a quantidade de caracteres em uma string.
// O procedimento 'verificarParImpar' é usado para determinar e exibir se um número é par ou ímpar.