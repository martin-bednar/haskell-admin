{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Admin.Components.ComponentList
  ( ComponentList(..)
  , namesOf
  , descriptionsOf
  , empty
  ) where

import Admin.Components.ComponentDescription
import Admin.Components.Internal.TypeLevel (ManySymbolVal, manySymbolVal)
import Data.Version
import GHC.TypeLits (Symbol)
import Servant

data ComponentList (names :: [Symbol]) apis =
  ComponentList
    { serveAll :: Server apis
    , versions :: [Version]
    }

namesOf ::
     forall names apis. (ManySymbolVal names)
  => ComponentList names apis
  -> [String]
namesOf _ = manySymbolVal (Proxy :: Proxy names)

descriptionsOf ::
     forall names apis. (ManySymbolVal names)
  => ComponentList names apis
  -> [ComponentDescription]
descriptionsOf cs = zipWith ComponentDescription (namesOf cs) (versions cs)

empty :: ComponentList '[] EmptyAPI
empty = ComponentList emptyServer [makeVersion [1]]
