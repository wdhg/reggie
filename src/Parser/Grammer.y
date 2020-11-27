{
module Parser.Grammer where

import Parser.Tokens
import Program (Instruction(..), Label(..))
import Data.Map (empty, insert)
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
  : Instruction '\n' Program { insert (fst $1) (snd $1) $3 }
  | '\n' Program             { $2 }
  | Instruction              { insert (fst $1) (snd $1) empty }
  | {- empty -}              { empty }


Instruction
  : label colon register incr arrow label             { (Label $1, Incr $3 (Label $6)) }
  | label colon register decr arrow label comma label { (Label $1, Decr $3 (Label $6, Label $8)) }
  | label colon halt                                  { (Label $1, Halt) }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
