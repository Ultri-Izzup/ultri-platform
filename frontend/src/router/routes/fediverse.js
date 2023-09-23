const routes = [
  // WORKSPACE ROOT
  {
    path: "/fediverse",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Fediverse",
      app: "Fediverse"
    },
    children: [
      {
        name: "fediverseHome",
        path: "",
        component: () => import("pages/FediverseHomePage.vue")
      }
    ]
  },
]
export default routes;
