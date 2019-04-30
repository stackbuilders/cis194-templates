{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Homework12.Risk where

import Control.Monad.Random

------------------------------------------------------------
-- Die values

newtype DieValue = DV { unDV :: Int }
  deriving (Eq, Num, Ord, Show)

first :: (a -> b) -> (a, c) -> (b, c)
first f (a, c) = (f a, c)

instance Random DieValue where
  random           = first DV . randomR (1,6)
  randomR (low,hi) = first DV . randomR (max 1 (unDV low), min 6 (unDV hi))

die :: Rand StdGen DieValue
die = getRandom


----------------------------------------------------------------------
-- Risk
----------------------------------------------------------------------

type Army =
  Int


data Battlefield =
  Battlefield
    { attackers :: Army
    , defenders :: Army
    }


----------------------------------------------------------------------
-- Exercise 2
----------------------------------------------------------------------

battle :: Battlefield -> Rand StdGen Battlefield
battle = undefined


----------------------------------------------------------------------
-- Exercise 3
----------------------------------------------------------------------

invade :: Battlefield -> Rand StdGen Battlefield
invade = undefined


----------------------------------------------------------------------
-- Exercise 4
----------------------------------------------------------------------

successProb :: Battlefield -> Rand StdGen Double
successProb = undefined
