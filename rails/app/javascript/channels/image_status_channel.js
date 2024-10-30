import consumer from "channels/consumer";

consumer.subscriptions.create("ImageStatusChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("CONNECTED: Image status");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("DISCONNECTED: Image status");
  },

  received(data) {
    console.log("DATA RECEIVED");
    console.log(data);
    // Called when there's incoming data on the websocket for this channel
    const statusDiv = document.getElementById(data.div_id);
    if (statusDiv) {
      statusDiv.innerHTML = data.status_html;
    }
  },
});
