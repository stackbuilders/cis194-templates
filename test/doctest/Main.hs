module Main where

-- base
import System.Environment (getArgs)

-- doctest
import Test.DocTest

main :: IO ()
main = do
  args <- getArgs
  doctest (if null args then ["src"] else args)
