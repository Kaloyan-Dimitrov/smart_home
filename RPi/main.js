const admin = require('firebase-admin');
const Gpio = require('onoff').Gpio;
var LEDPin = new Gpio(4, 'out');
let serviceAccount = require('./SmartLamps-f44d9ee76876.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

let db = admin.firestore();
db.collection("lampStates").doc("main")
    .onSnapshot(function (doc) {
        console.log(LEDPin);
        console.log(Gpio);
        console.log("Current data: ", doc.data());
        console.log('Writing :', doc.data().isOn ? 1 : 0);
        LEDPin.writeSync(doc.data().isOn ? 1 : 0);
        // Here it should send a signal to the wifi module and the wifi module should turn the relay respectivaly on or off
    });