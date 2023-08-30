const routes = [
  // TOOLS HOME
  {
    path: "/tools",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Tools"
    },
    children: [
      {
        name: "toolsHome",
        path: "",
        component: () => import("src/pages/MarkdownEditorPage.vue")
      }
    ]
  },
  // MARKDOWN EDITOR
  {
    path: "/tools/editor/markdown",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Tools"
    },
    children: [
      {
        name: "MarkdownEditor",
        path: "",
        component: () => import("src/pages/MarkdownEditorPage.vue")
      }
    ]
  },
  // JSON EDITOR
  {
    path: "/tools/editor/json",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Tools"
    },
    children: [
      {
        name: "JSONEditor",
        path: "",
        component: () => import("pages/JSONEditorPage.vue")
      }
    ]
  },

]
export default routes;
