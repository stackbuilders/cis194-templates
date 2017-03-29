module Main
  ( main )
where

import Log
import LogAnalysis
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "parseMessage" $ do
    it "parses an error message" $
      parseMessage "E 2 562 help help" `shouldBe` LogMessage (Error 2) 562 "help help"

    it "parses an info message" $
      parseMessage "I 29 la la la" `shouldBe` LogMessage Info 29 "la la la"

    it "parses an Unknown message" $
      parseMessage "This is not in the right format" `shouldBe` Unknown "This is not in the right format"

  describe "insert" $
    it "returns a tree with LogMessage inserted" $ do
      let tree = Node Leaf (LogMessage (Error 2) 562 "help help") Leaf
      insert (LogMessage Info 29 "la") tree
        `shouldBe` Node (Node Leaf (LogMessage Info 29 "la") Leaf) (LogMessage (Error 2) 562 "help help") Leaf

  describe "build" $
    it "builds up a MessageTree containing the messages in a list" $ do
      let messageTreeSet = [LogMessage (Error 2) 562 "help help", LogMessage Info 29 "la"]
      build messageTreeSet
        `shouldBe` Node (Node Leaf (LogMessage Info 29 "la") Leaf) (LogMessage (Error 2) 562 "help help") Leaf

  describe "inOrder" $
    it "produces a list of all LogMessages it contains, sorted by timestamp from smallest to biggest" $ do
      let messageTreeSet = [LogMessage (Error 2) 562 "help help",LogMessage Info 29 "la"]
      inOrder (build messageTreeSet)
        `shouldBe` [LogMessage Info 29 "la",LogMessage (Error 2) 562 "help help"]

  describe "whatWentWrong" $
    context "with a severity of 50 or greater" $
      it "returns a list of the messages corresponding to any errors sorted by timestamp" $ do
        parseTest <- testWhatWentWrong parse whatWentWrong "src/sample.log"
        parseTest
          `shouldBe` ["Way too many pickles","Bad pickle-flange interaction detected","Flange failed!"] 
