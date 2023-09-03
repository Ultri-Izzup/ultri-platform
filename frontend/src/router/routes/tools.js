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
    path: "/editors/markdown",
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
    path: "/editors/json",
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
   // JSON SCHEMA EDITOR
   {
    path: "/editors/json-schema",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Tools"
    },
    children: [
      {
        name: "JSONSchemaEditor",
        path: "",
        component: () => import("pages/JSONSchemaEditorPage.vue")
      }
    ]
  },
  // IMAGE EDITOR
  {
    path: "/editors/image",
    component: () => import("layouts/MainLayout.vue"),
    meta: {
      drawer: null,
      app: "Tools"
    },
    children: [
      {
        name: "ImageEditor",
        path: "",
        component: () => import("pages/ImageEditorPage.vue")
      }
    ]
  },
    // MERMAID RENDER
    {
      path: "/viewer/mermaid",
      component: () => import("layouts/MainLayout.vue"),
      meta: {
        drawer: null,
        app: "Tools"
      },
      children: [
        {
          name: "MermaidRender",
          path: "",
          component: () => import("pages/MermaidRenderPage.vue")
        }
      ]
    },

]
export default routes;
