{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Admin.Server.AuthMiddleware (tokenListAuth)
import Servant
import Test.Hspec
import Test.Hspec.Wai

type API = Get '[ JSON] NoContent

secureApp :: IO Application
secureApp =
  return $
  tokenListAuth ["abc", "123"] $
  serve (Proxy @API) $ return NoContent

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  with secureApp $ do
    describe "GET /" $ do
      it "accepts valid token" $ do
        let validHeader1 = ("Authorization", "Bearer abc")
        request "GET" "/" [validHeader1] "" `shouldRespondWith`
          200
        let validHeader2 = ("Authorization", "Bearer 123")
        request "GET" "/" [validHeader2] "" `shouldRespondWith`
          200
      it "rejects invalid token" $ do
        let invalidHeader = ("Authorization", "Bearer abcd")
        request "GET" "/" [invalidHeader] "" `shouldRespondWith`
          401
      it "rejects missing token" $ do
        get "/" `shouldRespondWith` 401
