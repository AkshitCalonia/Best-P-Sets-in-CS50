#include <stdio.h>
#include <stdlib.h>
#include <cs50.h>
#include <ctype.h>

typedef struct node
{
    char *phrase;
    struct node *next;
}
node;

int hash_func(char *phrase);

int main(void)
{
    node *table[26];
    //initializing all value of table array to point to NULL -
    for (int i = 0; i<26; i++)
    {
        table[i] = NULL;
    }
    int inp = get_int("How many nodes to add to the hash table : ");
    for (int i = 0; i<inp; i++)
    {
        char *phr = get_string("Enter phrase : ");
        int index = hash_func(phr);

        node *n = malloc(sizeof(node));
        n->phrase = phr;
        n->next = table[index];
        table[index] = n;
    }
}

int hash_func(char *phrase)
{
    return toupper(phrase[0]) - 'A';
}
