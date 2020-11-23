{
  module Tokens where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-

  $white+     ;
  R [$digit]+ { \s -> TokenRegister $ drop 1 s }
  L [$digit]+ { \s -> TokenLabel $ drop 1 s }
  \-\>        { \s -> TokenArrow }
  HALT        { \s -> TokenHalt }
  \+          { \s -> TokenIncr }
  \-          { \s -> TokenDecr }
  \,          { \s -> TokenHalt }

{
data Token
  = TokenRegister Int
  | TokenLabel Int
  | TokenArrow
  | TokenHalt
  | TokenIncr
  | TokenDecr
  | TokenComma
    deriving (Show, Eq)

main
  = do
    s <- getContents
    print $ alexScanTokens s
}
