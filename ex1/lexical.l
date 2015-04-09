%{
    /*此处省略#include部分*/
    int chars = 0;
    int words = 0;
    int lines = 0;
%}

letter [a-zA-Z]

%%

{letter} + {words++; chars+=yyleng;}
\n {chars++;lines++;}
. {chars++;}

%%

int main(int argc, char** argv)
{
    int i, totchars = 0, totwords = 0, totlines = 0;
    if(argc < 2) /* just read stdin */
    {
        yylex();
        printf("%8d%8d%8d\n", lines, words, chars);
        return 0;
    }
    for(i = 1;i < argc; i++)
    {
        FILE *f = fopen(argv[i],"r");
        if(!f)
        {
            perror (argv[i]);
            return 1;
        }
        yyrestart(f);
        yylex();
        fclose(f);
        printf("%8d%8d%8d %s\n",lines, words, chars, argv[i]);
        totchars += chars; chars = 0;
        totwords += words; words = 0;
        totlines += lines; lines = 0;
    }
    if(argc > 1)
    {
        printf("%8d%8d%8d total\n", totlines, totwords, totchars);
    }
    return 0;
}
