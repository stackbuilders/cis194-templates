module Main
  ( main )
where

import Wholemeal
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "fun1'" $
    it "returns same output of fun1" $
      fun1' [1,3,5,7] `shouldBe` fun1 [1,3,5,7]

  describe "fun2'" $
    it "returns same output of fun2" $
      fun2' 10 `shouldBe` fun2 10

  describe "foldTree" $
    -- Because you can have many implementations of foldTree, you will only test the height of the tree
    it "returns heigh of a balanced binary tree" $ do
      let height (Node x _ _ _) = x
      height (foldTree "ABCDEFGHIJ") `shouldBe` 3

  describe "xor" $ do
    context "when list has an odd number of True values" $
      it "returns True" $
        xor [False, True, False] `shouldBe` True

    context "when list has an even number of True values" $
      it "returns False" $
        xor [False, True, False, False, True] `shouldBe` False

  describe "map'" $ do
    context "when list is not empty" $
      it "returns same output of standard map function" $
        map' (+1) [1,2,3] `shouldBe` map (+1) [1,2,3]

    context "when list is empty" $
      it "returns same output of standard map function" $
        map' (*2) [] `shouldBe` map (*2) []

  describe "sieveSundaram" $
    it "returns a list of prime numbers less than 2*n + 2" $
      sieveSundaram 20 `shouldBe` [3,5,7,11,13,17,19,23,29,31,37,41] 
