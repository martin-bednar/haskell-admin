{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Spec.Admin.Server
  ( spec
  ) where

import Admin.Component.EmptyComponent
import Admin.Server
import Data.ByteString
import Network.HTTP.Types.Header
import Network.HTTP.Types.Method
import Network.Wai.Test (SResponse)
import Servant (Application)
import Test.Hspec
import Test.Hspec.Wai

app :: IO Application
app = return $ adminApp emptyComponent ["testApiKey"]

authHeader :: Header
authHeader = ("Authorization", "Bearer testApiKey")

getS :: ByteString -> WaiSession st SResponse
getS path = request methodGet path [authHeader] ""

spec :: Spec
spec =
  with app $ do
    describe "GET /" $ do
      it "responds to the root path" $ do getS "/" `shouldRespondWith` 200
    describe "GET /api_version" $ do
      it "responds with the API version" $ do
        getS "/api_version" `shouldRespondWith` 200 {matchBody = "\"1\""}
    describe "GET /components" $ do
      it "lists components" $ do
        getS "/components" `shouldRespondWith`
          200
            { matchBody =
                "[{\"componentName\":\"empty\",\"componentVersion\":\"1\"}]"
            }
    describe "authorization" $ do
      it "refuses unauthorized requests" $ do
        get "/" `shouldRespondWith` 401
        request methodGet "/" [("Authorization", "Bearer badKey")] "" `shouldRespondWith`
          401
