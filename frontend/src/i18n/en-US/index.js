import account from './account';
import apps from './apps';
import auth from './auth';
import homepage from './homepage';
import homepageDrawer from './homepage-drawer';
import member from './member';
import nav from './nav';
import notifications from './notifications';
import orgs from './orgs';
import tos from './tos';
import pricing from './pricing';

export default {
  ...account,
  ...apps,
  ...auth,
  ...homepage,
  ...homepageDrawer,
  ...member,
  ...nav,
  ...notifications,
  ...orgs,
  ...tos,
  ...pricing
};
