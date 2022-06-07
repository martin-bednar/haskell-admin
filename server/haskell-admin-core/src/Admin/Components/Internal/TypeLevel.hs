{-# LANGUAGE StarIsType #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Admin.Components.Internal.TypeLevel
  ( NamesOf
  , NameOf
  , ApisOf
  , ApiOf
  , ManySymbolVal(..)
  ) where

import Admin.Components.Component (Component(..))
import Data.Data (Proxy(..))
import GHC.TypeLits (KnownSymbol, Symbol, symbolVal)
import Servant.API ((:<|>), (:>))

type family NameOf (x :: *) where
  NameOf (Component name api) = (name :: Symbol)

type family ApiOf (x :: *) where
  ApiOf (Component (name :: Symbol) api) = name :> api

type family NamesOf (xs :: [*]) where
  NamesOf '[] = '[]
  NamesOf (x ': xs) = NameOf x ': NamesOf xs

type family ApisOf (xs :: [*]) where
  ApisOf (x ': '[]) = ApiOf x
  ApisOf (x ': xs) = ApiOf x :<|> ApisOf xs

-- Type class ManySymbolVal
-- Source: https://stackoverflow.com/a/37365020
-- Author: Andrew Thaddeus Martin
class ManySymbolVal (xs :: [Symbol]) where
  manySymbolVal :: proxy xs -> [String]

instance ManySymbolVal '[] where
  manySymbolVal _ = []

instance (KnownSymbol a, ManySymbolVal as) =>
         ManySymbolVal (a ': as) where
  manySymbolVal _ =
    symbolVal (Proxy :: Proxy a) :
    manySymbolVal (Proxy :: Proxy as)
