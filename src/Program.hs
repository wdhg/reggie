{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Program where

import Prelude hiding (lookup)
import Control.Monad (when)
import Data.Map (Map(..), alter, fromList, lookup, toAscList)
import Data.Maybe (fromMaybe)
import Data.List (intercalate)

newtype Label
  = Label Integer
    deriving (Eq, Ord, Enum)

instance Show Label where
  show (Label l)
    = "L" ++ show l

data Instruction
  = Incr Integer Label
  | Decr Integer (Label, Label)
  | Halt
    deriving Eq

instance Show Instruction where
  show (Incr reg next)
    = "R" ++ show reg ++ "+ -> " ++ show next
  show (Decr reg (nextThen, nextElse))
    = "R" ++ show reg ++ "- -> " ++ show nextThen ++ ", " ++ show nextElse
  show Halt
    = "HALT"

newtype Program
  = Program (Map Label Instruction)
    deriving Eq

instance Show Program where
  show (Program program)
    = unlines $ map (\(l, i) -> show l ++ ": " ++ show i) $ toAscList program

newtype Memory
  = Memory (Map Integer Integer)

instance Show Memory where
  show (Memory registers)
    = intercalate ", " $ map showReg $ toAscList registers
      where
        showReg :: (Integer, Integer) -> String
        showReg (reg, value)
          = "R" ++ show reg ++ ": " ++ show value

data Machine
  = Machine Program Memory Label

instance Show Machine where
  show (Machine _ memory label)
    = case show memory of 
        "" -> "(" ++ show label ++ ")"
        s  -> "(" ++ show label ++ ", " ++ s ++ ")"

data Step
  = Step Instruction Machine

instance Show Step where
  show (Step instr machine)
    = let tabs = case instr of
                   Incr _ _ -> "\t"
                   Decr _ _ -> "\t"
                   Halt     -> "\t\t"
       in show instr ++ tabs ++  " ==> " ++ show machine

start :: Label
start = Label 0

run :: Machine -> Machine
run machine@(Machine program memory label)
  = case getInstr program label of
      (Incr reg next)             -> run $ Machine program (update increment reg memory) next
      (Decr reg (next, nextZero))
        | reg `positiveIn` memory -> run $ Machine program (update decrement reg memory) next
        | otherwise               -> run $ Machine program memory nextZero
      Halt                        -> machine

runSteps :: Machine -> [Step]
runSteps machine@(Machine program memory label)
  = let instr = getInstr program label
        step = Step instr machine
     in case getInstr program label of
          (Incr reg next)             -> step : runSteps (Machine program (update increment reg memory) next)
          (Decr reg (next, nextZero))
            | reg `positiveIn` memory -> step : runSteps (Machine program (update decrement reg memory) next)
            | otherwise               -> step : runSteps (Machine program memory nextZero)
          Halt                        -> [step]

getInstr :: Program -> Label -> Instruction
getInstr (Program program) label = fromMaybe Halt $ lookup label program

positiveIn :: Integer -> Memory -> Bool
positiveIn reg (Memory registers) = maybe False (> 0) $ lookup reg registers

update :: (Maybe Integer -> Maybe Integer) -> Integer -> Memory -> Memory
update func reg (Memory registers) = Memory $ alter func reg registers

increment :: Maybe Integer -> Maybe Integer
increment = Just . maybe 1 succ

decrement :: Maybe Integer -> Maybe Integer
decrement = Just . maybe 0 pred
