module Machine where

newtype ID a
  = ID Int

newtype Register
  = Register Int

newtype Registers
  = Registers [(ID Register, Register)]

data Instruction
  = Incr (ID Register)
  | Decr (ID Register) (ID Register)
  | Halt

newtype Program
  = Program [Instruction]

data Machine
  = Machine Registers Program
