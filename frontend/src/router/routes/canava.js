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
  },
  {
    path: "/canava/viewer",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaViewer",
        path: "",
        component: () => import("pages/CanavaViewerPage.vue")
      }
    ]
  },
  {
    path: "/canava/viewer/:canvasTemplate",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaTemplateViewer",
        path: "",
        component: () => import("pages/CanavaViewerPage.vue")
      }
    ]
  },
]
export default routes;
