module Main
  ( main )
where

import Fibonacci
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "fib" $
    it "calculates 7th number of Fibonacci sequence" $
      fib 7 `shouldBe` 13

  describe "fibs1" $
    it "gets first 10 numbers of Fibonacci sequence" $
      take 10 fibs1 `shouldBe` [0,1,1,2,3,5,8,13,21,34]

  describe "fibs2" $
    it "gets first 12 numbers of Fibonacci sequence" $
      take 12 fibs2 `shouldBe` [0,1,1,2,3,5,8,13,21,34,55,89]

  describe "show" $
    it "takes first 20 elements of infinite list of Stream data type" $ do
      let createStream x = Cons x (createStream x)
      show (createStream 4) `shouldBe` "[4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4]"

  describe "streamRepeat" $
    it "generates a stream containing many copies of the given element" $
      show (streamRepeat 'a') `shouldBe` "\"aaaaaaaaaaaaaaaaaaaa\""

  describe "streamMap" $
    it "applies a function to every element of a stream" $
      show (streamMap (+1) (streamRepeat 1)) `shouldBe` "[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]"

  describe "streamFromSeed" $
    it "generates a stream form a `seed` of the given type" $
      show (streamFromSeed (+10) 1) `shouldBe` "[1,11,21,31,41,51,61,71,81,91,101,111,121,131,141,151,161,171,181,191]"

  describe "nats" $
    it "gets first 20 numbers of the infinite list of natural numbers" $
      show nats `shouldBe` "[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]"

  describe "ruler" $
    it "gets first 20 numbers of a ruler function" $
      show ruler `shouldBe` "[0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,0,1,0,2]" 
