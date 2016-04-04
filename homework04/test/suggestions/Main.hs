module Main
  ( main
  )
  where

-- base
import Control.Monad
import System.Exit

-- hlint
import qualified Language.Haskell.HLint as HLint


main :: IO ()
main = do
  suggestions <-
    HLint.hlint
      [ "src"
      ]
  unless (null suggestions) exitFailure
