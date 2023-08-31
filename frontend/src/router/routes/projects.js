const routes = [
  // PROJECTS ROOT
  {
    path: "/projects",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Logbook"
    },
    children: [
      {
        name: "projectsHome",
        path: "",
        component: () => import("pages/ProjectsHomePage.vue")
      }
    ]
  },
]
export default routes;
