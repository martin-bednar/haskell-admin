{-# LANGUAGE DataKinds #-}

module Spec.Admin.Components
  ( spec
  ) where

import Admin.Components
import Test.Hspec

import Servant

components = cA `with` cB

cA :: Component "Comp. A" EmptyAPI
cA = Component {server = emptyServer}

cB :: Component "Comp. B" EmptyAPI
cB = Component {server = emptyServer}

spec :: Spec
spec = do
  describe "Data.ComponentList" $ do
    describe "namesOf" $ do
      it "prints names of all components" $ do
        namesOf components `shouldBe` ["Comp. A", "Comp. B"]
