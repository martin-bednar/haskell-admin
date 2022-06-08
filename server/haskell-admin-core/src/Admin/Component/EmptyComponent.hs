{-# LANGUAGE DataKinds #-}

module Admin.Component.EmptyComponent
  ( emptyComponent
  ) where

import Admin.Components
import Data.Version (makeVersion)
import Servant

emptyComponent :: Component "empty" EmptyAPI
emptyComponent = Component {server = emptyServer, version = makeVersion [1]}
