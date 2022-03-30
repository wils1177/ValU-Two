const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.plaidWebhook = functions.https.onRequest((request, response) => {


	var db = admin.firestore();
		var clientId;
		
		db.collection('items').doc(request.body.item_id).get()
		  .then((snapshot) => {
		    clientId = snapshot.data().clientId
		    

		    var message = {
            
				  data: {
				    type: 'webhook',
				    webhookType: request.body.webhook_type,
				    webhookCode : request.body.webhook_code,
				    itemId : request.body.item_id
				  },
            apns: {
                headers: {  // Add these 3 lines
                  'apns-push-type': 'background',
                    'apns-priority' : '5'
                    },
                  payload: {
                      aps: {
                          "content-available": true
                      }
                  }
              },
				  token: clientId
				};
              
              
             
              
              
              
              

			// Send a message to the device corresponding to the provided
			// registration token.
			admin.messaging().send(message)
			  .then((messageResponse) => {
			    // Response is a message ID string.
			    console.log('Successfully sent message:', messageResponse);
			    response.send(clientId);
			    return "";
			  })
			  .catch((error) => {
			    console.log('Error sending message:', error);
			    response.send("Could not sned message")
			    return "";
			  });



		    return "";
		  })
		  .catch((err) => {
		    console.log('Error getting documents', err);
		    response.send("Could not find your itemId")
		    return "";
		  });



 });
