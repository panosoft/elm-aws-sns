var _panosoft$elm_aws_sns$Native_Sns = function() {
    const Sns = require('aws-sdk/clients/sns')
    const { PhoneNumberUtil, PhoneNumberFormat } = require('google-libphonenumber')
    const Scheduler = _elm_lang$core$Native_Scheduler;

    const apiVersion = "2010-03-31"

    const toE164 = (string, countryCode) => {
        const util = PhoneNumberUtil.getInstance()
        const phoneNumber = util.parse(string, countryCode)
        return util.format(phoneNumber, PhoneNumberFormat.E164)
    }

    /* Send SMS message to a single phone number
     */
    const sendSms = F4((smsType, config, destination, message) => {
        return Scheduler.nativeBinding(callback => {
            try {
                // Initialize sns client on every call to ensure purity
                const options = {
                    apiVersion: apiVersion,
                    credentials: {
                        accessKeyId: config.accessKeyId,
                        secretAccessKey: config.secretAccessKey
                    },
                    region: config.region
                }
                const sns = new Sns(options)

                // Send sms
                const params = {
                    Message: message,
                    PhoneNumber: toE164(destination, "US"),
                    MessageAttributes: {
                        "AWS.SNS.SMS.SenderID": { DataType: "String", StringValue: config.senderId },
                        "AWS.SNS.SMS.SMSType": { DataType: "String", StringValue: smsType.ctor }
                    }
                }
                // TODO remove test code
                // console.log(params.PhoneNumber, params.MessageAttributes["AWS.SNS.SMS.SMSType"].StringValue)
                sns.publish(params, (error, data) => {
                    if (error) callback(Scheduler.fail(error.message))
                    else callback(Scheduler.succeed(data.MessageId))
                })
            } catch (error) { callback(Scheduler.fail(error.message)) }
        })
    })

    return { sendSms }
}()
