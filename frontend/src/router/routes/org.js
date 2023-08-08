const routes = [
  {
    path: "/orgs",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Logbook",
      app: "Logbook"
    },
    children: [
      { name: "orgs", path: "", component: () => import("pages/OrgsPage.vue") }
    ]
  },

  {
    path: "/logbook",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Logbook",
      app: "Logbook"
    },
    children: [
      {
        name: "logbook",
        path: "",
        component: () => import("src/pages/OrgLogbookPage.vue")
      }
    ]
  },
  {
    path: "/org/:orgUid/canvas",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Canvas",
      app: "Logbook"
    },
    children: [
      {
        name: "orgCanvases",
        path: "",
        component: () => import("pages/CanvasPage.vue")
      }
    ]
  },
  {
    path: "/org/:orgUid/canvas/:canvasName",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Canvas",
      app: "Logbook"
    },
    children: [
      {
        name: "orgCanvasPage",
        path: "",
        component: () => import("pages/CanvasPage.vue")
      }
    ]
  },

  {
    path: "/org",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Logbook",
      app: "Logbook"
    },
    children: [
      {
        name: "org",
        path: "",
        component: () => import("pages/OrgPage.vue")
      }
    ]
  },
  {
    path: "/org/:orgUid",
    meta: {
      drawer: "Logbook"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", name:"orgDashboard", component: () => import("src/pages/OrgPage.vue") }]
  },
  {
    path: "/org/:orgUid/logbook",
    meta: {
      drawer: "Logbook"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgLogbookPage.vue") }]
  },
  {
    path: "/org/:orgUid/circles",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgCirclesPage.vue") }]
  }
];

export default routes;
