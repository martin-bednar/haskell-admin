module Main where

import Spec.Admin.Components
import Test.Hspec

main :: IO ()
main =
  hspec $ do
    describe "Admin.Components" Spec.Admin.Components.spec
