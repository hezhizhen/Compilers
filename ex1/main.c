int main(int argc, char** argv)
{
    if(argc > 1)
    {
        if(!(yyin = fopen(argv[1],"r'")))
        {
            perror(argv[1]);
            return 1;
        }
    }
    yylex();
    printf("%8d%8d%8d\n",lines, words, chars);
    return 0;
}
