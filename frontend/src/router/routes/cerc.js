const routes = [
  // CERC HOME
  {
    path: "/cerc",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Cerc"
    },
    children: [
      {
        name: "cercHome",
        path: "",
        component: () => import("src/pages/CercHomePage.vue")
      }
    ]
  },
]
export default routes;
