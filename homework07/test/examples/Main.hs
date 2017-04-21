module Main
  ( main )
where

import JoinList hiding (main)
import Scrabble
import Buffer
import Editor
import Sized
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "(+++) (append function)" $ do
    context "when provided with Empty and Single values" $
      it "returns new JoinList" $ 
        (+++) Empty (Single (Size 1) "a") `shouldBe` Append (Size 1) Empty (Single (Size 1) "a")
    
    context "when provided with Single and Append values" $
      it "returns new JoinList" $ 
        (+++) (Single (Size 1) "a") (Append (Size 2) Empty Empty) 
          `shouldBe` Append (Size 3) (Single (Size 1) "a") (Append (Size 2) Empty Empty)
    
    context "when provided with Empty and Append values" $
      it "returns new JoinList" $ 
        (+++) Empty (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
          `shouldBe` Append (Size 2) Empty (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b"))

  describe "indexJ" $ do
    context "when provided with Empty value" $
      it "returns Nothing" $ 
        indexJ 10 (Empty :: JoinList Size String) `shouldBe` Nothing
    
    context "when provided with Single value" $ do
      context "when index is equals to zero" $
        it "returns a Just value" $ 
          indexJ 0 (Single (Size 1) "a") `shouldBe` Just "a"
      
      context "when index is out of range" $
        it "returns Nothing" $ 
          indexJ 1 (Single (Size 1) "a") `shouldBe` Nothing

    context "when provided with Append value" $ do
      context "when index is in range" $
        it "returns a Just value" $ 
          indexJ 0 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
            `shouldBe` Just "a"
      
      context "when index is out of range" $
        it "returns Nothing" $ 
          indexJ 2 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
            `shouldBe` Nothing

  describe "dropJ" $ do
    context "when provided with Empty value" $
      it "returns Empty" $ 
        dropJ 10 (Empty :: JoinList Size String) `shouldBe` Empty
    
    context "when provided with Single value" $ do
      context "when number of elements to drop is zero" $
        it "returns original JoinList" $ 
          dropJ 0 (Single (Size 1) "a") `shouldBe` (Single (Size 1) "a")
      
      context "when number of elements to drop is valid" $
        it "returns Empty" $ 
          dropJ 1 (Single (Size 1) "a") `shouldBe` Empty

    context "when provided with Append value" $ do
      context "when number of elements to drop is zero" $
        it "returns original JoinList" $ 
          dropJ 0 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b"))  
            `shouldBe` (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
      
      context "when number of elements to drop is valid" $
        it "drops the first n elements from a JoinList" $ 
          dropJ 1 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
            `shouldBe` Single (Size 2) "b"

  describe "takeJ" $ do
    context "when provided with Empty value" $
      it "returns Empty" $ 
        takeJ 10 (Empty :: JoinList Size String) `shouldBe` Empty
    
    context "when provided with Single value" $ do
      context "when number of elements to take is zero" $
        it "returns Empty value" $ 
          takeJ 0 (Single (Size 1) "a") `shouldBe` Empty
      
      context "when number of elements to take is valid" $
        it "returns original JoinList" $ 
          takeJ 1 (Single (Size 1) "a") `shouldBe` (Single (Size 1) "a")

    context "when provided with Append value" $ do
      context "when number of elements to take is zero" $
        it "returns Empty value" $ 
          takeJ 0 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b"))  
            `shouldBe` Empty
      
      context "when number of elements to take is valid" $
        it "takes the first n elements from a JoinList" $ 
          takeJ 1 (Append (Size 2) (Single (Size 1) "a") (Single (Size 2) "b")) 
            `shouldBe` Append (Size 1) (Single (Size 1) "a") Empty
  
  describe "scoreLine" $ 
    it "returns JoinList with scrabble score" $
      scoreLine "haskell" `shouldBe` Single (Score 14) "haskell"