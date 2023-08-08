const routes = [
  {
    path: "/feature-management/",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/FeaturesPage.vue") }
    ]
  },
];

export default routes;
