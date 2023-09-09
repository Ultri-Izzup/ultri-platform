<template>
  <div>
    <div v-html="styledMarkdown" />
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";
import MarkdownIt from "markdown-it";
import MarkdownItAbbr from "markdown-it-abbr";
import MarkdownItAnchor from "markdown-it-anchor";
import MarkdownItFootnote from "markdown-it-footnote";
import MarkdownItHighlightjs from "markdown-it-highlightjs";
import MarkdownItSub from "markdown-it-sub";
import MarkdownItSup from "markdown-it-sup";
import MarkdownItTasklists from "markdown-it-task-lists";
import MarkdownItTOC from "markdown-it-toc-done-right";
import MarkdownItAttrs from "markdown-it-attrs";
import MarkdownItStyle from "markdown-it-style";

import { useColorStore } from "../../stores/color";

const colorStore = useColorStore();

const props = defineProps({
  modelValue: {
    type: String,
  },
  css: {
    type: Object,
    default: () => {
      return {
        h1: "font-size:2.1em; line-height: 1.35; color: #455A64",
        h2: "font-size:1.9em; line-height: 1.37; color: #455A64",
        h3: "font-size:1.7em; line-height: 1.40; color: #455A64",
        h4: "font-size:1.5em; line-height: 1.45; color: #455A64",
        h5: "font-size:1.3em; line-height: 1.45; color: #455A64",
        h6: "font-size:1.1em; line-height: 1.45; color: #455A64",
        p: "color: #455A64",
        ol: "color: #455A64",
        ul: "color: #455A64",
        li: "color: #455A64",
      };
    },
  },
});

console.log("MV", props.modelValue);

const markdown = new MarkdownIt()
  .use(MarkdownItAbbr)
  .use(MarkdownItAnchor)
  .use(MarkdownItFootnote)
  .use(MarkdownItHighlightjs)
  .use(MarkdownItSub)
  .use(MarkdownItSup)
  .use(MarkdownItTasklists)
  .use(MarkdownItTOC)
  .use(MarkdownItAttrs)
  .use(MarkdownItStyle, props.css);

const styledMarkdown = computed(() => markdown.render(props.modelValue));

colorStore.$subscribe((mutation, state) => {
  if (state.darkMode) {
    const newCSS = {
      h1: "font-size:2.1em; line-height: 1.35; color: #FFFFFF",
      h2: "font-size:1.9em; line-height: 1.37; color: #FFFFFF",
      h3: "font-size:1.7em; line-height: 1.40; color: #FFFFFF",
      h4: "font-size:1.5em; line-height: 1.45; color: #FFFFFF",
      h5: "font-size:1.3em; line-height: 1.45; color: #FFFFFF",
      h6: "font-size:1.1em; line-height: 1.45; color: #FFFFFF",
      p: "color: #FFFFFF",
      ol: "color: #FFFFFF",
      ul: "color: #FFFFFF",
      li: "color: #FFFFFF",
    };

    const markdown = new MarkdownIt()
      .use(MarkdownItAbbr)
      .use(MarkdownItAnchor)
      .use(MarkdownItFootnote)
      .use(MarkdownItHighlightjs)
      .use(MarkdownItSub)
      .use(MarkdownItSup)
      .use(MarkdownItTasklists)
      .use(MarkdownItTOC)
      .use(MarkdownItAttrs)
      .use(MarkdownItStyle, newCSS);

    styledMarkdown.value = markdown.render(props.modelValue);
  } else {
    const newCSS = {
      h1: "font-size:2.1em; line-height: 1.35; color: #455A64",
      h2: "font-size:1.9em; line-height: 1.37; color: #455A64",
      h3: "font-size:1.7em; line-height: 1.40; color: #455A64",
      h4: "font-size:1.5em; line-height: 1.45; color: #455A64",
      h5: "font-size:1.3em; line-height: 1.45; color: #455A64",
      h6: "font-size:1.1em; line-height: 1.45; color: #455A64",
      p: "color: #455A64",
      ol: "color: #455A64",
      ul: "color: #455A64",
      li: "color: #455A64",
    };

    const markdown = new MarkdownIt()
      .use(MarkdownItAbbr)
      .use(MarkdownItAnchor)
      .use(MarkdownItFootnote)
      .use(MarkdownItHighlightjs)
      .use(MarkdownItSub)
      .use(MarkdownItSup)
      .use(MarkdownItTasklists)
      .use(MarkdownItTOC)
      .use(MarkdownItAttrs)
      .use(MarkdownItStyle, newCSS);

    styledMarkdown.value = markdown.render(props.modelValue);
  }

  // persist the whole state to the local storage whenever it changes
});
</script>
