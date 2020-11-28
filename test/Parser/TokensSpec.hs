module Parser.TokensSpec (spec) where

import Test.Hspec
import Parser.Tokens

spec :: Spec
spec
  = describe "tokenize" $ do
      it "can remove comments" $ do
        tokenize "# this is a comment" `shouldBe` []

      it "can remove whitespace but keeps newlines" $ do
        tokenize "   \n   " `shouldBe` [TokenNewLine]

      it "can tokenize instructions" $ do
        tokenize "HALT" `shouldBe` [TokenHalt]
        tokenize "L0: R1+ -> L2" `shouldBe`
          [TokenLabel 0, TokenColon, TokenRegister 1, TokenIncr, TokenArrow, TokenLabel 2]
        tokenize "L1: R10- -> L43, L2" `shouldBe`
          [TokenLabel 1, TokenColon, TokenRegister 10, TokenDecr, TokenArrow, TokenLabel 43, TokenComma, TokenLabel 2]
