// Unique Marker: This MUST reach Firebase - DEPLOYMENT TEST 2025-02-23
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const crypto = require("crypto");

console.log("🚀 New Deployment: Code Updated! TESTING 123");

admin.initializeApp();
const db = admin.firestore();

const CALLBACK_SECRET = "bc49613e29dc350e493c51a541774eb5";

// --- Utility Functions ---

function verifySignature(signature, timestamp, nonce) {
  const tmpArr = [CALLBACK_SECRET, timestamp, nonce];
  tmpArr.sort();
  const tmpStr = tmpArr.join("");
  const hash = crypto.createHash("sha1").update(tmpStr).digest("hex");

  return hash === signature;
}

async function logEvent(callId, eventName, eventData) {
  try {
      await db
          .collection("call_logs")
          .doc(callId)
          .collection("events")
          .doc(eventName)
          .set(eventData, { merge: true });
      console.log(`Event ${eventName} logged successfully for call ID: ${callId}`);
  } catch (error) {
      console.error(`Error logging event ${eventName} for call ID ${callId}:`, error);
  }
}

async function handleZegoCloudCallback(req, res, eventName, next) {
  try {
    const { signature, timestamp, nonce, event } = req.body;

    if (!verifySignature(signature, timestamp, nonce)) {
      console.error("Invalid callback signature");
      return res.status(401).send({ error: "Unauthorized" });
    }

    if (event === eventName) {
      console.log(`Processing event: ${eventName} with data:`, req.body); // Log the data
      await next(req.body);
      return res.status(200).send({ message: `${eventName} event processed successfully` });
    } else {
      console.warn(`Invalid event: ${event} for this endpoint. Expected: ${eventName}`);
      return res.status(400).send({ error: "Invalid event for this endpoint" });
    }
  } catch (error) {
    console.error(`Error processing ${eventName} event:`, error);
    return res.status(500).send({ error: "Internal server error" });
  }
}

// ----  Functions  ----

exports.handlecall_create = functions.https.onRequest(async (req, res) => {
  console.log("🚀🚀🚀 Function handlecall_create is running! TEST 2024-02-23 🚀🚀🚀");
  return handleZegoCloudCallback(req, res, "call_create", async (reqBody) => {
    console.log("🚀🚀🚀 ZegoCloud callback in handlecall_create 🚀🚀🚀"); // added logging

    const { call_id, user_ids, create_time, caller } = reqBody;

    const eventData = {
      status: "Created",
      timestamp: parseInt(reqBody.timestamp, 10),
      user_ids,
      call_id,
      create_time: parseInt(create_time, 10),
      caller,
      created_at: admin.firestore.Timestamp.now(),
    };

    await logEvent(call_id, "call_create", eventData);
    console.log("Call creation log saved.");

    // Create callHistory document
    try {
      const callHistoryRef = db.collection("callHistory").doc(call_id);
      await callHistoryRef.set({
        callId: call_id,
        callerId: caller, // Assuming 'caller' is the ID of the caller
        calleeIds: user_ids, // Use user_ids directly.
        startTime: null, // Start time will be set on acceptance
        endTime: null,
        status: "Created", // Initial status.
        createTime: admin.firestore.Timestamp.fromDate(
          new Date(parseInt(create_time))
        ), // Convert create_time to Firestore Timestamp
      });

      console.log("callHistory created for call_create:", call_id);
    } catch (error) {
      console.error("Error creating callHistory (call_create):", error);
    }
  });
});

exports.handlecall_cancel = functions.https.onRequest(async (req, res) => {
    console.log("🚀🚀🚀 Function handlecall_cancel is running! TEST 2024-02-23 🚀🚀🚀");
    return handleZegoCloudCallback(req, res, "call_cancel", async (reqBody) => {
        console.log("🚀🚀🚀 ZegoCloud callback in handlecall_cancel 🚀🚀🚀"); // added logging
        const { call_id, user_ids, reason } = reqBody;

        const status = reason === "timeout_cancel" ? "Timed Out" : "Canceled";
        const eventData = {
            event_name: "call_cancel",
            status,
            timestamp: parseInt(reqBody.timestamp, 10),
            reason,
            user_ids,
            created_at: admin.firestore.Timestamp.now(),
        };

        await logEvent(call_id, "call_cancel", eventData);
        console.log("Call cancellation log saved:", eventData);

        // Update callHistory with cancellation time
        try {
            const callHistoryRef = db.collection('callHistory').doc(call_id);
            await callHistoryRef.update({
                endTime: admin.firestore.Timestamp.now(), // Record cancellation time
                status: status, // Update the status to canceled or timeout
            });
            console.log('callHistory updated for call_cancel:', call_id);
        } catch (error) {
            console.error('Error updating callHistory (call_cancel):', error);
        }
    });
});

