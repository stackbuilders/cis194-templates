----------------------------------------------------------------------
-- |
--
-- CIS 194 Spring 2013: Homework 01
--
----------------------------------------------------------------------

module Basis where

----------------------------------------------------------------------
-- Exercise 1
----------------------------------------------------------------------

-- |
--
-- >>> toDigits 1234
-- [1,2,3,4]
-- >>> toDigits 0
-- []
-- >>> toDigits (-17)
-- []

toDigits :: Integer -> [Integer]
toDigits n 
  | n > 0     = toDigits (div n 10) ++ [mod n 10]
  | otherwise = [] 

----------------------------------------------------------------------
-- Exercise 2
----------------------------------------------------------------------

-- |
--
-- >>> doubleEveryOther [8,7,6,5]
-- [16,7,12,5]
-- >>> doubleEveryOther [1,2,3]
-- [1,4,3]

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther = reverse . zipWith (*) (cycle [1,2]) . reverse

----------------------------------------------------------------------
-- Exercise 3
----------------------------------------------------------------------

-- |
--
-- >>> sumDigits [16,7,12,5]
-- 22

sumDigits :: [Integer] -> Integer
sumDigits = foldl (\acc n -> acc + sum (toDigits n)) 0

----------------------------------------------------------------------
-- Exercise 4
----------------------------------------------------------------------

-- |
--
-- >>> validate 4012888888881881
-- True
-- >>> validate 4012888888881882
-- False

validate :: Integer -> Bool
validate number = mod (sumDigits $ doubleEveryOther $ toDigits number) 10 == 0

----------------------------------------------------------------------
-- Exercise 5
----------------------------------------------------------------------

type Peg = String
type Move = (Peg, Peg)

-- |
--
-- >>> hanoi 2 "a" "b" "c"
-- [("a","c"),("a","b"),("c","b")]

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 _ _ _ = []
hanoi n a b c = hanoi (n-1) a c b ++ [(a,b)] ++ hanoi (n-1) c b a

----------------------------------------------------------------------
-- Exercise 6 (Optional)
----------------------------------------------------------------------

hanoi' :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
hanoi' = undefined -- Work still in progress!
