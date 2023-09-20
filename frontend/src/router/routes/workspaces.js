const routes = [
  // WORKSPACE ROOT
  {
    path: "/workspaces",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Workspaces",
      app: "Workspaces"
    },
    children: [
      {
        name: "workspacesHome",
        path: "",
        component: () => import("pages/WorkspacesHomePage.vue")
      }
    ]
  },
  {
    path: "/workspace/:workspaceAlias",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: "Workspaces",
      app: "Workspaces"
    },
    children: [
      {
        name: "workspaceDashboard",
        path: "",
        component: () => import("pages/WorkspaceDashboardPage.vue")
      }
    ]
  },
]
export default routes;
