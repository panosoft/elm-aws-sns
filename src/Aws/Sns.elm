module Aws.Sns
    exposing
        ( config
        , sendPromotionalSms
        , sendTransactionalSms
        )

{-| AWS Simple Notification Service makes it simple to send notifications to devices.

# SMS
@docs config, sendPromotionalSms, sendTransactionalSms
-}

import Aws.Sns.LowLevel as LowLevel exposing (Config, SmsType(Promotional, Transactional))
import Task


{-| Create a configuration for sending an SMS message.

```
config = Sns.config
    "ACCESS_KEY_ID"
    "SECRET_ACCESS_KEY"
    "AWS_REGION"
    "SENDER_ID"
```
-}
config : String -> String -> String -> String -> Config
config =
    Config


{-| Send a promotional sms.

From [AWS Documentation](http://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html):
> Noncritical messages, such as marketing messages. Amazon SNS optimizes the message delivery to incur the lowest cost.

```
type Msg = SendComplete (Result String String)

sendPromotionalSms config "(123) 456-7890" "Hello from aws-sns!" SendComplete
```
-}
sendPromotionalSms : Config -> String -> String -> (Result String String -> msg) -> Cmd msg
sendPromotionalSms config destination message tagger =
    LowLevel.sendSms Promotional config destination message
        |> Task.attempt tagger


{-| Send a transactional sms.

From [AWS Documentation](http://docs.aws.amazon.com/sns/latest/dg/sms_publish-to-phone.html):
> Critical messages that support customer transactions, such as one-time passcodes for multi-factor authentication. Amazon SNS optimizes the message delivery to achieve the highest reliability.

```
type Msg = SendComplete (Result String String)

sendTransactionalSms config "(123) 456-7890" "Hello from aws-sns!" SendComplete
```
-}
sendTransactionalSms : Config -> String -> String -> (Result String String -> msg) -> Cmd msg
sendTransactionalSms config destination message tagger =
    LowLevel.sendSms Transactional config destination message
        |> Task.attempt tagger
