{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Spec.Admin.Component.Health
  ( spec
  ) where

import Admin.Component.Health
import Control.Concurrent
import Servant
import Test.Hspec
import Test.Hspec.Wai

myProgram :: IO Int
myProgram = threadDelay 10000 >> return 5

app :: IO Application
app = do
  as <- async myProgram
  return $ serve (Proxy @HealthAPI) $ serveHealth as

spec :: Spec
spec =
  with app $ do
    describe "GET /status" $ do
      it "yields the correct status" $ do
        get "/status" `shouldRespondWith`
          200 {matchBody = "{\"tag\":\"Running\"}"}
        liftIO $ threadDelay 20000 -- Wait until myProgram stops
        get "/status" `shouldRespondWith`
          200
            { matchBody =
                "{\"tag\":\"Finished\",\"contents\":\"5\"}"
            }
