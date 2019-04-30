module Homework01.BasisSpec where

import Homework01.Basis
import Test.Hspec

spec :: Spec
spec =
  describe "toDigits" $ do
    it "splits number in digits when the given number is positive" $
      toDigits 1234 `shouldBe` [1, 2, 3, 4]

    it "returns an empty list when the given number is zero" $
      toDigits 0 `shouldBe` []

    it "returns an empty list when the given number is negative" $
      toDigits (-17) `shouldBe` []
