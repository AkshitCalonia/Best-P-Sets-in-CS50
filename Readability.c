#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <ctype.h>
#include <math.h>

float grade_check(string s);

int main(void)
{

    string text = get_string("Text : ");
    int grade = round(grade_check(text));
    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", grade);
    }

}

float grade_check(string s)
{
    int n = strlen(s);
    int words = 1;
    int letters = 0;
    int sentences = 0;

    for (int i = 0; i<n; i++)
    {
        if (isalpha(s[i]))
        {
            letters++;
        }
        else if (isspace(s[i]))
        {
            words++;
        }

        else if ((s[i] == '.') || (s[i] == '!') || (s[i] == '?'))
        {
            sentences++;
        }
        else
        {
            //Do Nothing
        }
    }
    return ((0.0588 * ((letters*100)/ (float) words)) - (0.296 * ((sentences*100)/ (float) words)) - 15.8);
}
