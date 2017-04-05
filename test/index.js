const App = require('./main.js')

// Get credentials
const accessKeyId = process.argv[2]
const secretAccessKey = process.argv[3]
const smsDestination = process.argv[4]

if (process.argv.length !== 5)
    throw new Error(`Incorrect usage: npm test ${accessKeyId} ${secretAccessKey} ${smsDestination}`)

// Start app
const flags = {
    accessKeyId,
    secretAccessKey,
    smsDestination
}
App.Main.worker(flags)
