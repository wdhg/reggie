module Main where

import System.Environment
import Data.Map (fromList)
import Parser
import Program
import Encode

runProgram :: String -> [String] -> IO ()
runProgram filename arguments
  = do
    contents <- readFile filename
    let memory = Memory $ fromList $ zip [0..] $ map read arguments
        program = Program $ parse $ tokenize contents
        machine = Machine program memory start
        (Machine _ memory' _) = run machine
    putStrLn $ ">>> " ++ show memory

main :: IO ()
main
  = do
    args <- getArgs
    case args of
      ("run" : filename : arguments) -> runProgram filename arguments
      ["encode", prog] -> do
        contents <- readFile prog
        print $ encode $ Program $ parse $ tokenize contents
      ["decode", encoding] -> do
        print (decode $ read encoding :: Program)
      ["decode2", exp, encoding] -> do
        print (decode $ 2 ^ read exp * read encoding :: Program)
      _ -> do
        name <- getProgName
        putStrLn $ "Usage: " ++ name ++ " <run|encode|decode|decode2> <program|encoding> [initial state]"
