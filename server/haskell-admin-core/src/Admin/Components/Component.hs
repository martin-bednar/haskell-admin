{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Admin.Components.Component
  ( Component(..)
  ) where

import Data.Version
import GHC.TypeLits (Symbol)
import Servant

data Component (name :: Symbol) api =
  Component
    { server :: Server api
    , version :: Version
    }
