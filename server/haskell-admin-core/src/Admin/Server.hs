{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RankNTypes #-}

module Admin.Server
  ( adminApp
  , serveAdmin
  ) where

import Admin.API
import Admin.Components
import Admin.Server.Middlewares (middlewares)
import Data.ByteString.Char8 (ByteString)
import Data.Version
import Servant

adminApp :: Components a names api => a -> [ByteString] -> Application
adminApp c =
  let p = (Proxy :: Proxy (AdminAPI api))
   in adminApp' c p

adminApp' ::
     Components a names api
  => a
  -> Proxy (AdminAPI api)
  -> [ByteString]
  -> Application
adminApp' c proxy tokens = withMiddlewares tokens $ serve proxy $ serveAdmin c

withMiddlewares :: [ByteString] -> Application -> Application
withMiddlewares = middlewares

serveAdmin :: Components a names api => a -> Server (AdminAPI api)
serveAdmin c = handleRoot :<|> serveComponents c

serveComponents :: Components a names apis => a -> Server (ComponentsAPI apis)
serveComponents c = return (describe c) :<|> serveAll' c

handleRoot = return NoContent :<|> return (makeVersion [1])
