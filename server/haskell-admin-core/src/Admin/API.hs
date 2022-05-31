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

import Servant

-- | The type-level definition of the Haskell Admin API
-- with server components as a parameter
type AdminAPI components
   = Root :<|> "components" :> ComponentsAPI components

type Root = Get '[ JSON] NoContent

type ComponentsAPI inner = Get '[ JSON] [String] :<|> inner
