#include "../printk.h"

int ft_puthex_padded(unsigned int num, int width, char format, int output) {
    int nb_caracter = 0;
    char *base;
    char buffer[8];

    if (format == 'x')
        base = "0123456789abcdef";
    else
        base = "0123456789ABCDEF";

    for (int i = width - 1; i >= 0; i--) {
    buffer[i] = base[num % 16];
    num = num / 16;
    }
    for (int i = 0; i < width; i++)
        nb_caracter += ft_kputchar(buffer[i], output);
    return nb_caracter;
}
