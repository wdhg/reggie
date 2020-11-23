{
module Grammer where
import Tokens
import Program
}

%name parse
%tokentype { Token }
%error { parseError }

%token
  register { TokenRegister $$ }
  label    { TokenLabel $$ }
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
  : register incr arrow label             { Incr $1 $4 }
  | register decr arrow label comma label { Decr $1 ($4, $6) }
  | halt                                  { Halt }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
