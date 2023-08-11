import { boot } from 'quasar/wrappers'
import { createI18n } from 'vue-i18n'
import messages from 'src/i18n'
import contenteditable from 'vue-contenteditable'

export default boot(({ app }) => {
  app.use(contenteditable)
})
