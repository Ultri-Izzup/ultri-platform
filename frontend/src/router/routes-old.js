const routes = [
  {
    path: "/",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Homepage",
      app: "Coop"
    },
    children: [
      { name: "home", path: "", component: () => import("pages/IndexPage.vue") }
    ]
  },

  {
    path: "/pricing",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Default",
      app: "Coop"
    },
    children: [
      {
        name: "pricing",
        path: "",
        component: () => import("pages/PricingPage.vue")
      }
    ]
  },

  {
    path: "/calendar",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Default",
      app: "Coop"
    },
    children: [
      {
        name: "calendar",
        path: "",
        component: () => import("pages/CalendarPage.vue")
      }
    ]
  },

  {
    path: "/orgs",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Org",
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
      drawer: "Org",
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

  // CANVAS
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
    path: "/dashboard",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Dashboard",
      app: "Dashboard"
    },
    children: [
      {
        name: "dashboard",
        path: "",
        component: () => import("pages/DashboardPage.vue")
      }
    ]
  },

  {
    path: "/org",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Org",
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
    path: "/forms/:formName",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/FormWrapperPage.vue") }
    ]
  },

  {
    path: "/org/:orgUid",
    meta: {
      drawer: "Org"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", name:"orgDashboard", component: () => import("src/pages/OrgPage.vue") }]
  },

  {
    path: "/org/:orgUid/circles",
    meta: {
      drawer: "Org"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", name:"orgCircles", component: () => import("src/pages/OrgCirclesPage.vue") }]
  },

  {
    path: "/org/:orgUid/members",
    meta: {
      drawer: "Org"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", name:"orgMembers", component: () => import("src/pages/OrgMembersPage.vue") }]
  },

  {
    path: "/org/:orgUid/logbook",
    meta: {
      drawer: "Org"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgLogbookPage.vue") }]
  },

  {
    path: "/stores",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/StoresDebugPage.vue") }
    ]
  },

  {
    path: "/feature-management/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/FeaturesPage.vue") }
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  {
    path: "/:catchAll(.*)*",
    component: () => import("pages/ErrorNotFound.vue")
  }
];

export default routes;