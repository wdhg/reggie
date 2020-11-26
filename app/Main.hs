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
        print $ run $ parse $ tokenize contents
      ["run", prog, memory] -> do
        contents <- readFile prog
        print $ runMem (parse $ tokenize contents) (read memory)
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ parse $ tokenize contents
      ["decode", encoding] -> do
        mapM_ print (decode $ read encoding :: [Instruction])
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " <run|encode|decode> <program|encoding> [initial state]"
