module Program where

data Instruction
  = Incr Int Int
  | Decr Int (Int, Int)
  | Halt
    deriving (Show, Eq)

run :: [Instruction] -> [(Int, Int)]
run program
  = let (_, _, registers) = until halting step (0, program, [])
     in registers

halting :: (Int, [Instruction], [(Int, Int)]) -> Bool
halting (pc, program, _)
  = (program !! pc) == Halt

step :: (Int, [Instruction], [(Int, Int)]) -> (Int, [Instruction], [(Int, Int)])
step (pc, program, registers)
  = case program !! pc of
      Incr reg next               -> (next, program, incr reg registers)
      Decr reg (nextIf, nextElse) -> let registers' = decr reg registers
                                      in if positive reg registers'
                                            then (nextIf, program, registers')
                                            else (nextElse, program, registers')
      Halt                        -> (pc, program, registers)

incr :: Int -> [(Int, Int)] -> [(Int, Int)]
incr key []
  = [(key, 1)]
incr key ((k, v) : remaining)
  | key == k  = (k, v + 1) : remaining
  | otherwise = (k, v) : incr key remaining

decr :: Int -> [(Int, Int)] -> [(Int, Int)]
decr key []
  = [(key, -1)]
decr key ((k, v) : remaining)
  | key == k = (k, v - 1) : remaining
  | otherwise = (k, v) : decr key remaining

positive :: Int -> [(Int, Int)] -> Bool
positive reg registers
  = case lookup reg registers of
      Just x  -> x > 0
      Nothing -> False
