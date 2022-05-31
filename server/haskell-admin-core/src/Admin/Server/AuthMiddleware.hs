{-
  This module is based on $Network.Wai.Middleware.HttpAuth$ of the $wai-extra$ package.

  https://hackage.haskell.org/package/wai-extra-3.1.11/docs/Network-Wai-Middleware-HttpAuth.html
-}
{-# LANGUAGE OverloadedStrings #-}

module Admin.Server.AuthMiddleware
  ( tokenAuth
  , CheckTok
  , tokenListAuth
  ) where

import Data.ByteString (ByteString)
import qualified Data.ByteString as S
import Data.Word8 (isSpace, toLower)
import Network.HTTP.Types
  ( hAuthorization
  , hContentType
  , status401
  )
import Network.Wai
  ( Middleware
  , Request(requestHeaders)
  , Response
  , responseLBS
  )

-- | Check if a given token is valid.
type CheckTok = ByteString -> IO Bool

-- | Perform token authentication
-- based on a list of allowed tokens
tokenListAuth :: [ByteString] -> Middleware
tokenListAuth tokens =
  tokenAuth (\tok -> return $ tok `elem` tokens)

-- | Perform token authentication.
--
-- > tokenAuth (\tok -> return $ tok == "abcd" )
tokenAuth :: CheckTok -> Middleware
tokenAuth checkCreds app req sendResponse = do
  allowed <- check checkCreds req
  if allowed
    then app req sendResponse
    else sendResponse rspUnauthorized

check ::
     Monad m => (ByteString -> m Bool) -> Request -> m Bool
check checkCreds req =
  case lookup hAuthorization (requestHeaders req) >>=
       extractBearerAuth of
    Nothing -> return False
    Just token -> checkCreds token

rspUnauthorized :: Response
rspUnauthorized =
  responseLBS
    status401
    [ (hContentType, "text/plain")
    , ("WWW-Authenticate", "Bearer")
    ]
    "Bearer token authentication is required"

-- | Extract bearer authentication data from __Authorization__ header
-- value. Returns bearer token
--
-- Source: https://hackage.haskell.org/package/wai-extra-3.1.11/docs/Network-Wai-Middleware-HttpAuth.html
extractBearerAuth :: ByteString -> Maybe ByteString
extractBearerAuth bs =
  let (x, y) = S.break isSpace bs
   in if S.map toLower x == "bearer"
        then Just $ S.dropWhile isSpace y
        else Nothing
