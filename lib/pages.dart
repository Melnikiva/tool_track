enum Pages {
  login,
  account,
  assets,
  settings,
  info,
}

Map<Pages, String> pageRoutes = {
  Pages.login: '/',
  Pages.assets: '/assets',
  Pages.account: '/account',
  Pages.settings: '/settings',
  Pages.info: '/info'
};
