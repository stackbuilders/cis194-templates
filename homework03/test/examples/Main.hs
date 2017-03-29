module Main
  ( main )
where

import Golf
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "skips" $ do
    it "skips list of Chars (length 4)" $
      skips "ABCD" `shouldBe` ["ABCD", "BD", "C", "D"]

    it "skips list of Chars (length 6)" $
      skips "hello!" `shouldBe` ["hello!", "el!", "l!", "l", "o", "!"]

    it "skips list of one element" $
      skips [1] `shouldBe` [[1]]

    it "skips list of Booleans" $
      skips [True,False] `shouldBe` [[True,False], [False]]

    it "skips empty list" $
      skips ([] :: [String]) `shouldBe` ([] :: [[String]])

  describe "localMaxima" $ do
    context "when at least one element of list is greater than both elements immediately before and after it" $ do
      it "returns two local maximums" $
        localMaxima [2,9,5,6,1] `shouldBe` [9,6]

      it "returns one local maximum" $
        localMaxima [2,3,4,1,5] `shouldBe` [4]

    context "when no element of list is greater than both elements immediately before and after it" $
      it "returns zero local maximum" $
        localMaxima [1,2,3,4,5] `shouldBe` []

  describe "histogram" $
    it "outputs a vertical histogram" $
      histogram [1,1,1,5] `shouldBe` " *        \n *        \n *   *    \n==========\n0123456789\n" 
