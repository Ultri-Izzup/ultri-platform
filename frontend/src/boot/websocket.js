import { boot } from 'quasar/wrappers'

import VueNativeSock from "vue-native-websocket-vue3";

import { useSocketStoreWithOut } from './useSocketStore';

const store = useSocketStoreWithOut();

const piniaSocketStore = useSocketStoreWithOut();

export default boot(({ app }) => {
  
// Use the Vue Native Sock plug-in and perform related configuration
    app.use(VueNativeSock,"wss://example.com/org/websocket", {
        // 启用pinia集成 | enable pinia integration
        store: piniaSocketStore,
        // 数据发送/接收使用使用json
        format: "json",
        // 开启手动调用 connect() 连接服务器
        connectManually: true,
        // 开启自动重连
        reconnection: true,
        // 尝试重连的次数
        reconnectionAttempts: 5,
        // 重连间隔时间
        reconnectionDelay: 3000
      });
})
