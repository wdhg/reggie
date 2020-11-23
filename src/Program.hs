module Program where

data Instruction
  = Incr Int Int
  | Decr Int (Int, Int)
  | Halt
    deriving Show

run :: [Instruction] -> [(Int, Int)]
run
  = undefined
