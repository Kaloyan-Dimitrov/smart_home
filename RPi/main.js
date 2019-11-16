const admin = require('firebase-admin');

let serviceAccount = require('c:/Users/kaloy/Desktop/Projects/smart_home/RPi/smartlamps-c8015-839601f81fdc.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

let db = admin.firestore();
db.collection("lampStates").doc("main")
    .onSnapshot(function (doc) {
        console.log("Current data: ", doc.data());
    });