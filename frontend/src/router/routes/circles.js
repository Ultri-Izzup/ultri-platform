const routes = [
  {
    path: "/circles",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgCirclesPage.vue") }]
  },
  {
    path: "/circles/test",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/GraphPage.vue") }]
  },
  {
    path: "/circles/org-chart",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/GraphPage2.vue") }]
  },
  {
    path: "/circles/diagram",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("src/pages/D3ForcedGraph.vue") }]
  },
];

export default routes;
