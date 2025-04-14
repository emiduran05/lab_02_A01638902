%}

%union {
    double dval;
    char sval;
}

%token <sval> ID
%token <dval> NUMBER
%token FLOAT PRINT INT
%type <dval> expression term factor

%left '+' '-'
%left '*' '/'


%%

input:
      /* Empty String */
    | input line
    ;

line:
      '\n'
    | statement '\n'
    ;

statement:
      FLOAT ID                  { }
    | INT ID                    { }
    | ID '=' expression         { varvalue[$1 - 'a'] = $3; }
    | PRINT ID                  { printf("%f\n", varvalue[$2 - 'a']); }
    ;

expression:
      term
    | expression '+' term       { $$ = $1 + $3; }
    | expression '-' term       { $$ = $1 - $3; }
    ;

term:
      factor
    | term '*' factor           { $$ = $1 * $3; }
    | term '/' factor           { $$ = $1 / $3; }
    ;

factor:
      NUMBER                    { $$ = $1; }
    | ID                        { $$ = varvalue[$1 - 'a']; }
    | '(' expression ')'        { $$ = $2; }
    ;

%%


int main(int argc, char **argv) {
    FILE *fd;

    if (argc == 2) {
        if (!(fd = fopen(argv[1], "r"))) {
            perror("Error: ");
            return -1;
        }
        yyset_in(fd);
        yyparse();
        fclose(fd);
    } else {
        printf("Usage: %s filename\n", argv[0]);
    }
    return 0;
}


         
