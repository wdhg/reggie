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
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ parse $ tokenize contents
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " [run|encode] <program>"
