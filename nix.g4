grammar nix;

file: expr;

expr
    :
    function 
    | list 
    | attrset 
    | val
    | functionCall
    | with 
    ;

with
    : 'with' (val | expr) ';' (list | attrset | functionCall)
    ;

val
    : (valX | ('(' functionCall ')')) ( '.' (VARNAME | STRING))*
    ;

valX
    : VARNAME
    | (attrset '.' (VARNAME | STRING))
    | (list '[' NUMBER+ ']')
    | ( '(' expr ')' ) 
    | PATH
    | STRING
    | NUMBER
    ;

functionCall
    : (val expr+)
    ;

function
    : functionArg ':' expr
    ;

functionArg
    : VARNAME 
    | destruct
    ;

destruct
    : '{' destructAttr (',' destructAttr )* '}'
    ;

destructAttr
    : VARNAME 
    | '...'
    ;

list
    : '[' ( expr )* ']'
    ;

attrset
    : '{' (attr)* '}' 
    ;

attr
    : VARNAME '=' expr ';'
    ;

VARNAME
    : [a-zA-Z](WORD | [-])*
    ;

NUMBER
    : [0-9]+
    ;

STRING
    : '"' (~('"' | '\\' | '\r' | '\n') | '\\' ('"' | '\\'))* '"'
    | '\'\'' ('\n' | .)*? '\'\''
    | PATH
    ;

PATH
    : './' (WORD | [-/])*
    | '<' WORD+ '>'
    ;

WORD
    : [a-zA-Z0-9_]
    ;

WS
    : ( ' ' | '\r' | '\t' | '\n' )+ -> channel(1)
    ;

COMMENT
    : '/*' .*? '*/' -> channel(2)
;

LINE_COMMENT
    : '#' ~[\r\n]* -> channel(2)
;