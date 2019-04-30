module Main where

import Control.Monad
import Language.Haskell.HLint
import System.Environment
import System.Exit

main :: IO ()
main = do
  hints <- hlint ["src"]
  unless (null hints) exitFailure
