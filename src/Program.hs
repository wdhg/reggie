module Program where

newtype Register
  = Register Int
    deriving Show

data Instruction
  = Incr Int Int
  | Decr Int (Int, Int)
  | Halt
    deriving Show

run :: [Instruction] -> [Register]
run
  = undefined
