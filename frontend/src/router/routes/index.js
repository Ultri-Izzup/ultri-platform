// Import requried route files
import site from './site'
import canvas from './canvas'
import canava from './canava'
import circles from './circles'
import cerc from './cerc'
import okra from './okra'
import org from './org'
import platform from './platform'
import features from './features'
import products from './products'
import projects from './projects'
import services from './services'
import tools from './tools'
import debug from './debug'
import catchall from './catchall'


// Add routes in order of precedence
const routes = [
  ...site,
  ...canvas,
  ...canava,
  ...circles,
  ...cerc,
  ...okra,
  ...org,
  ...platform,
  ...products,
  ...projects,
  ...services,
  ...features,
  ...tools,
  ...debug,
  ...catchall // Keep catchall last
]

// Export full route object to Quasar/Vue Router
export default routes;
