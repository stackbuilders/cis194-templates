----------------------------------------------------------------------
-- |
--
-- CIS 194 Spring 2013: Homework 03
--
----------------------------------------------------------------------

module Homework03.Golf where

----------------------------------------------------------------------
-- Exercise 1
----------------------------------------------------------------------

-- |
--
-- >>> skips "ABCD"
-- ["ABCD","BD","C","D"]
-- >>> skips "hello!"
-- ["hello!","el!","l!","l","o","!"]
-- >>> skips [1]
-- [[1]]
-- >>> skips [True, False]
-- [[True,False],[False]]
-- >>> skips []
-- []

skips :: [a] -> [[a]]
skips = undefined

----------------------------------------------------------------------
-- Exercise 2
----------------------------------------------------------------------

-- |
--
-- >>> localMaxima [2,9,5,6,1]
-- [9,6]
-- >>> localMaxima [2,3,4,1,5]
-- [4]
-- >>> localMaxima [1,2,3,4,5]
-- []

localMaxima :: [Integer] -> [Integer]
localMaxima = undefined

----------------------------------------------------------------------
-- Exercise 3
----------------------------------------------------------------------

-- |
--
-- >>> putStr (histogram [1,1,1,5])
--  *
--  *
--  *   *
-- ==========
-- 0123456789
-- >>> putStr (histogram [1,4,5,4,6,6,3,4,2,4,9])
--     *
--     *
--     * *
--  ******  *
-- ==========
-- 0123456789

histogram :: [Integer] -> String
histogram = undefined
