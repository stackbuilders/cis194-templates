module Main
  ( main )
where

import Employee
import qualified Party as P
import Data.Tree
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "glCons" $ 
    it "adds an Employee to the GuestList" $ do
      let guestList = GL [Emp "Stan" 9, Emp "Bob" 2] 11
      P.glCons (Emp "Joe" 5) guestList 
        `shouldBe` GL [Emp "Stan" 9, Emp "Bob" 2, Emp "Joe" 5] 16

  describe "moreFun" $ 
    it "returns the GuestList with more fun" $ do
      let firstGuestList = GL [Emp "Stan" 9, Emp "Bob" 2] 11
      let secondGuestList = GL [Emp "John" 1, Emp "Sue" 5] 6
      P.moreFun firstGuestList secondGuestList
        `shouldBe` GL [Emp "Stan" 9, Emp "Bob" 2] 11
  
  describe "treeFold" $
    it "folds function with a tree" $ do
      let first = Node { rootLabel = 1::Integer, subForest = [] }
      let second = Node { rootLabel = 2::Integer, subForest = [] }
      let third = Node { rootLabel = 3::Integer, subForest = [] }
      let tree = Node { rootLabel = 4::Integer, subForest = [first, second, third] }
      P.treeFold (\x xs -> x + (sum xs)) [0] tree `shouldBe` 10

  describe "nextLevel" $
    it "returns the best guest list both with and without the given boss" $ do
      let firstGuestList = GL [Emp "Stan" 9, Emp "Bob" 2] 16
      let secondGuestList = GL [Emp "John" 1, Emp "Sue" 5] 6
      P.nextLevel (Emp "Joe" 5) [(firstGuestList, secondGuestList)]
        `shouldBe` (GL [Emp "John" 1, Emp "Sue" 5, Emp "Joe" 5] 11, GL [Emp "Stan" 9, Emp "Bob" 2] 16)
  
  describe "maxFun" $
    it "returns a fun-maximizing guest list" $
      P.maxFun testCompany `shouldBe` GL [Emp "Sarah" 17] 17
  
  describe "main" $
    it "prints out a formatted guest list" $ do
      mainResult <- P.main
      formattedGuestList <- putStrLn $ "Total fun: 268\nFrancis Deluzain\nHenri Bishop\nMargareth Adix\n"
      mainResult `shouldBe` formattedGuestList