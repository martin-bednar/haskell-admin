{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE ExplicitForAll #-}

module Admin.Components.ComponentDescription where

import Data.Aeson (FromJSON, ToJSON)
import Data.Version (Version)
import GHC.Generics (Generic)

data ComponentDescription =
  ComponentDescription
    { componentName :: String
    , componentVersion :: Version
    }
  deriving (Read, Show, Eq, Generic, ToJSON, FromJSON)
