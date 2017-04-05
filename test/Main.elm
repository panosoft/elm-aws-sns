module Main exposing (main)

import Aws.Sns as Sns
import Aws.Sns.LowLevel as LowLevel
import Task


-- HACK, necessary otherwise Json.Decode is not included in compiled js eventhough Platform.programWithFlags uses it

import Json.Decode


type alias Flags =
    { accessKeyId : String
    , secretAccessKey : String
    , smsDestination : String
    }


type alias Model =
    {}


type Msg
    = SendComplete (Result String String)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        config =
            Sns.config flags.accessKeyId flags.secretAccessKey "us-west-2" "VetPro"

        destination =
            flags.smsDestination

        message =
            "Hello from elm-node/aws-sns"
    in
        {}
            ! [ Sns.sendTransactionalSms config destination message SendComplete
              , Sns.sendPromotionalSms config destination message SendComplete
              , LowLevel.sendSms LowLevel.Promotional config destination message
                    |> Task.attempt SendComplete
              ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendComplete result ->
            let
                message =
                    Debug.log "PublishComplete" result
            in
                model ! []


main : Program Flags Model Msg
main =
    Platform.programWithFlags
        { init = init
        , update = update
        , subscriptions = always Sub.none
        }
