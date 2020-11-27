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
      ["run", prog] -> do
        contents <- readFile prog
        print $ run $ Program $ parse $ tokenize contents
      ["run", prog, memory] -> do
        contents <- readFile prog
        print $ runMem (Program $ parse $ tokenize contents) (read memory)
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ Program $ parse $ tokenize contents
      ["decode", encoding] -> do
        print (decode $ read encoding :: Program)
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " <run|encode|decode> <program|encoding> [initial state]"
