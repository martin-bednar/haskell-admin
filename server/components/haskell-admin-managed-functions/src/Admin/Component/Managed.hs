{-# LANGUAGE DataKinds #-}

module Admin.Component.Managed
  ( ManagedAPI
  , ManagedComponent
  , managed
  , serveManaged
  , module Managed
  ) where

import Admin.Components
import Managed
import Managed.Connectors.HTTPConnector
import Servant
import Data.Version (makeVersion)

type ManagedAPI = HTTPConnectorAPI

type ManagedComponent = Component "managed" ManagedAPI

managed :: Agent SR -> ManagedComponent
managed agent 
  = Component 
  { server = serveManaged agent
  , version = makeVersion [1]
  }

serveManaged :: Agent SR -> Server ManagedAPI
serveManaged = httpConnectorServer
