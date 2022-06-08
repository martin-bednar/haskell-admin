module Main where
import Test.Hspec

import qualified Spec.Admin.Component.Managed

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "Spec.Admin.Component.Managed" Spec.Admin.Component.Managed.spec
