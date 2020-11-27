{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Program where

import Prelude hiding (lookup)
import Data.Map (Map(..), alter, fromList, lookup, toAscList)
import Data.Maybe (fromMaybe)

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

instance Show Program where
  show (Program program)
    = unlines $ map (\(l, i) -> show l ++ ": " ++ show i) $ toAscList program

data Machine
  = Machine Program (Map Integer Integer) Label

start :: Label
start = Label 0

run :: Program -> [(Integer, Integer)]
run program
  = runMem program []

runMem :: Program -> [(Integer, Integer)] -> [(Integer, Integer)]
runMem program memoryList
  = let memory = fromList memoryList
        (Machine _ memory' _) = run' $ Machine program memory start
     in toAscList memory'

run' :: Machine -> Machine
run' machine@(Machine program _ pc)
  = case getInstr program pc of
      Halt  -> machine
      instr -> run' $ step instr machine

step :: Instruction -> Machine -> Machine
step (Incr reg next) (Machine program memory _)
  = Machine program (alter incr reg memory) next
step (Decr reg nexts) (Machine program memory _)
  = let memory' = alter decr reg memory
        next = pickNext (regPositive reg memory') nexts
     in Machine program memory' next
step' Halt machine
  = machine

getInstr :: Program -> Label -> Instruction
getInstr (Program program) label
  = fromMaybe Halt $ lookup label program

regPositive :: Integer -> Map Integer Integer -> Bool
regPositive reg memory
  = case lookup reg memory of
      Nothing -> False
      Just x  -> x > 0

pickNext :: Bool -> (Label, Label) -> Label
pickNext True (x, _)  = x
pickNext False (_, y) = y

incr :: Maybe Integer -> Maybe Integer
incr Nothing
  = Just 1
incr (Just x)
  = Just $ succ x

decr :: Maybe Integer -> Maybe Integer
decr Nothing
  = Just (-1)
decr (Just x)
  = Just $ pred x
