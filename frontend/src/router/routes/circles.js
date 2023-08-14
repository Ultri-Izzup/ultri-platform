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
    path: "/circles/visualization",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/D3ForceBasedPage.vue") }]
  },
  {
    path: "/circles/org-chart",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgChartPage.vue") }]
  },
  {
    path: "/circles/diagram",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("src/pages/D3ForceDirectedPage.vue") }]
  },
];

export default routes;
