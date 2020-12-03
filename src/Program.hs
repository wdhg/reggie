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
    deriving Show

start :: Label
start = Label 0

run :: Bool -> Program -> [(Integer, Integer)] -> IO Memory
run showSteps program registers
  = do
    let memory = Memory $ fromList registers
    (Machine _ memory' _) <- run' showSteps $ Machine program memory start
    return memory'

run' :: Bool -> Machine -> IO Machine
run' showSteps machine@(Machine program _ label)
  = case getInstr program label of
      Halt  -> return machine
      instr -> do
        let machine'@(Machine _ memory _) = step instr machine
        when showSteps $ showStep label instr memory
        run' showSteps machine'

showStep :: Label -> Instruction -> Memory -> IO ()
showStep label instr memory
  = let whitespace = case instr of
                       Halt -> "\t\t"
                       _    -> "\t"
     in putStrLn $ show label ++ ": " ++ show instr ++ whitespace ++ "==> " ++ show memory

step :: Instruction -> Machine -> Machine
step (Incr reg next) (Machine program memory _)
  = Machine program (update increment reg memory) next
step (Decr reg nexts) (Machine program memory _)
  = let memory' = update decrement reg memory
        next = pickNext (regPositive reg memory') nexts
     in Machine program memory' next
step' Halt machine
  = machine

getInstr :: Program -> Label -> Instruction
getInstr (Program program) label
  = fromMaybe Halt $ lookup label program

regPositive :: Integer -> Memory -> Bool
regPositive reg (Memory registers)
  = case lookup reg registers of
      Nothing -> False
      Just x  -> x >= 0

pickNext :: Bool -> (Label, Label) -> Label
pickNext True (x, _)  = x
pickNext False (_, y) = y

update :: (Maybe Integer -> Maybe Integer) -> Integer -> Memory -> Memory
update func reg (Memory registers)
  = Memory $ alter func reg registers

increment :: Maybe Integer -> Maybe Integer
increment Nothing
  = Just 1
increment (Just x)
  = Just $ succ x

decrement :: Maybe Integer -> Maybe Integer
decrement Nothing
  = Just (-1)
decrement (Just x)
  = Just $ pred x
