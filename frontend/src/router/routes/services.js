const routes = [
  // SERVICES ROOT
  {
    path: "/services",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Ultri"
    },
    children: [
      {
        name: "servicesHome",
        path: "",
        component: () => import("pages/ServicesHomePage.vue")
      }
    ]
  },
]
export default routes;
