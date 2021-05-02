module ProgramSpec (spec) where

import Test.Hspec
import Program (Program(..), Instruction(..), Label(..), Memory(..), Machine(..), run, start)
import Data.Map (fromList, toAscList, empty)

incr :: Integer -> Integer -> Instruction
incr reg next
  = Incr reg (Label next)

decr :: Integer -> (Integer, Integer) -> Instruction
decr reg (nextThen, nextElse)
  = Decr reg (Label nextThen, Label nextElse)

machine :: [Instruction] -> Machine
machine instrs
  = let prog = Program $ fromList $ zip [Label 0..] instrs
     in Machine prog (Memory empty) start

run' :: Machine -> [(Integer, Integer)]
run' machine
  = let (Machine _ (Memory regs) _) = run machine
     in toAscList regs

spec :: Spec
spec
  = do
    describe "run" $ do
      it "can halt" $
        run' (machine [Halt]) `shouldBe` []

      it "can increment values" $ do
        run' (machine [incr 0 1, Halt]) `shouldBe` [(0, 1)]
        run' (machine [incr 1 1, Halt]) `shouldBe` [(1, 1)]
        run' (machine [incr 0 1, incr 0 2, Halt]) `shouldBe` [(0, 2)]
        run' (machine [incr 0 1, incr 1 2, Halt]) `shouldBe` [(0, 1), (1, 1)]

      it "can decrement values" $ do
        run' (machine [incr 0 1, decr 0 (2,3), incr 0 3, Halt]) `shouldBe` [(0, 1)]

      it "can jump conditionally" $ do
        run' (machine [incr 0 1, incr 0 2, decr 0 (3, 4), incr 0 4, Halt]) `shouldBe` [(0, 2)]
        run' (machine [decr 0 (1,2), incr 0 1, Halt]) `shouldBe` []
