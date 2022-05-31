{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Admin.Components
  ( with
  , Components(..)
  ) where

import Data.Component
import Data.ComponentList
import Admin.Components.Internal.TypeLevel (ManySymbolVal)
import GHC.TypeLits (KnownSymbol, Symbol, symbolVal)
import Servant

type ToServantAPI names api
   = (ManySymbolVal names, HasServer api '[])

class (ToServantAPI names apis) =>
      Components a (names :: [Symbol]) apis
  | a -> names apis
  where
  serveAll' :: a -> Server apis
  getNames :: a -> [String]

instance (KnownSymbol name, HasServer api '[]) =>
         Components (Component name api) '[ name] (name :> api) where
  serveAll' c = server c
  getNames _ = [symbolVal (Proxy :: Proxy name)]

instance (ToServantAPI names apis) =>
         Components (ComponentList names apis) names apis where
  serveAll' c = serveAll c
  getNames c = namesOf c

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
with new lst = ComponentList (server new :<|> serveAll' lst)
