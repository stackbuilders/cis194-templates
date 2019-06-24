{-# LANGUAGE ScopedTypeVariables #-}

module Homework06.FibonacciSpec
  ( main
  , spec
  )
  where

import Homework06.Fibonacci

-- QuickCheck
import Test.QuickCheck

-- hspec
import Test.Hspec
import Test.Hspec.QuickCheck

main :: IO ()
main =
  hspec spec

spec :: Spec
spec = do
  describe "Exercise 1" $ do
    describe "fib" $ do
      it "fib 0 == 0" $
        fib 0 `shouldBe` 0
      it "fib 1 == 1" $
        fib 1 `shouldBe` 1
      it "fib 2 == 1" $
        fib 2 `shouldBe` 1
      it "fib 3 == 2" $
        fib 3 `shouldBe` 2
      it "fib 4 == 3" $
        fib 4 `shouldBe` 3
      prop "n >= 2 ==> fib n == fib (n - 1) + fib (n - 2)" $
        \(Positive n') ->
          let
            n = mod n' 19
          in
            fib (n + 2) == fib (n + 1) + fib n
    describe "fibs1" $ do
      it "take 15 fibs1 == [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377]" $
        take 15 fibs1 `shouldBe` [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377]
      prop "take n fibs1 == [fib 0, fib 1, ..., fib (n - 1)]" $
        \(Positive n') ->
          let
            n = mod n' 19
          in
            take (fromInteger n) fibs1 `shouldBe` fmap fib [0..n - 1]
  describe "Exercise 2" $
    describe "fibs2" $ do
      it "take 15 fibs2 == [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377]" $
        take 15 fibs2 `shouldBe` [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377]
      it "fib 59 == 956722026041" $
        last (take 60 fibs2) `shouldBe` 956722026041
      it "fib 119 == 3311648143516982017180081" $
        last (take 120 fibs2) `shouldBe` 3311648143516982017180081
      prop "n >= 2 ==> fib n == fib (n - 1) + fib (n - 2)" $
        \(Positive n) ->
          fibs2 !! (n + 2) == fibs2 !! (n + 1) + fibs2 !! n
  describe "Exercise 4" $ do
    describe "streamRepeat" $ do
      it "streamRepeat True == [True, True, ...]" $
        testStream 5 (streamRepeat True) [True, True, True, True, True]
      prop "streamRepeat == repeat" $
        \(Positive n, m :: Int) ->
          testStream n (streamRepeat m) (repeat m)
    describe "streamMap" $ do
      prop "streamMap f (streamRepeat x) == streamRepeat (f x)" $
        \(Positive n, f :: Fun Int Int, m) ->
          let
            stream1 = streamMap (applyFun f) (streamRepeat m)
            stream2 = streamRepeat (applyFun f m)
          in
            testStream n stream1 (streamToList stream2)
      prop "streamMap id == id" $
        \(Positive n, f :: Fun Int Int, m) ->
          let
            stream = streamFromSeed (applyFun f) m
          in
            testStream n (streamMap id stream) (streamToList stream)
      prop "streamMap (g . f) == streamMap g . streamMap f" $
        \(Positive n, s :: Fun Int Int, m, f, g :: Fun Int Int) ->
          let
            stream = streamFromSeed (applyFun s) m
            stream1 = streamMap (applyFun g . applyFun f) stream
            stream2 = streamMap (applyFun g) (streamMap (applyFun f) stream)
          in
            testStream n stream1 (streamToList stream2)
    describe "streamFromSeed" $ do
      it "streamFromSeed not True == [True, False, True, False, ...]" $
        testStream 5 (streamFromSeed not True) [True, False, True, False, True]
      prop "streamFromSeed f == iterate f" $
        \(Positive n, f :: Fun Int Int, m) ->
          testStream n (streamFromSeed (applyFun f) m) (iterate (applyFun f) m)
      prop "streamFromSeed id == streamRepeat" $
        \(Positive n) ->
          testStream n (streamFromSeed id n) (streamToList (streamRepeat n))
  describe "Exercise 5" $ do
    describe "nats" $ do
      it "take 20 nats == [0, 1, ..., 19]" $
        testStream 20 nats [0..19]
      prop "nats == [0, 1, ...]" $
        \(Positive n) ->
          testStream n nats [0..]
    describe "ruler" $ do
      it "take 10 ruler == [0,1,0,2,0,1,0,3,0,1]" $
        testStream 10 ruler [0,1,0,2,0,1,0,3,0,1]
      it "take 20 ruler == [0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,0,1,0,2]" $
        testStream 20 ruler [0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,0,1,0,2]
  where
    testStream n stream list =
      take n (streamToList stream) `shouldBe` take n list
