// Import requried route files
import site from './site'
import canvas from './canvas'
import circles from './circles'
import org from './org'
import features from './features'
import debug from './debug'
import catchall from './catchall'


// Add routes in order of precedence
const routes = [
  ...site,
  ...canvas,
  ...circles,
  ...org,
  ...features,
  ...debug,
  ...catchall // Keep catchall last
]

// Export full route object to Quasar/Vue Router
export default routes;
