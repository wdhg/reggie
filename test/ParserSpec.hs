module ParserSpec (spec) where

import Test.Hspec
import Parser
import Parser.Tokens
import Program (Instruction(..), Label(..))
import Data.Map (fromList)

spec :: Spec
spec
  = describe "Parser" $ do 
      describe "tokenize" $ do
        it "can remove comments" $
          tokenize "# this is a comment" `shouldBe` []

        it "can remove whitespace but keeps newlines" $
          tokenize "   \n   " `shouldBe` [TokenNewLine]

        it "can tokenize halt instructions" $
          tokenize "HALT" `shouldBe` [TokenHalt]

        it "can tokenize increment instructions" $
          tokenize "L0: R1+ -> L2" `shouldBe`
            [TokenLabel 0, TokenColon, TokenRegister 1, TokenIncr, TokenArrow, TokenLabel 2]

        it "can tokenize decremenet instructions" $
          tokenize "L1: R10- -> L43, L2" `shouldBe`
            [TokenLabel 1, TokenColon, TokenRegister 10, TokenDecr, TokenArrow, TokenLabel 43, TokenComma, TokenLabel 2]

      describe "parse" $ do
        it "can parse halt instructions" $
          parse [TokenLabel 4, TokenColon, TokenHalt] `shouldBe` fromList [(Label 4, Halt)]

        it "can parse increment instructions" $
          parse [TokenLabel 0, TokenColon, TokenRegister 1, TokenIncr, TokenArrow, TokenLabel 2]
            `shouldBe` fromList [(Label 0, Incr 1 (Label 2))]

        it "can parse decrement instructions" $
          parse [TokenLabel 1, TokenColon, TokenRegister 10, TokenDecr, TokenArrow, TokenLabel 43, TokenComma, TokenLabel 2]
            `shouldBe` fromList [(Label 1, Decr 10 (Label 43, Label 2))]
