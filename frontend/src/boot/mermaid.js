import { boot } from 'quasar/wrappers'
import Vue3Mermaid from "vue3-mermaid";

export default boot(({ app }) => {
  // Set <mermaid>n instance on app
  app.use(Vue3Mermaid)
})
