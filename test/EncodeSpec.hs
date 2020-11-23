module EncodeSpec (spec) where

import Test.Hspec
import Encode

spec :: Spec
spec
  = describe "Encode" $ do
      describe "encode" $ do
        it "can encode pairs correctly" $ do
          encode (0, 0) `shouldBe` 1
          encode (1, 0) `shouldBe` 2
          encode (5, 0) `shouldBe` 32
          encode (0, 3) `shouldBe` 7
          encode (1, 2) `shouldBe` 10
          encode (2, 1) `shouldBe` 12
          encode (2, 2) `shouldBe` 20

      describe "encode'" $ do
         it "can encode pairs correctly" $ do
           encode' (0, 0) `shouldBe` 0
           encode' (1, 0) `shouldBe` 1
           encode' (5, 0) `shouldBe` 31
           encode' (0, 3) `shouldBe` 6
           encode' (1, 2) `shouldBe` 9
           encode' (2, 1) `shouldBe` 11
           encode' (2, 2) `shouldBe` 19
