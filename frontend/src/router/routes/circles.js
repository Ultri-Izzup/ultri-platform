const routes = [
  {
    path: "/org/circles",
    meta: {
      drawer: "Circle"
    },
    component: () => import("layouts/MainLayout.vue"),
    children: [{ path: "", component: () => import("pages/OrgCirclesPage.vue") }]
  },

];

export default routes;
