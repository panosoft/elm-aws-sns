# AWS Simple Notification Service

> Effect Manager for Elm.

# Install

```
npm install
```

# Test

```
npm test <aws-accessKeyId> <aws-secretAccessKey> <smsDestination-phoneNumber>
```

# TODO

- test app
    - [x] pass aws credentials in as arguments to `npm test`
    - [x] test high level sendSms
    - [x] test low level sendSms
- sendSms
    - [x] low level call that returns `Task`
    - [x] high level call that returns `Cmd msg`
- [x] union type for smsType
- install everything via `npm install`
    - [ ] node_modules
    - [ ] elm-package.json
    - [ ] elm-stuff
- [ ] documentation
    elm-tools/documentation
