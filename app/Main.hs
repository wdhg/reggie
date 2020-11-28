module Main where

import System.Environment
import Parser
import Program
import Encode

main :: IO ()
main
  = do
    args <- getArgs
    case args of
      ("run" : prog : arguments) -> do
        let registers = zip [0..] $ map read arguments
        contents <- readFile prog
        print $ runMem (Program $ parse $ tokenize contents) registers
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ Program $ parse $ tokenize contents
      ["decode", encoding] -> do
        print (decode $ read encoding :: Program)
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " <run|encode|decode> <program|encoding> [initial state]"
