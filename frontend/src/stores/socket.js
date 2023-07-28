import { defineStore } from "pinia";

export const useSocketStore = defineStore({
  id: 'socket',
  state: () => ({
    // Connection Status
    isConnected: false,
    // Message content
    message: '',
    // Reconnect error
    reconnectError: false,
    // Heartbeat message sending time
    heartBeatInterval: 50000,
    // Heartbeat timer
    heartBeatTimer: 0,
  }),
  actions: {
    // Connection open
    SOCKET_ONOPEN(event) {
      this.socket = event.currentTarget;
      this.isConnected = true;
      // When the connection is successful, start sending heartbeat messages regularly to avoid being disconnected by the server
      this.heartBeatTimer = window.setInterval(() => {
        const message = 'Heartbeat message';
        this.isConnected &&
          this.socket.sendObj({
            code: 200,
            msg: message,
          });
      }, this.heartBeatInterval);
    },
    // Connection closed
    SOCKET_ONCLOSE(event) {
      this.isConnected = false;
      // Stop the heartbeat message when the connection is closed
      window.clearInterval(this.heartBeatTimer);
      this.heartBeatTimer = 0;
      console.log('The line is disconnected: ' + new Date());
      console.log(event);
    },
    // An error occurred
    SOCKET_ONERROR(event) {
      console.error(event);
    },
    // Receive the message sent by the server
    SOCKET_ONMESSAGE(message) {
      this.message = message;
    },
    // Auto reconnect
    SOCKET_RECONNECT(count) {
      console.info('Message system reconnecting...', count);
    },
    // Reconnect error
    SOCKET_RECONNECT_ERROR() {
      this.reconnectError = true;
    },
  },
});

// Need to be used outside the setup
export function useSocketStoreWithOut() {
  return useSocketStore();
}