exports.handlecall_timeout = functions.https.onRequest(async (req, res) => {
    console.log("🚀🚀🚀 Function handlecall_timeout is running! TEST 2024-02-23 🚀🚀🚀");
    return handleZegoCloudCallback(req, res, "call_timeout", async (reqBody) => {
        console.log("🚀🚀🚀 ZegoCloud callback in handlecall_timeout 🚀🚀🚀"); // added logging
        const { call_id, user_ids } = reqBody;

        const eventData = {
            event_name: "call_timeout",
            status: "Timed Out",
            timestamp: parseInt(reqBody.timestamp, 10),
            user_ids,
            created_at: admin.firestore.Timestamp.now(),
        };

        await logEvent(call_id, "call_timeout", eventData);
        console.log("Call timeout log saved:", eventData);

        try {
            const callHistoryRef = db.collection('callHistory').doc(call_id);
            await callHistoryRef.update({
                endTime: admin.firestore.Timestamp.now(), // Record cancellation time
                status: "Timed Out",
            });
            console.log('callHistory updated for call_timeout:', call_id);
        } catch (error) {
            console.error('Error updating callHistory (call_timeout):', error);
        }
    });
});

exports.handlecall_reject = functions.https.onRequest(async (req, res) => {
    console.log("🚀🚀🚀 Function handlecall_reject is running! TEST 2024-02-23 🚀🚀🚀");
    return handleZegoCloudCallback(req, res, "call_reject", async (reqBody) => {
        console.log("🚀🚀🚀 ZegoCloud callback in handlecall_reject 🚀🚀🚀"); // added logging
        const { call_id, user_id, extend_data } = reqBody;

        const eventData = {
            event_name: "call_reject",
            status: "Rejected",
            timestamp: parseInt(reqBody.timestamp, 10),
            user_id,
            extend_data,
            created_at: admin.firestore.Timestamp.now(),
        };

        await logEvent(call_id, "call_reject", eventData);
        console.log("Call rejection log saved:", eventData);

        try {
            const callHistoryRef = db.collection('callHistory').doc(call_id);
            await callHistoryRef.update({
                endTime: admin.firestore.Timestamp.now(), // Record rejection time
                status: "Rejected",
            });
            console.log('callHistory updated for call_reject:', call_id);
        } catch (error) {
            console.error('Error updating callHistory (call_reject):', error);
        }
    });
});

exports.handlecall_accept = functions.https.onRequest(async (req, res) => {
    console.log("🚀🚀🚀 Function handlecall_accept is running! TEST 2024-02-23 🚀🚀🚀");
    return handleZegoCloudCallback(req, res, "call_accept", async (reqBody) => {
        console.log("🚀🚀🚀 ZegoCloud callback in handlecall_accept 🚀🚀🚀"); // added logging
        const { call_id, user_id, extend_data } = reqBody;

        const eventData = {
            event_name: "call_accept",
            status: "Accepted",
            timestamp: parseInt(reqBody.timestamp, 10),
            user_id,
            extend_data,
            created_at: admin.firestore.Timestamp.now(),
        };

        await logEvent(call_id, "call_accept", eventData);
        console.log("Call acceptance log saved:", eventData);

        try {
            const callHistoryRef = db.collection('callHistory').doc(call_id);
            await callHistoryRef.update({
                startTime: admin.firestore.Timestamp.now(), // Record acceptance time
                status: "Accepted",
            });
            console.log('callHistory updated for call_accept:', call_id);
        } catch (error) {
            console.error('Error updating callHistory (call_accept):', error);
        }
    });
});

exports.handlecall_invitationsend = functions.https.onRequest(async (req, res) => {
    console.log("🚀🚀🚀 Function handlecall_invitationsend is running! TEST 2024-02-23 🚀🚀🚀");
    return handleZegoCloudCallback(req, res, "call_invitation_send", async (reqBody) => {
        console.log("🚀🚀🚀 ZegoCloud callback in handlecall_invitationsend 🚀🚀🚀"); // added logging
        const { call_id, inviter_id, invitee_ids, extended_data, invitation_time } = reqBody;

        const eventData = {
            event_name: "call_invitation_send",
            status: "Sent",
            timestamp: parseInt(reqBody.timestamp, 10),
            call_id,
            inviter_id,
            invitee_ids,
            extended_data,
            invitation_time: parseInt(invitation_time, 10),
            created_at: admin.firestore.Timestamp.now(),
        };

        await logEvent(call_id, "call_invitation_send", eventData);
        console.log("Call invitation sent log saved:", eventData);

        try {
            const callHistoryRef = db.collection('callHistory').doc(call_id);
            await callHistoryRef.update({
                inviterId: inviter_id,
                inviteeIds: invitee_ids, // Store the array of invitee IDs
            });
            console.log('callHistory updated for call_invitation_send:', call_id);
        } catch (error) {
            console.error('Error updating callHistory (call_invitation_send):', error);
        }
    });
});