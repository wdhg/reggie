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
        run [Incr 1 1, Halt] `shouldBe` [(1, 1)]
        run [Incr 0 1, Incr 0 2, Halt] `shouldBe` [(0, 2)]
        run [Incr 0 1, Incr 1 2, Halt] `shouldBe` [(0, 1), (1, 1)]

      it "can decrement values" $ do
        run [Decr 0 (1,1), Halt] `shouldBe` [(0, -1)]
        run [Decr 0 (1,1), Decr 0 (2, 2), Halt] `shouldBe` [(0, -2)]
        run [Decr 0 (1,1), Decr 1 (2, 2), Halt] `shouldBe` [(0, -1), (1, -1)]

      it "can branch on decrement" $ do
        run [Decr 0 (1, 2), Incr 1 2, Halt] `shouldBe` [(0, -1)]
        run [Incr 0 1, Decr 0 (2, 3), Incr 1 0, Halt] `shouldBe` [(0, 0)]
        run [Incr 0 1, Incr 0 2, Incr 0 3, Decr 0 (4, 5), Incr 1 3, Halt]
          `shouldBe` [(0, 0), (1, 2)]
