module Main
  ( main )
where

import Control.Applicative
import AParser
import Data.Char
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "fmap (Parser)" $ 
    it "returns the result of fmap in Parser value" $ do
      let concatStr str = Just(str, str ++ "haskell")
      let parserStr = map toUpper <$> Parser concatStr
      runParser parserStr "abc" `shouldBe` Just ("ABC","abchaskell")

  describe "pure (Parser)" $ 
    it "returns pure value of Applicative instance for Parser" $ do
      let parser = pure "ABC"
      runParser parser "abc" `shouldBe` Just ("ABC","abc")

  describe "<*> (Parser)" $ 
    it "returns sequential application of Applicative instance for Parser" $ do
      let concatStr str = Just(str, str ++ "haskell")
      let pureParser = pure $ map toUpper
      let parserStr = pureParser <*> Parser concatStr
      runParser parserStr "abc" `shouldBe` Just ("ABC","abchaskell")

  describe "abParser" $ do
    context "when the first characters of the input are 'a' and 'b'" $
      it "returns a Just value with (a,b) tuple and the input without this characters" $ 
        runParser abParser "abcdef" `shouldBe` Just (('a','b'),"cdef")
    
    context "when the first characters of the input aren't 'a' and 'b'" $
      it "returns Nothing" $ 
        runParser abParser "aebcdf" `shouldBe` Nothing

  describe "abParser_" $ do
    context "when the first characters of the input are 'a' and 'b'" $
      it "returns a Just value with empty tuple and the input without 'a' and 'b' characters" $ 
        runParser abParser_ "abcdef" `shouldBe` Just ((),"cdef")
    
    context "when the first characters of the input aren't 'a' and 'b'" $
      it "returns Nothing" $ 
        runParser abParser_ "aebcdf" `shouldBe` Nothing

  describe "intPair" $ do
    context "when the input contains two integer values separated by a space" $
      it "returns the integer values in a list" $ 
        runParser intPair "12 34" `shouldBe` Just ([12,34],"")

    context "when the input does not contains two integer values separated by a space" $
      it "returns Nothing" $ 
        runParser intPair "a b" `shouldBe` Nothing

  describe "empty (Parser)" $ 
    it "returns Nothing" $ do
      let parser = empty :: Parser [Integer]
      runParser parser "abc" `shouldBe` Nothing
      
  describe "<|> (Parser)" $ do
    context "when the first parser succeeds" $ 
      it "returns the result of the first parser" $ do
        let firstParser = runParser intPair "12 34"
        let secondParser = runParser intPair "56 78"
        (firstParser <|> secondParser) `shouldBe` Just ([12,34],"")
    
    context "when the first parser fails" $ 
      it "returns the result of the second parser" $ do
        let firstParser = runParser intPair "a b"
        let secondParser = runParser intPair "56 78"
        (firstParser <|> secondParser) `shouldBe` Just ([56,78],"")

  describe "intOrUppercase" $ do
    context "when the first characters of the input are numbers" $
      it "returns a Just value with empty tuple and the input without numbers" $ 
        runParser intOrUppercase "342abcd" `shouldBe` Just ((),"abcd")

    context "when the first characters of the input are uppercase" $
      it "returns a Just value with empty tuple and the input without first character" $ 
        runParser intOrUppercase "XYZ" `shouldBe` Just ((),"YZ")

    context "when the first characters of the input aren't numbers or uppercase" $
      it "returns Nothing" $ 
        runParser intOrUppercase "foo" `shouldBe` Nothing
