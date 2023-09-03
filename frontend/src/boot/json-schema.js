import { boot } from 'quasar/wrappers'
import JsonSchemaEditor from 'json-schema-editor-vue3'
import 'json-schema-editor-vue3/lib/json-schema-editor-vue3.css'

export default boot(({ app }) => {
  app.use(JsonSchemaEditor)
})
