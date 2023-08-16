<template>
  <q-page>
    <div class="text-h1 text-center justify-center">Organization Chart</div>
    <div class="tree justify-center text-center fit">
      <ul>
        <li v-for="circle in treeData" :key="circle.index">
          <a href="#"
            ><div class="text-l1">{{ members.get(circle.leaderUid).name }}</div>
            <div class="text-l2">
              {{ circle.label }} <br />
              {{ $t("circles.roles.leader") }}
            </div></a
          >
          <ul v-if="circle.children.length > 0">
            <li v-for="circle2 in circle.children" :key="circle2.index">
              <a href="#"
                ><div>
                  <div class="text-l2">
                    {{ members.get(circle2.leaderUid).name }}
                  </div>
                  <div class="text-l3">
                    {{ circle2.label }}  <br />
                    {{ $t("circles.roles.leader") }}
                  </div>
                </div></a
              >
              <ul v-if="circle2.children.length > 0">
                <li v-for="circle3 in circle2.children" :key="circle3.index">
                  <a href="#"
                    ><div>
                      <div class="text-l3">
                        {{ members.get(circle3.leaderUid).name }}
                      </div>
                      <div class="text-l4">
                        {{ circle3.label }} <br />
                        {{ $t("circles.roles.leader") }}
                      </div>
                    </div></a
                  >
                  <ul v-if="circle3.children.length > 0">
                    <li
                      v-for="circle4 in circle3.children"
                      :key="circle4.index"
                    >
                      <a href="#"
                        ><div>
                          <div class="text-l4">
                            {{ members.get(circle4.leaderUid).name }}
                          </div>
                          <div class="text-l5">
                            {{ circle4.label }} <br />
                            {{ $t("circles.roles.leader") }}
                          </div>
                        </div></a
                      >
                      <ul v-if="circle4.children.length > 0">
                        <li
                          v-for="circle5 in circle4.children"
                          :key="circle5.index"
                        >
                          <a href="#"
                            ><div>
                              <div class="text-l5">
                                {{ members.get(circle5.leaderUid).name }}
                              </div>
                              <div class="text-l6">
                                {{ circle5.label }}
                               <br />
                                {{ $t("circles.roles.leader") }}
                              </div>
                            </div></a
                          >
                          <ul v-if="circle5.children.length > 0">
                            <li
                              v-for="circle6 in circle5.children"
                              :key="circle6.index"
                            >
                              <a href="#"
                                ><div>
                                  <div class="text-l6">
                                    {{ members.get(circle6.leaderUid).name }}
                                  </div>
                                  <div class="text-l7">
                                    {{ circle6.label }}
                                    <br />
                                    {{ $t("circles.roles.leader") }}
                                  </div>
                                </div></a
                              >
                            </li>
                          </ul>
                        </li>
                      </ul>
                    </li>
                  </ul>
                </li>
              </ul>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </q-page>
</template>

<script setup>
import { computed } from "vue";

import { arrayToTree } from "performant-array-to-tree";

import { useCirclesStore } from "../stores/circles";
import { useCircleMembersStore } from "../stores/circleMembers";

import OrgChartContainer from "../components/orgChart/OrgChartContainer.vue";

const circlesStore = useCirclesStore();
const circleMembersStore = useCircleMembersStore();

const treeData = computed(() => {
  let tree = [];
  tree = arrayToTree(circlesStore.orgCircles, {
    id: "uid",
    parentId: "parentCircle",
    childrenField: "children",
    dataField: null,
  });

  return tree;
});

const members = circleMembersStore.membersMap;
</script>

<style lang="scss" scoped>
.text-l1 {
  font-size: 1.5em;
  line-height: normal;
}
.text-l2 {
  font-size: 1.4em;
  line-height: normal;
}
.text-l3 {
  font-size: 1.3em;
  line-height: normal;
}
.text-l4 {
  font-size: 1.2em;
  line-height: normal;
}
.text-l5 {
  font-size: 1.1em;
  line-height: normal;
}
.text-l6 {
  font-size: 1em;
  line-height: normal;
}
.text-l7 {
  font-size: .9em;
  line-height: normal;
}


.tree ul {
  padding-top: 20px;
  position: relative;

  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

.tree li {
  float: left;
  text-align: center;
  list-style-type: none;
  position: relative;
  padding: 20px 5px 0 5px;

  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

/*We will use ::before and ::after to draw the connectors*/

.tree li::before,
.tree li::after {
  content: "";
  position: absolute;
  top: 0;
  right: 50%;
  border-top: 1px solid #ccc;
  width: 50%;
  height: 20px;
}
.tree li::after {
  right: auto;
  left: 50%;
  border-left: 1px solid #ccc;
}

/*We need to remove left-right connectors from elements without
any siblings*/
.tree li:only-child::after,
.tree li:only-child::before {
  display: none;
}

/*Remove space from the top of single children*/
.tree li:only-child {
  padding-top: 0;
}

/*Remove left connector from first child and
right connector from last child*/
.tree li:first-child::before,
.tree li:last-child::after {
  border: 0 none;
}
/*Adding back the vertical connector to the last nodes*/
.tree li:last-child::before {
  border-right: 1px solid #ccc;
  border-radius: 0 5px 0 0;
  -webkit-border-radius: 0 5px 0 0;
  -moz-border-radius: 0 5px 0 0;
}
.tree li:first-child::after {
  border-radius: 5px 0 0 0;
  -webkit-border-radius: 5px 0 0 0;
  -moz-border-radius: 5px 0 0 0;
}

/*Time to add downward connectors from parents*/
.tree ul ul::before {
  content: "";
  position: absolute;
  top: 0;
  left: 50%;
  border-left: 1px solid #ccc;
  width: 0;
  height: 20px;
}

.tree li a {
  border: 1px solid #ccc;
  padding: 5px 10px;
  text-decoration: none;
  color: #666;
  font-family: arial, verdana, tahoma;
  font-size: 11px;
  display: inline-block;

  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;

  transition: all 0.5s;
  -webkit-transition: all 0.5s;
  -moz-transition: all 0.5s;
}

/*Time for some hover effects*/
/*We will apply the hover effect the the lineage of the element also*/
.tree li a:hover,
.tree li a:hover + ul li a {
  background: #c8e4f8;
  color: #000;
  border: 1px solid #94a0b4;
}
/*Connector styles on hover*/
.tree li a:hover + ul li::after,
.tree li a:hover + ul li::before,
.tree li a:hover + ul::before,
.tree li a:hover + ul ul::before {
  border-color: #94a0b4;
}
</style>
