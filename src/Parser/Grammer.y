{
module Parser.Grammer where
import Parser.Tokens
import Program
}

%name parse
%tokentype { Token }
%error { parseError }

%token
  register { TokenRegister $$ }
  label    { TokenLabel $$ }
  colon    { TokenColon }
  arrow    { TokenArrow }
  halt     { TokenHalt }
  incr     { TokenIncr }
  decr     { TokenDecr }
  comma    { TokenComma }
  '\n'     { TokenNewLine }

%%

Program
  : Instruction '\n' Program { $1 : $3 }
  | '\n' Program             { $2 }
  | Instruction              { [$1] }
  | {- empty -}              { [] }


Instruction
  : label colon register incr arrow label             { Incr $3 $6 }
  | label colon register decr arrow label comma label { Decr $3 ($6, $8) }
  | label colon halt                                  { Halt }
  | register incr arrow label                         { Incr $1 $4 }
  | register decr arrow label comma label             { Decr $1 ($4, $6) }
  | halt                                              { Halt }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
