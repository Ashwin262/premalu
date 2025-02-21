/**
 * Cloud Functions for handling ZegoCloud Call Invitation callbacks.
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

// Initialize Firebase Admin SDK
initializeApp();
const db = getFirestore();

/**
 * Configuration:
 *
 * 1.  Deploy this function to your Firebase project.
 * 2.  In your ZegoCloud project settings, configure the appropriate callback URLs to point to these functions.
 *
 *     Example URL (replace with your actual Firebase project and function name):
 *     https://us-central1-your-firebase-project-id.cloudfunctions.net/onSendCallInvitation
 *
 *     Important:  Ensure you're using HTTPS and that your ZegoCloud account is configured to send callbacks to HTTPS endpoints.
 *
 * 3.  Add the Firebase Admin SDK to your project: npm install firebase-admin
 *
 * Security Considerations:
 *
 * - **Authentication:** ZegoCloud callbacks should include some form of authentication (e.g., a shared secret key or JWT) to prevent unauthorized calls to your functions.  Implement this validation at the beginning of each function.  This example *does not* include authentication; you *must* add it!
 * - **Rate Limiting:** Implement rate limiting on your functions to prevent abuse.
 * - **Input Validation:** Thoroughly validate all data received in the request body to prevent injection attacks and other vulnerabilities.
 */

/**
 * Handles the `sendCallInvitation` callback from ZegoCloud.
 *
 * This function is triggered when a call invitation is sent.
 *
 *  Expected Payload Structure (Check ZegoCloud documentation for the precise format):
 *  {
 *      callID: string,            // Unique identifier for the call
 *      inviterID: string,         // User ID of the person sending the invitation
 *      inviteeList: [{userID: string}], // Array of user IDs being invited
 *      data: string               // Optional additional data associated with the invitation
 *      ...other properties         // Check ZegoCloud Documentation
 *  }
 */
exports.onSendCallInvitation = onRequest(async (request, response) => {
    try {
        logger.info("Send Call Invitation Callback Received", request.body);

        // *** IMPORTANT:  Add authentication/authorization here!  Verify the request is coming from ZegoCloud. ***
        // Example (replace with your actual secret):
        const authHeader = request.headers.authorization;
        if (!authHeader || authHeader !== `bc49613e29dc350e493c51a541774eb5`) {
            logger.error("Unauthorized access: Invalid authorization header");
            response.status(401).send("Unauthorized");
            return;
        }

        // Validate the request body (add more validation as needed)
        if (!request.body || !request.body.callID || !request.body.inviterID) {
            logger.error("Invalid request body: Missing required fields");
            response.status(400).send("Bad Request: Missing required fields");
            return;
        }

        const callID = request.body.callID;
        const inviterID = request.body.inviterID;
        const inviteeList = request.body.inviteeList;
        const data = request.body.data;

        // Store call invitation details in Firestore (or your preferred database)
        const callInvitationRef = db.collection("callInvitations").doc(callID);
        await callInvitationRef.set({
            callID: callID,
            inviterID: inviterID,
            inviteeList: inviteeList,
            data: data,
            status: "pending", // Initial status
            timestamp: new Date(),
        });

        logger.info(`Call invitation saved to Firestore with ID: ${callID}`);
        response.status(200).send("OK");

    } catch (error) {
        logger.error("Error processing sendCallInvitation callback:", error);
        response.status(500).send(`Internal Server Error: ${error}`);
    }
});


/**
 * Handles the `cancelCallInvitation` callback from ZegoCloud.
 *
 * Triggered when a call invitation is canceled.
 *
 * Expected Payload Structure (Check ZegoCloud documentation):
 * {
 *      callID: string,
 *      inviterID: string,
 *      ... other properties
 * }
 */
