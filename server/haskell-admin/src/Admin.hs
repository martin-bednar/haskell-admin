module Admin
  ( admin
  , with
  ) where

import Admin.Components
import Admin.Server (adminApp)
import Data.ByteString.Char8 (ByteString)
import Network.Wai (Application)

-- | Create WAI application containing the Haskell Admin server 
-- based on the provided Components and authentication tokens
admin ::
     Components components names api
  => [ByteString]
  -> components
  -> Application
admin tokens c = adminApp c tokens
