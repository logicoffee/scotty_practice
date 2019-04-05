{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString           as BS
import qualified Data.ByteString.Lazy      as BSLazy
import           Network.HTTP.Types.Header
import           Network.Wai.Test          (SResponse)
import           Test.Hspec
import           Test.Hspec.Wai            hiding (post)
import           Web.Route
import           Web.Scotty                (scottyApp)

main :: IO ()
main = hspec spec

spec :: Spec
spec = with (scottyApp route) $
    describe "POST /signup" $
        it "responds with user id" $
            post "/signup" "name=foo&password=ppp&password_confirmation&ppp"
                `shouldRespondWith` 200


post :: BS.ByteString -> BSLazy.ByteString -> WaiSession SResponse
post path = request "POST" path postHeaders

postHeaders :: [Header]
postHeaders = [(hContentType, "application/x-www-form-urlencoded")]
