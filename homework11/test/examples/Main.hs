module Main
  ( main )
where

import AParser
import Data.Char
import SExpr
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "zeroOrMore" $ 
    context "when input is 'satisfy isUpper' parser" $ do
      context "when the first characters of the input of runParser are uppercase" $ 
        it "returns a Just value with the first uppercase characters and the rest of input in a tuple" $
          runParser (zeroOrMore (satisfy isUpper)) "ABCdEfgH" `shouldBe` Just ("ABC","dEfgH")
      
      context "when the first characters of the input of runParser aren't uppercase" $ 
        it "returns a Just value with empty string and input in a tuple" $
          runParser (zeroOrMore (satisfy isUpper)) "abcdeFGh" `shouldBe` Just ("","abcdeFGh")

  describe "oneOrMore" $ 
    context "when input is 'satisfy isUpper' parser" $ do
      context "when the first characters of the input of runParser are uppercase" $ 
        it "returns a Just value with the first uppercase characters and the rest of input in a tuple" $
          runParser (oneOrMore (satisfy isUpper)) "ABCdEfgH" `shouldBe` Just ("ABC","dEfgH")
      
      context "when the first characters of runParser's input aren't uppercase" $ 
        it "returns Nothing" $
          runParser (oneOrMore (satisfy isUpper)) "abcdeFGh" `shouldBe` Nothing

  describe "spaces" $ 
    context "when the first characters of the input are spaces" $ 
      it "returns a Just value with the first space characters and the rest of input in a tuple" $
        runParser spaces "    foobar baz" `shouldBe` Just ("    ","foobar baz")

  describe "ident" $ do
    context "when the input has characters at the begining" $ do
      context "when the input has spaces" $ 
        it "returns a Just value with the first characters before first space and the rest of input in a tuple" $
          runParser ident "foobar baz" `shouldBe` Just ("foobar"," baz")

      context "when the input hasn't spaces" $ 
        it "returns a Just value with input and empty string in a tuple" $
          runParser ident "foobar" `shouldBe` Just ("foobar","")
    
    context "when the input has characters and numbers at the begining" $ 
      it "returns a Just value with input and empty string in a tuple" $
        runParser ident "foo33fA" `shouldBe` Just ("foo33fA","")

    context "when the input has numbers at the begining" $ 
      it "returns Nothing" $
        runParser ident "2bad" `shouldBe` Nothing
    
    context "when the input is an empty string" $ 
      it "returns Nothing" $
        runParser ident "" `shouldBe` Nothing

  describe "parseSExpr" $ do
    context "when expression is well-formed" $ do
      context "when expression is a number" $
        it "returns a Just value with a S-expression and empty string in a tuple" $
          runParser parseSExpr "3" `shouldBe` Just (A (N 3),"")
      
      context "when expression is a string" $
        it "returns a Just value with a S-expression and empty string in a tuple" $
          runParser parseSExpr "foo" `shouldBe` Just (A (I "foo"),"")

      context "when expression has numbers and characters" $
        it "returns a Just value with a S-expression and empty string in a tuple" $
          runParser parseSExpr "(lambda x x) 3" 
            `shouldBe` Just (Comb [A (I "lambda"),A (I "x"),A (I "x")],"3")

    context "when expression isn't well-formed" $
      it "returns Nothing" $
        runParser parseSExpr "(lambda x x" `shouldBe` Nothing