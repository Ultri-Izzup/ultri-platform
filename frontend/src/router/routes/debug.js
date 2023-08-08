const routes = [
  {
    path: "/stores",
    component: () => import("layouts/MainLayout.vue"),
    children: [
      { path: "", component: () => import("pages/StoresDebugPage.vue") }
    ]
  },

];

export default routes;
