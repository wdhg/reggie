module ProgramSpec (spec) where

import Test.Hspec
import Program

spec :: Spec
spec
  = do
    describe "run" $ do
      it "can halt" $
        run [Halt] `shouldBe` []

      it "can increment values" $ do
        run [Incr 0 1, Halt] `shouldBe` [(0, 1)]
