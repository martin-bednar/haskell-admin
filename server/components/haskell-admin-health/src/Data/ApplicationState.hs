{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE LambdaCase #-}

module Data.ApplicationState
  ( ApplicationState(..)
  , stateOf
  ) where

import Control.Concurrent.Async (Async, poll)
import Control.Exception (SomeException)
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

-- | The state of a running Haskell application
-- or an running 'Async' action
data ApplicationState
  = Running -- ^ Application (action) is running
  | Finished String -- ^ Result of the async action
  | Error String -- ^ Description of the error (exception)
  deriving (Read, Show, Eq, Generic, ToJSON, FromJSON)

-- | Yields the 'ApplicationState' of an 'Async'
stateOf :: (Show a) => Async a -> IO ApplicationState
stateOf x = fromPollResult <$> poll x

-- | Converts the result of a 'Control.Concurrent.Async.poll' call to 'ApplicationState'
fromPollResult ::
     (Show a)
  => Maybe (Either SomeException a)
  -> ApplicationState
fromPollResult =
  \case
    Nothing -> Running
    Just (Left err) -> Error (show err)
    Just (Right val) -> Finished (show val)
