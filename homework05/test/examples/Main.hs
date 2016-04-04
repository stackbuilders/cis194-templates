module Main
  ( main
  )
  where

-- doctest
import qualified Test.DocTest as DocTest


main :: IO ()
main =
  DocTest.doctest
    [ "-isrc"
    , "src/Calc.hs"
    ]
