// Import requried route files
import site from './site'
import canvas from './canvas'
import canava from './canava'
import circles from './circles'
import cirkl from './cirkl'
import okra from './okra'
import org from './org'
import platform from './platform'
import features from './features'
import tools from './tools'
import debug from './debug'
import catchall from './catchall'


// Add routes in order of precedence
const routes = [
  ...site,
  ...canvas,
  ...canava,
  ...circles,
  ...cirkl,
  ...okra,
  ...org,
  ...platform,
  ...features,
  ...tools,
  ...debug,
  ...catchall // Keep catchall last
]

// Export full route object to Quasar/Vue Router
export default routes;
