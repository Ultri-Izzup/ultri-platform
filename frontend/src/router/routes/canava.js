const routes = [
  {
    path: "/canava",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canava",
        path: "",
        component: () => import("pages/CanavaPage.vue")
      }
    ]
  }
]
export default routes;
