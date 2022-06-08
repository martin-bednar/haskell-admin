module Main where

import Test.Hspec

import qualified Spec.Admin.Component.Health

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "Spec.Admin.Component.Health" Spec.Admin.Component.Health.spec
