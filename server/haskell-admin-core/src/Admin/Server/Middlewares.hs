{-# LANGUAGE OverloadedStrings, FlexibleContexts #-}

module Admin.Server.Middlewares
  ( middlewares
  ) where

import Admin.Server.AuthMiddleware
import Data.ByteString.Char8 (ByteString)
import Network.Wai (Middleware)
import Network.Wai.Middleware.Cors

-- | Middlewares used in Haskell Admin
middlewares :: [ByteString] -> Middleware
middlewares tokens = allowCors . tokenListAuth tokens

allowCors :: Middleware
allowCors = cors (const $ Just policy)

policy :: CorsResourcePolicy
policy =
  simpleCorsResourcePolicy
    {corsRequestHeaders = ["Authorization", "Content-Type"]}
