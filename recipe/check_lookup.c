#include <string.h>
#include "lookup.c"

int main(void) {
    const char *words[] = {"fontconfig", "cairo", "arm64"};
    unsigned int i;
    for (i = 0; i < sizeof(words) / sizeof(words[0]); ++i) {
        const char *found = in_word_set(words[i], strlen(words[i]));
        if (!found || strcmp(found, words[i]) != 0) return 1;
    }
    return in_word_set("missing", 7) != 0;
}
