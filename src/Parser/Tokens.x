{
  module Parser.Tokens where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]

tokens :-

  $white+     { \s -> checkWhitespace s }
  R [$digit]+ { \s -> TokenRegister $ read $ drop 1 s }
  L [$digit]+ { \s -> TokenLabel $ read $ drop 1 s }
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
  | TokenNewLine
  | TokenWhiteSpace
    deriving (Show, Eq)

checkWhitespace :: String -> Token
checkWhitespace s
  | '\n' `elem` s = TokenNewLine
  | otherwise     = TokenWhiteSpace

tokenize :: String -> [Token]
tokenize
  = filter (/= TokenWhiteSpace) . alexScanTokens
}
