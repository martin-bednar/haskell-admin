{-# LANGUAGE OverloadedStrings #-}

module Main where

import Admin
import Admin.Components.All hiding (run)
import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import Network.Wai.Handler.Warp (run)

data Msg
  = Hello
  | Custom String
  deriving (Show, Read, Eq)

defaultMsg :: Msg
defaultMsg = Hello

defaultInterval :: Int
defaultInterval = 1000000

main :: IO ()
main = do
  msg <- newMVar defaultMsg
  interval <- newMVar defaultInterval
  formerMain <- async $ mainLoop msg interval
  let components = health formerMain `with` managed agent
      apiKeys = ["myApiKey"]
      agent :: Agent SR
      agent =
        fromList
          [ ("setMsg", toProbe $ swapMVar msg)
          , ("setInterval", toProbe $ swapMVar interval)
          ]
  run 3001 $ admin apiKeys components

mainLoop :: MVar Msg -> MVar Int -> IO ()
mainLoop msg interval =
  forever $ do
    readMVar msg >>= print
    readMVar interval >>= threadDelay
