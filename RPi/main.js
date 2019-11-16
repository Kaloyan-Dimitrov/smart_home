const admin = require('firebase-admin');

let serviceAccount = require('./SmartLamps-f44d9ee76876.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

let db = admin.firestore();
db.collection("lampStates").doc("main")
    .onSnapshot(function (doc) {
        console.log("Current data: ", doc.data());
        // Here it should send a signal to the wifi module and the wifi module should turn the relay respectivaly on or off
    });