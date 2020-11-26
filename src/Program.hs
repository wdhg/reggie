module Program where

import Prelude hiding (lookup)
import Data.Map (Map(..), alter, fromList, lookup, toAscList)

data Instruction
  = Incr Int Int
  | Decr Int (Int, Int)
  | Halt
    deriving Eq

instance Show Instruction where
  show (Incr reg next)
    = "R" ++ show reg ++ "+ -> L" ++ show next
  show (Decr reg (nextThen, nextElse))
    = "R" ++ show reg ++ "+ -> L" ++ show nextThen ++ ", L" ++ show nextElse
  show Halt
    = "HALT"

data Machine
  = Machine [Instruction] (Map Int Int) Int

run :: [Instruction] -> [(Int, Int)]
run program
  = runMem program []

runMem :: [Instruction] -> [(Int, Int)] -> [(Int, Int)]
runMem program memoryList
  = let memory = fromList memoryList
        (Machine _ memory' _) = until finished step $ Machine program memory 0
     in toAscList memory'

finished :: Machine -> Bool
finished (Machine program _ pc)
  = case getInstr program pc of
      Nothing    -> True
      Just instr -> instr == Halt

step :: Machine -> Machine
step machine@(Machine program _ pc)
  = maybe machine (`step'`machine) $ getInstr program pc

step' :: Instruction -> Machine -> Machine
step' (Incr reg next) (Machine program memory _)
  = Machine program (alter incr reg memory) next
step' (Decr reg nexts) (Machine program memory _)
  = let memory' = alter decr reg memory
        next = pickNext (regPositive reg memory') nexts
     in Machine program memory' next
step' Halt machine
  = machine

getInstr :: [Instruction] -> Int -> Maybe Instruction
getInstr [] _
  = Nothing
getInstr (instr : _) 0
  = Just instr
getInstr (_ : program) pc
  = getInstr program (pc - 1)

regPositive :: Int -> Map Int Int -> Bool
regPositive reg memory
  = case lookup reg memory of
      Nothing -> False
      Just x  -> x > 0

pickNext :: Bool -> (Int, Int) -> Int
pickNext True (x, _)  = x
pickNext False (_, y) = y

incr :: Maybe Int -> Maybe Int
incr Nothing
  = Just 1
incr (Just x)
  = Just $ succ x

decr :: Maybe Int -> Maybe Int
decr Nothing
  = Just (-1)
decr (Just x)
  = Just $ pred x
