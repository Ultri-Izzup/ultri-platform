const routes = [
  {
    path: "/canvas",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Canvas",
      app: "Logbook"
    },
    children: [
      {
        name: "canvases",
        path: "",
        component: () => import("pages/CanvasPage.vue")
      }
    ]
  },
  {
    path: "/canvas/:canvasName",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Canvas",
      app: "Logbook"
    },
    children: [
      {
        name: "canvasPage",
        path: "",
        component: () => import("pages/CanvasPage.vue")
      }
    ]
  },
]
export default routes;
