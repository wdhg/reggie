module Main where

import System.Environment
import Parser
import Program
import Encode

runProgram :: Bool -> String -> [String] -> IO ()
runProgram showSteps filename arguments
  = do
    contents <- readFile filename
    let registers = zip [0..] $ map read arguments
        program = Program $ parse $ tokenize contents
    memory <- run showSteps program registers
    print memory

main :: IO ()
main
  = do
    args <- getArgs
    case args of
      ("run" : filename : arguments) -> runProgram False filename arguments
      ("step" : filename : arguments) -> runProgram True filename arguments
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ Program $ parse $ tokenize contents
      ["decode", encoding] -> do
        print (decode $ read encoding :: Program)
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " <run|encode|decode> <program|encoding> [initial state]"
