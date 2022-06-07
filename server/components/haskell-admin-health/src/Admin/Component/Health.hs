{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Admin.Component.Health
  ( HealthAPI
  , HealthComponent
  , health
  , serveHealth
  , Control.Concurrent.Async.async
  , Control.Concurrent.Async.Async
  ) where

import Admin.Components
import Control.Concurrent.Async (Async, async)
import Control.Monad.IO.Class (MonadIO, liftIO)
import Data.ApplicationState
import Servant.API

type HealthAPI = "status" :> Get '[ JSON] ApplicationState

type HealthComponent = Component "health" HealthAPI

health :: (Show a) => Async a -> HealthComponent
health as = Component {server = serveHealth as}

serveHealth ::
     (MonadIO m, Show a) => Async a -> m ApplicationState
serveHealth as = liftIO $ stateOf as


