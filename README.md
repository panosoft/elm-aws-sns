# AWS Simple Notification Service

> Native bindings for Amazon's Simple Notification Service javascript client.

# Install

```
npm install elm-node/aws-sns
```

# Test

```
npm test <aws-accessKeyId> <aws-secretAccessKey> <sms-phoneNumber>
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
- [x] document
- install everything via `npm install`
    - [ ] run `npm install` which takes care of node_modules and node dependencies
    - run [preinstall, install, postinstall] scripts to take care of the rest
        * think postinstall may be what we need
        * elm dependency tree is flat
        * maybe make a separate repo to test install process
        ? need global install of elm to make elm-github-install work?
        ? can we make use of advanced features of elm-github-install? (instead of using our fork?)
            I think this will work!
        - [ ] create elm-package.json if doesn't exist
        - [ ] add package info to elm-package.json
        - [ ] run elm-github-install
- [ ] automatically generate module documentation
    elm-tools/documentation
    place in `docs/`
    add links to module documentation at end of readme in `API` section
- [ ] publish to npm
    - also need to make sure github tag matches if elm-github-install used ...
