export default defineConfig({
  server: {
    // hot module reload for dev server
    hmr: {
      host: 'example.com',
      protocol: 'wss',
      clientPort: 443
    }
  }
})
