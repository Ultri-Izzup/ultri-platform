<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <p>Press F12 to open the console</p>
    <h3>
      if you see "successful websocket connection" , congratulations your plugin
      has run successfully
    </h3>

  </div>
</template>

<script>
import { defineComponent } from "vue";
import { getCurrentInstance, ComponentInternalInstance } from "vue";
//  Module '"vue"' has no exported member 'ComponentInternalInstance'.
export default defineComponent({
  name: "HelloWorld",
  mounted() {
    const { proxy } = getCurrentInstance() ;
    setTimeout(() => {
      if (proxy == null) return;
      proxy.$connect();
    }, 100);
  },
  props: {
    msg: String
  }
});
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
