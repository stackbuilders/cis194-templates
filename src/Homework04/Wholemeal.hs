----------------------------------------------------------------------
-- |
--
-- CIS 194 Spring 2013: Homework 04
--
----------------------------------------------------------------------

module Homework04.Wholemeal where

----------------------------------------------------------------------
-- Exercise 1
----------------------------------------------------------------------

fun1 :: [Integer] -> Integer
fun1 []     = 1
fun1 (x:xs)
    | even x    = (x - 2) * fun1 xs
    | otherwise = fun1 xs

fun2 :: Integer -> Integer
fun2 1 = 0
fun2 n
  | even n    = n + fun2 (n `div` 2)
  | otherwise = fun2 (3*n + 1)

-- |
--
-- >>> fun1 [1,3,5,7] == fun1' [1,3,5,7]
-- True
-- >>> fun1 [1,2,3] /= fun1' [1,2,3]
-- False
-- >>> fun2 10 == fun2' 10
-- True
-- >>> fun2 15 /= fun2' 15
-- False

fun1' :: [Integer] -> Integer
fun1' = undefined

fun2' :: Integer -> Integer
fun2' = undefined

----------------------------------------------------------------------
-- Exercise 2
----------------------------------------------------------------------

data Tree a =
    Leaf
  | Node Integer (Tree a) a (Tree a)
    deriving (Show, Eq)

foldTree :: [a] -> Tree a
foldTree = undefined

----------------------------------------------------------------------
-- Exercise 3
----------------------------------------------------------------------

-- |
--
-- >>> xor [False, True, False]
-- True
-- >>> xor [False, True, False, False, True]
-- False

xor :: [Bool] -> Bool
xor = undefined

-- |
--
-- >>> map' (+1) [1,2,3]
-- [2,3,4]

map' :: (a -> b) -> [a] -> [b]
map' = undefined

-- Optional

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl = undefined

----------------------------------------------------------------------
-- Exercise 4
----------------------------------------------------------------------

-- |
--
-- >>> sieveSundaram 0
-- []
-- >>> sieveSundaram 1
-- [3]
-- >>> sieveSundaram 2
-- [3,5]
-- >>> sieveSundaram 3
-- [3,5,7]
-- >>> sieveSundaram 4
-- [3,5,7]
-- >>> sieveSundaram 5
-- [3,5,7,11]
-- >>> sieveSundaram 10
-- [3,5,7,11,13,17,19]

sieveSundaram :: Integer -> [Integer]
sieveSundaram = undefined
