const routes = [
  // CIRKEL HOME
  {
    path: "/okra",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "okraHome",
        path: "",
        component: () => import("src/pages/OKRaHomePage.vue")
      }
    ]
  },
]
export default routes;
