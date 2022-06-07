{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Admin.Components.ComponentList
  ( ComponentList(..)
  , namesOf
  , empty
  ) where

import Admin.Components.Internal.TypeLevel
  ( ManySymbolVal
  , manySymbolVal
  )
import GHC.TypeLits (Symbol)
import Servant

newtype ComponentList (names :: [Symbol]) apis =
  ComponentList
    { serveAll :: Server apis
    }

namesOf ::
     forall names apis. (ManySymbolVal names)
  => ComponentList names apis
  -> [String]
namesOf _ = manySymbolVal (Proxy :: Proxy names)

empty :: ComponentList '[] EmptyAPI
empty = ComponentList emptyServer