exports.onCancelCallInvitation = onRequest(async (request, response) => {
    try {
        logger.info("Cancel Call Invitation Callback Received", request.body);

        // *** IMPORTANT:  Add authentication/authorization here!  ***
        // Example (replace with your actual secret):
          const authHeader = request.headers.authorization;
        if (!authHeader || authHeader !== `Bearer YOUR_ZEGOCLOUD_SECRET_KEY`) {
            logger.error("Unauthorized access: Invalid authorization header");
            response.status(401).send("Unauthorized");
            return;
        }

        if (!request.body || !request.body.callID) {
            logger.error("Invalid request body: Missing callID");
            response.status(400).send("Bad Request: Missing callID");
            return;
        }

        const callID = request.body.callID;

        // Update the call invitation status in Firestore
        const callInvitationRef = db.collection("callInvitations").doc(callID);

        // Check if the document exists first
        const docSnapshot = await callInvitationRef.get();
        if (!docSnapshot.exists) {
            logger.warn(`Call invitation not found in Firestore: ${callID}`);
            response.status(404).send("Not Found: Call invitation not found"); // Or a 200 OK if you don't want to expose this information
            return;
        }

        await callInvitationRef.update({
            status: "cancelled",
            cancelledTimestamp: new Date(),
        });

        logger.info(`Call invitation status updated to cancelled for ID: ${callID}`);
        response.status(200).send("OK");

    } catch (error) {
        logger.error("Error processing cancelCallInvitation callback:", error);
        response.status(500).send(`Internal Server Error: ${error}`);
    }
});


/**
 * Handles the `acceptCallInvitation` callback from ZegoCloud.
 *
 * Triggered when a call invitation is accepted.
 *
 * Expected Payload Structure (Check ZegoCloud documentation):
 * {
 *      callID: string,
 *      inviteeID: string, // User ID of the person accepting the invitation
 *      ... other properties
 * }
 */
exports.onAcceptCallInvitation = onRequest(async (request, response) => {
    try {
        logger.info("Accept Call Invitation Callback Received", request.body);

        // *** IMPORTANT:  Add authentication/authorization here!  ***
        const authHeader = request.headers.authorization;
        if (!authHeader || authHeader !== `Bearer YOUR_ZEGOCLOUD_SECRET_KEY`) {
            logger.error("Unauthorized access: Invalid authorization header");
            response.status(401).send("Unauthorized");
            return;
        }
        if (!request.body || !request.body.callID || !request.body.inviteeID) {
            logger.error("Invalid request body: Missing callID or inviteeID");
            response.status(400).send("Bad Request: Missing callID or inviteeID");
            return;
        }

        const callID = request.body.callID;
        const inviteeID = request.body.inviteeID;

        // Update the call invitation status in Firestore
        const callInvitationRef = db.collection("callInvitations").doc(callID);

         // Check if the document exists first
        const docSnapshot = await callInvitationRef.get();
        if (!docSnapshot.exists) {
            logger.warn(`Call invitation not found in Firestore: ${callID}`);
            response.status(404).send("Not Found: Call invitation not found"); // Or a 200 OK if you don't want to expose this information
            return;
        }


        await callInvitationRef.update({
            status: "accepted",
            acceptTimestamp: new Date(),
            acceptingUser: inviteeID, // Track who accepted
        });

        logger.info(`Call invitation status updated to accepted for ID: ${callID}`);
        response.status(200).send("OK");

    } catch (error) {
        logger.error("Error processing acceptCallInvitation callback:", error);
        response.status(500).send(`Internal Server Error: ${error}`);
    }
});


/**
 * Handles the `rejectCallInvitation` callback from ZegoCloud.
 *
 * Triggered when a call invitation is rejected.
 *
 * Expected Payload Structure (Check ZegoCloud documentation):
 * {
 *      callID: string,
 *      inviteeID: string, // User ID of the person rejecting the invitation
 *      ... other properties
 * }
 */
