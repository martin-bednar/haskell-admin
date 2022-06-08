{-# LANGUAGE DataKinds #-}

module Spec.Admin.Components
  ( spec
  ) where

import Admin.Components
import Test.Hspec as Hspec

import Admin.Components.ComponentDescription
  ( ComponentDescription(ComponentDescription)
  )
import Data.Version (makeVersion)
import Servant

components = cA `with` cB

cA :: Component "Comp. A" EmptyAPI
cA = Component {server = emptyServer, version = makeVersion [1]}

cB :: Component "Comp. B" EmptyAPI
cB = Component {server = emptyServer, version = makeVersion [2, 4]}

spec :: Spec
spec = do
  Hspec.describe "Admin.Components.ComponentList" $ do
    Hspec.describe "namesOf" $ do
      it "returns names of all components" $ do
        namesOf components `shouldBe` ["Comp. A", "Comp. B"]
    Hspec.describe "descriptionsOf" $ do
      it "returns descriptions of all components" $ do
        descriptionsOf components `shouldBe`
          [ ComponentDescription "Comp. A" (makeVersion [1])
          , ComponentDescription "Comp. B" (makeVersion [2, 4])
          ]
