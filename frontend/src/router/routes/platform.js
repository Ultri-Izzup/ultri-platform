const routes = [
  // PLATFORM DOCS HOME
  {
    path: "/platform",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Paltform"
    },
    children: [
      {
        name: "paltformHome",
        path: "",
        component: () => import("pages/PlatformHomePage.vue")
      }
    ]
  },
]
export default routes;