exports.onRejectCallInvitation = onRequest(async (request, response) => {
    try {
        logger.info("Reject Call Invitation Callback Received", request.body);

        // *** IMPORTANT:  Add authentication/authorization here!  ***
         const authHeader = request.headers.authorization;
        if (!authHeader || authHeader !== `Bearer YOUR_ZEGOCLOUD_SECRET_KEY`) {
            logger.error("Unauthorized access: Invalid authorization header");
            response.status(401).send("Unauthorized");
            return;
        }

        if (!request.body || !request.body.callID || !request.body.inviteeID) {
            logger.error("Invalid request body: Missing callID or inviteeID");
            response.status(400).send("Bad Request: Missing callID or inviteeID");
            return;
        }

        const callID = request.body.callID;
        const inviteeID = request.body.inviteeID;

        // Update the call invitation status in Firestore
        const callInvitationRef = db.collection("callInvitations").doc(callID);

         // Check if the document exists first
        const docSnapshot = await callInvitationRef.get();
        if (!docSnapshot.exists) {
            logger.warn(`Call invitation not found in Firestore: ${callID}`);
            response.status(404).send("Not Found: Call invitation not found"); // Or a 200 OK if you don't want to expose this information
            return;
        }

        await callInvitationRef.update({
            status: "rejected",
            rejectTimestamp: new Date(),
            rejectingUser: inviteeID, // Track who rejected
        });

        logger.info(`Call invitation status updated to rejected for ID: ${callID}`);
        response.status(200).send("OK");

    } catch (error) {
        logger.error("Error processing rejectCallInvitation callback:", error);
        response.status(500).send(`Internal Server Error: ${error}`);
    }
});

/**
 * Handles the `callInvitationTimedOut` callback from ZegoCloud.
 *
 * Triggered when a call invitation times out.
 *
 * Expected Payload Structure (Check ZegoCloud documentation):
 * {
 *      callID: string,
 *      ... other properties
 * }
 */
exports.onCallInvitationTimedOut = onRequest(async (request, response) => {
    try {
        logger.info("Call Invitation Timed Out Callback Received", request.body);

        // *** IMPORTANT:  Add authentication/authorization here!  ***
         const authHeader = request.headers.authorization;
        if (!authHeader || authHeader !== `Bearer YOUR_ZEGOCLOUD_SECRET_KEY`) {
            logger.error("Unauthorized access: Invalid authorization header");
            response.status(401).send("Unauthorized");
            return;
        }

        if (!request.body || !request.body.callID) {
            logger.error("Invalid request body: Missing callID");
            response.status(400).send("Bad Request: Missing callID");
            return;
        }

        const callID = request.body.callID;

        // Update the call invitation status in Firestore
        const callInvitationRef = db.collection("callInvitations").doc(callID);

         // Check if the document exists first
        const docSnapshot = await callInvitationRef.get();
        if (!docSnapshot.exists) {
            logger.warn(`Call invitation not found in Firestore: ${callID}`);
            response.status(404).send("Not Found: Call invitation not found"); // Or a 200 OK if you don't want to expose this information
            return;
        }

        await callInvitationRef.update({
            status: "timed_out",
            timeoutTimestamp: new Date(),
        });

        logger.info(`Call invitation status updated to timed_out for ID: ${callID}`);
        response.status(200).send("OK");

    } catch (error) {
        logger.error("Error processing callInvitationTimedOut callback:", error);
        response.status(500).send(`Internal Server Error: ${error}`);
    }
});


/**
 *  Helper function (not a Firebase Function) to trigger the Firebase Functions locally,
 *  during development and testing.
 *
 *  Example Usage (using curl in a separate terminal):
 *  curl -X POST -H "Content-Type: application/json" -d '{"callID": "12345", "inviterID": "userA", "inviteeList": [{"userID": "userB"}]}' http://localhost:5001/your-firebase-project-id/us-central1/onSendCallInvitation
 *
 *  Replace `your-firebase-project-id` with your Firebase project ID.
 */
async function testFunctionsLocally() {
    const functions = require("firebase-functions");
    const admin = require("firebase-admin");
    const test = require("firebase-functions-test")({
        projectId: "your-firebase-project-id",  // Replace with your Firebase project ID
    }, "./serviceAccountKey.json");   // Replace with your Service Account Key file path


    const sendCallInvitation = test.wrap(exports.onSendCallInvitation);

    // Example payload
    const req = {
        body: {
            callID: "12345",
            inviterID: "userA",
            inviteeList: [{ userID: "userB" }],
            data: "some additional data",
        },
        headers: {
            authorization: `Bearer YOUR_ZEGOCLOUD_SECRET_KEY`
        }
    };

    const res = {
        status: (code) => {
            console.log("Status code:", code);
            return res;  // Allow chaining
        },
        send: (message) => {
            console.log("Response message:", message);
        }
    };

    await sendCallInvitation(req, res);

    test.cleanup();
}

// Uncomment this line to run the test function locally.  Make sure emulators are running!
// testFunctionsLocally();