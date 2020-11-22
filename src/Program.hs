module Program where

newtype ID a
  = ID Int
    deriving (Show, Eq)

newtype Register
  = Register Int
    deriving Show

newtype Registers
  = Registers [(ID Register, Register)]
    deriving Show

data Instruction
  = Incr (ID Register) (ID Instruction)
  | Decr (ID Register) (ID Instruction, ID Instruction)
  | Halt
    deriving Show

newtype Program
  = Program [Instruction]
    deriving Show

data MachineState
  = MachineState Registers Program
    deriving Show
