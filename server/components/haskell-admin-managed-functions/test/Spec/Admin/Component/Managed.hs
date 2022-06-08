{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Spec.Admin.Component.Managed
  ( spec
  ) where

import Admin.Component.Managed hiding (describe)
import Servant
import Test.Hspec
import Test.Hspec.Wai

app :: IO Application
app = do
  let ag = fromList [("plusOne", toProbe ((+ 1) :: Int -> Int))]
  return $ serve (Proxy @ManagedAPI) $ serveManaged ag

spec :: Spec
spec =
  with app $ do
    describe "GET /probes" $ do
      it "lists probes" $ do
        get "/probes" `shouldRespondWith` 200 {matchBody = "[\"plusOne\"]"}
    describe "GET /probes/plusOne" $ do
      it "describes a probe" $ do
        get "/probes/plusOne" `shouldRespondWith`
          200
            { matchBody =
                "{\"probeID\":\"plusOne\",\"probeParams\":[\"Int\"],\"probeReturns\":\"Int\",\"probeType\":\"Int -> Int\"}"
            }
    describe "POST /probes/plusOne/invoke" $ do
      it "invokes a probe" $
        do request
             "POST"
             "/probes/plusOne/invoke"
             [("content-type", "application/json")]
             "[\"3\"]"
           `shouldRespondWith` 200 {matchBody = "\"4\""}
