import { boot } from 'quasar/wrappers'
import VueNativeSock from "vue-native-websocket-vue3";

// use Socket Store is pinia's socket configuration file
import { useSocketStoreWithOut } from '../stores/socket';

export default boot(({ app }) => {

  console.log('WebSocket Store')

  const socketServer = "wss://example.com/orgs/{{orgUid}}/logbook/entries/{{logbookEntryUid}}/updates?token=";

  const piniaSocketStore = useSocketStoreWithOut();

  app.use(VueNativeSock, socketServer,
    {
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
