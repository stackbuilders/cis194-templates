module Main
  ( main )
where

import Basis
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "toDigits" $ do
    context "when the number is greater than 0" $
      it "returns a list of digits" $
        toDigits 1234 `shouldBe` [1, 2, 3, 4]

    context "when the number is 0" $
      it "returns an empty list" $
        toDigits 0 `shouldBe` []

    context "when the number is less than 0" $
      it "returns an empty list" $
        toDigits (-17) `shouldBe` []

  describe "toDigitsRev" $ do
    context "when the number is greater than 0" $
      it "returns a list of digits reversed" $
        toDigitsRev 9876 `shouldBe` [6, 7, 8, 9]

    context "when the number is 0" $
      it "returns an empty list" $
        toDigitsRev 0 `shouldBe` []

    context "when the number is less than 0" $
      it "returns an empty list" $
        toDigitsRev (-1) `shouldBe` []

  describe "doubleEveryOther" $ do
    context "when the list has an even number of elements" $
      it "doubles every other number beginning from the right" $
        doubleEveryOther [8, 7, 6, 5] `shouldBe` [16, 7, 12, 5]

    context "when the list has an odd number of elements" $
      it "doubles every other number beginning from the right" $
        doubleEveryOther [1, 2, 3] `shouldBe` [1, 4, 3]

  describe "sumDigits" $
    it "calculates the sum of sums of the digits of each element in a list" $
      sumDigits [16, 7, 12, 5] `shouldBe` 22

  describe "validate" $ do
    context "when the credit card number is valid" $
      it "returns True" $
        validate 4012888888881881 `shouldBe` True

    context "when the credit card number is invalid" $
      it "returns False" $
        validate 4012888888881882 `shouldBe` False

  describe "hanoi" $
    context "when the stack discs moves from first peg to second" $ do
      it "gets a list of moves whit 2 discs" $
        hanoi 2 "a" "b" "c" `shouldBe` [("a", "c"), ("a", "b"), ("c", "b")]

      it "gets a list of moves whit 3 discs" $
        hanoi 3 "a" "b" "c" `shouldBe` [("a","b"),("a","c"),("b","c"),("a","b"),("c","a"),("c","b"),("a","b")] 
