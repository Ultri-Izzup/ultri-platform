const routes = [
  // PRODUCTS ROOT
  {
    path: "/products",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Ultri"
    },
    children: [
      {
        name: "productsHome",
        path: "",
        component: () => import("pages/ProductHomePage.vue")
      }
    ]
  },
]
export default routes;
