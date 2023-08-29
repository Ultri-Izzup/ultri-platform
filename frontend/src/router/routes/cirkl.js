const routes = [
  // CIRKEL HOME
  {
    path: "/cirkl",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "cirklHome",
        path: "",
        component: () => import("src/pages/CirklHomePage.vue")
      }
    ]
  },
]
export default routes;
