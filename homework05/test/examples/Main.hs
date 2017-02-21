module Main
  ( main )
where

import ExprT
import Calc
import Parser
import StackVM
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "eval" $
    it "returns result of applying add and multiply operations" $
      eval (ExprT.Mul (ExprT.Add (ExprT.Lit 2) (ExprT.Lit 3)) (ExprT.Lit (-4))) `shouldBe` (-20)

  describe "evalStr" $ do
    context "when an expression is well-formed" $ do
      context "and when the expression has parentheses" $
        it "returns value of expression" $
          evalStr "(2+3)*(-4)" `shouldBe` Just (-20)

      context "and when the expression does not have parentheses" $
        it "returns value of expression" $
          evalStr "2+3*4" `shouldBe` Just 14

    context "when an expression is not well-formed" $ do
      context "and when the expression has parentheses" $
        it "returns Nothing" $
          evalStr "(2+3)*" `shouldBe` Nothing

      context "and when the expression does not have parentheses" $
        it "returns Nothing" $
          evalStr "2+3*" `shouldBe` Nothing

  describe "reify" $
    it "makes an instance of Expr to ExprT type" $
      reify (mul (add (lit 2) (lit 3)) (lit (-4)))
        `shouldBe` ExprT.Mul (ExprT.Add (ExprT.Lit 2) (ExprT.Lit 3)) (ExprT.Lit (-4))

  describe "parseExp" $ do
    context "when provided with an Integer data type" $
      it "returns value of expression" $ do
        let testInteger = parseExp lit add mul "(3 * 4) + (-5)" :: Maybe Integer
        testInteger `shouldBe` Just 7

    context "when provided with a Bool data type" $
      it "returns value of expression" $ do
        let testBool = parseExp lit add mul "(3 * 4) + (-5)" :: Maybe Bool
        testBool `shouldBe` Just True

    context "when provided with a MinMax data type" $
      it "returns value of expression" $ do
        let testMM = parseExp lit add mul "(3 * 4) + (-5)" :: Maybe MinMax
        testMM `shouldBe` Just (MinMax 3)

    context "when provided with a Mod7 data type" $
      it "returns value of expression" $ do
        let testSat = parseExp lit add mul "(3 * 4) + (-5)" :: Maybe Mod7
        testSat `shouldBe` Just (Mod7 0)

  describe "compile" $
    it "returns stack operations" $
      compile "(3*4)" `shouldBe` ((Just [PushI 3,PushI 4,StackVM.Mul]) :: Maybe Program)

  describe "withVars" $ do
    context "when the provided variable exists in operation of Expr class" $
      it "returns value of expression" $
        withVars [("x", -6)] (add (lit 3) (var "x")) `shouldBe` Just (-3)

    context "when the provided variables exists in operation of Expr class" $
      it "returns value of expression" $
        withVars [("x", 6), ("y", 3)] (mul (var "x") (add (var "y") (var "x"))) `shouldBe` Just 54

    context "when the provided variable does not exists in operation of Expr class" $
      it "returns Nothing" $
        withVars [("x", 6)] (add (lit 3) (var "y")) `shouldBe` Nothing 
