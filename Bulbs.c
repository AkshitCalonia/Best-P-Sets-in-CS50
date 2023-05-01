#include <cs50.h>
#include <stdio.h>
#include <string.h>

const int BITS_IN_BYTE = 8;

void print_bulb(int bit);

int main(void)
{
    // TODO
    string s = get_string("Message : ");

    int n = strlen(s);
    for (int i = 0; i < n; i++)
    {
        // declared k to iterate over the following array from its lats bit
        int k = 0;
        int temp[8] = {0, 0, 0, 0, 0, 0, 0, 0};
        int d = s[i];
        while (d != 1)
        {
            if (d % 2 == 1)
            {
                temp[7 - k] = 1;
                d = d / 2;
                k++;
            }
            else
            {
                temp[7 - k] = 0;
                d = d / 2;
                k++;
            }
        }
        // Remainder after dividing 1 by 2 will be 1 for all number at last
        temp[7 - k] = 1;

        // to print the array
        for (int m = 0; m < 8; m++)
        {
            print_bulb(temp[m]);
        }
        printf("\n");
    }
}



void print_bulb(int bit)
{
    if (bit == 0)
    {
        // Dark emoji
        printf("\U000026AB");
    }
    else if (bit == 1)
    {
        // Light emoji
        printf("\U0001F7E1");
    }
}
