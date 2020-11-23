module EncodeSpec (spec) where

import Test.Hspec
import Encode
import Program (Instruction(..))

spec :: Spec
spec
  = describe "Encode" $ do
      describe "encode" $ do
        it "can encode pairs" $ do
          encode (0 :: Int, 0:: Int) `shouldBe` 1
          encode (1 :: Int, 0 :: Int) `shouldBe` 2
          encode (5 :: Int, 0 :: Int) `shouldBe` 32
          encode (0 :: Int, 3 :: Int) `shouldBe` 7
          encode (1 :: Int, 2 :: Int) `shouldBe` 10
          encode (2 :: Int, 1 :: Int) `shouldBe` 12
          encode (2 :: Int, 2 :: Int) `shouldBe` 20

        it "can encode instructions" $ do
          encode (Incr 0 0) `shouldBe` 1
          encode (Incr 4 6) `shouldBe` 3328
          encode (Decr 0 (0, 0)) `shouldBe` 2
          encode (Decr 3 (1, 8)) `shouldBe` 8576
          encode Halt `shouldBe` 0

        it "can encode programs" $ do
          encode [Halt] `shouldBe` 1
          encode [Decr 0 (0, 2), Halt] `shouldBe` 786432

      describe "encode'" $ do
         it "can encode pairs correctly" $ do
           encode' (0 :: Int, 0 :: Int) `shouldBe` 0
           encode' (1 :: Int, 0 :: Int) `shouldBe` 1
           encode' (5 :: Int, 0 :: Int) `shouldBe` 31
           encode' (0 :: Int, 3 :: Int) `shouldBe` 6
           encode' (1 :: Int, 2 :: Int) `shouldBe` 9
           encode' (2 :: Int, 1 :: Int) `shouldBe` 11
           encode' (2 :: Int, 2 :: Int) `shouldBe` 19
