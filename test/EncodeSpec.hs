module EncodeSpec (spec) where

import Test.Hspec
import Encode

spec :: Spec
spec
  = describe "Encode" $ do
      describe "encode" $ do
        it "can encode pairs correctly" $ do
          encode (0 :: Int, 0:: Int) `shouldBe` 1
          encode (1 :: Int, 0 :: Int) `shouldBe` 2
          encode (5 :: Int, 0 :: Int) `shouldBe` 32
          encode (0 :: Int, 3 :: Int) `shouldBe` 7
          encode (1 :: Int, 2 :: Int) `shouldBe` 10
          encode (2 :: Int, 1 :: Int) `shouldBe` 12
          encode (2 :: Int, 2 :: Int) `shouldBe` 20

      describe "encode'" $ do
         it "can encode pairs correctly" $ do
           encode' (0 :: Int, 0 :: Int) `shouldBe` 0
           encode' (1 :: Int, 0 :: Int) `shouldBe` 1
           encode' (5 :: Int, 0 :: Int) `shouldBe` 31
           encode' (0 :: Int, 3 :: Int) `shouldBe` 6
           encode' (1 :: Int, 2 :: Int) `shouldBe` 9
           encode' (2 :: Int, 1 :: Int) `shouldBe` 11
           encode' (2 :: Int, 2 :: Int) `shouldBe` 19
