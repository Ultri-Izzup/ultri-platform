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
    path: "/forms/:formName",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/FormWrapperPage.vue") }
    ]
  },

  {
    path: "/about-ultri",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/AboutUltriPage.vue") }
    ]
  },

];

export default routes;
