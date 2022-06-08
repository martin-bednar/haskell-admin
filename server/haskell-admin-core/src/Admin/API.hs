{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE StarIsType #-}
{-# LANGUAGE PolyKinds #-}

module Admin.API
  ( AdminAPI
  , ComponentsAPI
  ) where

import Admin.Components.ComponentDescription (ComponentDescription)
import Data.Version
import Servant

-- | The type-level definition of the Haskell Admin API
-- with server components as a parameter
type AdminAPI components = Root :<|> "components" :> ComponentsAPI components

type Root = Get '[ JSON] NoContent :<|> "api_version" :> Get '[ JSON] Version

type ComponentsAPI inner = Get '[ JSON] [ComponentDescription] :<|> inner
