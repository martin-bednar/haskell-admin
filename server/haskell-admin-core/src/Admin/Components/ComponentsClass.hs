{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Admin.Components.ComponentsClass
  ( with
  , Components(..)
  ) where

import Admin.Components.Component
import Admin.Components.ComponentDescription
import Admin.Components.ComponentList
import Admin.Components.Internal.TypeLevel
import Data.Version
import GHC.TypeLits (KnownSymbol, Symbol, symbolVal)
import Servant

type ToServantAPI names api = (ManySymbolVal names, HasServer api '[])

class (ToServantAPI names apis) =>
      Components a (names :: [Symbol]) apis
  | a -> names apis
  where
  serveAll' :: a -> Server apis
  describe :: a -> [ComponentDescription]

instance (KnownSymbol name, HasServer api '[]) =>
         Components (Component name api) '[ name] (name :> api) where
  serveAll' c = server c
  describe c =
    let n = symbolVal (Proxy :: Proxy name)
        v = version c
     in [ComponentDescription n v]

instance (ToServantAPI names apis) =>
         Components (ComponentList names apis) names apis where
  serveAll' c = serveAll c
  describe c = descriptionsOf c

getVersions :: Components a names apis => a -> [Version]
getVersions = map componentVersion . describe

infixr 9 `with`

-- | Compose Components
--
-- This function combines a 'Component' with another 'Component',
-- or with a 'ComponentList', producing a 'ComponentList'.
--
-- It collects the names of the components,
-- and keeps the expected API structure.
--
-- Usage:
-- >>> componentA `with` componentB `with` componentC
with ::
     (Components a names apis)
  => Component name api
  -> a
  -> ComponentList (name : names) ((name :> api) :<|> apis)
with new lst =
  ComponentList (server new :<|> serveAll' lst) (version new : getVersions lst)
