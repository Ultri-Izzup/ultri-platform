const routes = [
  // CANAVA HOME
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
        component: () => import("pages/CanavaHomePage.vue")
      }
    ]
  },
  // TEMPLATE VIEW
  // Data for each template is kept seprate in the canavaStore
  {
    path: "/canava/template/:canvasTemplate",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaTemplate",
        path: "",
        component: () => import("pages/CanavaViewerPage.vue")
      }
    ]
  },
  // TEMPLATE CUSTOMIZATION VIEW
  // Design changes override the design for the named canvas
  {
    path: "/canava/template/:canvasTemplate/designer",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaTemplateDesigner",
        path: "",
        component: () => import("pages/CanavaDesignerPage.vue")
      }
    ]
  },
  // CUSTOM CANVAS DESIGNER
  // Data for one custom canvas at a time is stored in canavaStore
  {
    path: "/canava/designer",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaDesigner",
        path: "",
        component: () => import("pages/CanavaDesignerPage.vue")
      }
    ]
  },
  // CUSTOM CANVAS USER INTERFACE
  // Access the currently loaded custom canvas
  {
    path: "/canava/designer/view",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "canavaDesignerViewer",
        path: "",
        component: () => import("pages/CanavaViewerPage.vue")
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
