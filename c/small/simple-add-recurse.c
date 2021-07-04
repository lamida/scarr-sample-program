#include <stdio.h>
int addRecurse(int a, int b) {
    if (a == 0) return b;
    return addRecurse(a - 1, b + 1);
}

int main() {
    int x = addRecurse(10, 1);
    printf("%d\n", x;)
}
