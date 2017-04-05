module Aws.Sns.LowLevel exposing (Config, SmsType(..), sendSms)

{-| Low-level bindings to the [AWS Simple Notification Service](http://docs.aws.amazon.com/sns/latest/dg/welcome.html) client for javascript.

# SMS
@docs Config, SmsType, sendSms
-}

import Native.Sns
import Task exposing (Task)


{-| Configuration for sending an SMS message.

From the [AWS SDK Documentation](http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/SNS.html#constructor-property) and [AWS SNS Documentation](http://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html):

- `accessKeyId` - your AWS access key ID.
- `secretAccessKey` - your AWS secret access key.
- `region` - the region to send service requests to. See AWS.SNS.region for more information.
- `senderId` - A custom ID that contains up to 11 alphanumeric characters, including at least one letter and no spaces. The sender ID is displayed as the message sender on the receiving device ... If you do not specify a sender ID, the message will display a long code as the sender ID in supported countries. For countries that require an alphabetic sender ID, the message displays NOTICE as the sender ID.
-}
type alias Config =
    { accessKeyId : String
    , secretAccessKey : String
    , region : String
    , senderId : String
    }


{-| The type of SMS message.

From the [AWS SNS Documentation](http://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html):

- `Promotional` - Noncritical messages, such as marketing messages. Amazon SNS optimizes the message delivery to incur the lowest cost.
- `Transactional` - Critical messages that support customer transactions, such as one-time passcodes for multi-factor authentication. Amazon SNS optimizes the message delivery to achieve the highest reliability.
-}
type SmsType
    = Promotional
    | Transactional


{-| A low level method for sending an SMS message.

This is useful in cases where you would like to chain tasks together and then produce a single command.

```
type Msg = SendComplete (Result String String)

config = Sns.config
    "ACCESS_KEY_ID"
    "SECRET_ACCESS_KEY"
    "AWS_REGION"
    "SENDER_ID"

sendSms config "(123) 456-7890" "Hello from aws-sns!" SendComplete
```
-}
sendSms : SmsType -> Config -> String -> String -> Task String String
sendSms =
    Native.Sns.sendSms
