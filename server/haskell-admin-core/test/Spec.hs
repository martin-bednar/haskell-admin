module Main
  ( main
  ) where

import Test.Hspec

import qualified Spec.Admin.Components
import qualified Spec.Admin.Server

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "Spec.Admin.Components" Spec.Admin.Components.spec
  describe "Spec.Admin.Server" Spec.Admin.Server.spec
