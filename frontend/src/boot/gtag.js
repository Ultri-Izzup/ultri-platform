import { boot } from 'quasar/wrappers'
import VueGtag from "vue-gtag";

export default boot(({ app }) => {
  app.use(VueGtag, {
    config: { id: "G-GKG2LWGGKE" },
    bootstrap: false
  })
})
