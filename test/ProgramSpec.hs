module ProgramSpec (spec) where

import Test.Hspec
import Program (Program(..), Instruction(..), Label(..), run)
import Data.Map (fromList)

incr :: Integer -> Integer -> Instruction
incr reg next
  = Incr reg (Label next)

decr :: Integer -> (Integer, Integer) -> Instruction
decr reg (nextThen, nextElse)
  = Decr reg (Label nextThen, Label nextElse)

program :: [Instruction] -> Program
program
  = Program . fromList . zip [Label 0..]

spec :: Spec
spec
  = do
    describe "run" $ do
      it "can halt" $
        run (program [Halt]) `shouldBe` []

      it "can increment values" $ do
        run (program [incr 0 1, Halt]) `shouldBe` [(0, 1)]
        run (program [incr 1 1, Halt]) `shouldBe` [(1, 1)]
        run (program [incr 0 1, incr 0 2, Halt]) `shouldBe` [(0, 2)]
        run (program [incr 0 1, incr 1 2, Halt]) `shouldBe` [(0, 1), (1, 1)]

      it "can decrement values" $ do
        run (program [decr 0 (1,1), Halt]) `shouldBe` [(0, -1)]
        run (program [decr 0 (1,1), decr 0 (2, 2), Halt]) `shouldBe` [(0, -2)]
        run (program [decr 0 (1,1), decr 1 (2, 2), Halt]) `shouldBe` [(0, -1), (1, -1)]

      it "can branch on decrement" $ do
        run (program [decr 0 (1, 2), incr 1 2, Halt]) `shouldBe` [(0, -1)]
        run (program [incr 0 1, decr 0 (2, 3), incr 1 0, Halt]) `shouldBe` [(0, 0)]
        run (program [incr 0 1, incr 0 2, incr 0 3, decr 0 (4, 5), incr 1 3, Halt])
          `shouldBe` [(0, 0), (1, 2)]
