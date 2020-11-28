module EncodeSpec (spec) where

import Test.Hspec
import Encode
import Program (Program(..), Instruction(..), Label(..))
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
  = describe "Encode" $ do
      describe "encode" $ do
        it "can encode pairs" $ do
          encode (0 :: Int, 0 :: Int) `shouldBe` 1
          encode (1 :: Int, 0 :: Int) `shouldBe` 2
          encode (5 :: Int, 0 :: Int) `shouldBe` 32
          encode (0 :: Int, 3 :: Int) `shouldBe` 7
          encode (1 :: Int, 2 :: Int) `shouldBe` 10
          encode (2 :: Int, 1 :: Int) `shouldBe` 12
          encode (2 :: Int, 2 :: Int) `shouldBe` 20

        it "can encode instructions" $ do
          encode (incr 0 0)      `shouldBe` 1
          encode (incr 4 6)      `shouldBe` 3328
          encode (decr 0 (0, 0)) `shouldBe` 2
          encode (decr 3 (1, 8)) `shouldBe` 8576
          encode Halt            `shouldBe` 0

        it "can encode programs" $ do
          encode (program [Halt]) `shouldBe` 1
          encode (program [decr 0 (0, 2), Halt]) `shouldBe` 786432

      describe "encode'" $ do
         it "can encode pairs correctly" $ do
           encode' (0 :: Int, 0 :: Int) `shouldBe` 0
           encode' (1 :: Int, 0 :: Int) `shouldBe` 1
           encode' (5 :: Int, 0 :: Int) `shouldBe` 31
           encode' (0 :: Int, 3 :: Int) `shouldBe` 6
           encode' (1 :: Int, 2 :: Int) `shouldBe` 9
           encode' (2 :: Int, 1 :: Int) `shouldBe` 11
           encode' (2 :: Int, 2 :: Int) `shouldBe` 19

      describe "decode" $ do
        it "can decode pairs" $ do
          decode 1  `shouldBe` (0 :: Int, 0 :: Int)
          decode 2  `shouldBe` (1 :: Int, 0 :: Int)
          decode 32 `shouldBe` (5 :: Int, 0 :: Int)
          decode 7  `shouldBe` (0 :: Int, 3 :: Int)
          decode 10 `shouldBe` (1 :: Int, 2 :: Int)
          decode 12 `shouldBe` (2 :: Int, 1 :: Int)
          decode 20 `shouldBe` (2 :: Int, 2 :: Int)

        it "can decode instructions" $ do
          decode 1    `shouldBe` incr 0 0
          decode 3328 `shouldBe` incr 4 6
          decode 2    `shouldBe` decr 0 (0, 0)
          decode 8576 `shouldBe` decr 3 (1, 8)
          decode 0    `shouldBe` Halt

        it "can decode programs" $ do
          decode 1      `shouldBe` program [Halt]
          decode 786432 `shouldBe` program [decr 0 (0, 2), Halt]

