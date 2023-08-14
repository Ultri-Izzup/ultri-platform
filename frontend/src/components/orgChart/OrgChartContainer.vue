<template>
  <div id="container" class="q-mb-lg">
    <ol class="organizational-chart">
      <li v-for="circle in circles" :key="circle.index">
        <div>
          <div class="text-h1">{{ members.get(circle.leaderUid).name }}</div>
          <div class="text-h2">
            {{ circle.label }} {{ $t("circles.circle.label") }}
            {{ $t("circles.roles.leader") }}
          </div>
        </div>

        <ol v-if="circle.children.length > 0">
          <li v-for="circle2 in circle.children" :key="circle2.index">
            <div>
              <div class="text-h2">
                {{ members.get(circle2.leaderUid).name }}
              </div>
              <div class="text-h3">
                {{ circle2.label }} {{ $t("circles.circle.label") }}
                {{ $t("circles.roles.leader") }}
              </div>
            </div>
            <ol v-if="circle2.children.length > 0">
              <li v-for="circle3 in circle2.children" :key="circle3.index">
                <div>
                  <div class="text-h3">
                    {{ members.get(circle3.leaderUid).name }}
                  </div>
                  <div class="text-h4">
                    {{ circle3.label }} {{ $t("circles.circle.label") }}
                    {{ $t("circles.roles.leader") }}
                  </div>
                </div>
                <ol v-if="circle3.children.length > 0">
                  <li v-for="circle4 in circle3.children" :key="circle4.index">
                    <div>
                      <div class="text-h4">
                        {{ members.get(circle4.leaderUid).name }}
                      </div>
                      <div class="text-h5">
                        {{ circle4.label }} {{ $t("circles.circle.label") }}
                        {{ $t("circles.roles.leader") }}
                      </div>
                    </div>
                    <ol v-if="circle4.children.length > 0">
                      <li
                        v-for="circle5 in circle4.children"
                        :key="circle5.index"
                      >
                        <div>
                          <div class="text-h5">
                            {{ members.get(circle5.leaderUid).name }}
                          </div>
                          <div class="text-h6">
                            {{ circle5.label }} {{ $t("circles.circle.label") }}
                            {{ $t("circles.roles.leader") }}
                          </div>
                        </div>
                        <ol v-if="circle5.children.length > 0">
                          <li
                            v-for="circle6 in circle5.children"
                            :key="circle6.index"
                          >
                            <div>
                              <div class="text-h6">
                                {{ members.get(circle6.leaderUid).name }}
                              </div>
                              <div class="text-bold">
                                {{ circle6.label }}
                                {{ $t("circles.circle.label") }}
                                {{ $t("circles.roles.leader") }}
                              </div>
                            </div>
                          </li>
                        </ol>
                      </li>
                    </ol>
                  </li>
                </ol>
              </li>
            </ol>
          </li>
        </ol>
      </li>
    </ol>
  </div>
</template>

<script setup>
const props = defineProps({
  circles: Object,
  members: Map,
});
</script>

<style lang="scss">
*,
*:before,
*:after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  background-color: white;
  font-family: "Helvetica Neue", "Helvetica", Arial, sans-serif;
}
h1 {
  color: #fff;
  text-align: center;
}

#wrapper {
  margin: 150px auto;
  max-width: 80em;
}

#container {
  float: left;
  padding: 1em;
  width: 100%;
}

ol.organizational-chart,
ol.organizational-chart ol,
ol.organizational-chart li,
ol.organizational-chart li > div {
  position: relative;
}

ol.organizational-chart,
ol.organizational-chart ol {
  list-style: none;
  margin: 0;
  padding: 0;
}

ol.organizational-chart {
  text-align: center;
}

ol.organizational-chart ol {
  padding-top: 1em;
}

ol.organizational-chart ol:before,
ol.organizational-chart ol:after,
ol.organizational-chart li:before,
ol.organizational-chart li:after,
ol.organizational-chart > li > div:before,
ol.organizational-chart > li > div:after {
  background-color: #b7a6aa;
  content: "";
  position: absolute;
}

ol.organizational-chart ol > li {
  padding: 1em 0 0 1em;
}

ol.organizational-chart > li ol:before {
  height: 1em;
  left: 50%;
  top: 0;
  width: 3px;
}

ol.organizational-chart > li ol:after {
  height: 3px;
  left: 3px;
  top: 1em;
  width: 50%;
}

ol.organizational-chart > li ol > li:not(:last-of-type):before {
  height: 3px;
  left: 0;
  top: 2em;
  width: 1em;
}

ol.organizational-chart > li ol > li:not(:last-of-type):after {
  height: 100%;
  left: 0;
  top: 0;
  width: 3px;
}

ol.organizational-chart > li ol > li:last-of-type:before {
  height: 3px;
  left: 0;
  top: 2em;
  width: 1em;
}

ol.organizational-chart > li ol > li:last-of-type:after {
  height: 2em;
  left: 0;
  top: 0;
  width: 3px;
}

ol.organizational-chart li > div {
  background-color: #fff;
  border-radius: 3px;
  min-height: 2em;
  padding: 0.5em;
}

/*** PRIMARY ***/
ol.organizational-chart > li > div {
  background-color: #a2ed56;
  margin-right: 1em;
}

ol.organizational-chart > li > div:before {
  bottom: 2em;
  height: 3px;
  right: -1em;
  width: 1em;
}

ol.organizational-chart > li > div:first-of-type:after {
  bottom: 0;
  height: 2em;
  right: -1em;
  width: 3px;
}

ol.organizational-chart > li > div + div {
  margin-top: 1em;
}

ol.organizational-chart > li > div + div:after {
  height: calc(100% + 1em);
  right: -1em;
  top: -1em;
  width: 3px;
}

/*** SECONDARY ***/
ol.organizational-chart > li > ol:before {
  left: inherit;
  right: 0;
}

ol.organizational-chart > li > ol:after {
  left: 0;
  width: 100%;
}

ol.organizational-chart > li > ol > li > div {
  background-color: #83e4e2;
}

/*** TERTIARY ***/
ol.organizational-chart > li > ol > li > ol > li > div {
  background-color: #fd6470;
}

/*** QUATERNARY ***/
ol.organizational-chart > li > ol > li > ol > li > ol > li > div {
  background-color: #fca858;
}

/*** QUINARY ***/
ol.organizational-chart > li > ol > li > ol > li > ol > li > ol > li > div {
  background-color: #fddc32;
}

/*** MEDIA QUERIES ***/
@media only screen and (min-width: 64em) {
  ol.organizational-chart {
    margin-left: -1em;
    margin-right: -1em;
  }

  /* PRIMARY */
  ol.organizational-chart > li > div {
    display: inline-block;
    float: none;
    margin: 0 1em 1em 1em;
    vertical-align: bottom;
  }

  ol.organizational-chart > li > div:only-of-type {
    margin-bottom: 0;
    width: calc((100% / 1) - 2em - 4px);
  }

  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(2),
  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(2) ~ div {
    width: calc((100% / 2) - 2em - 4px);
  }

  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(3),
  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(3) ~ div {
    width: calc((100% / 3) - 2em - 4px);
  }

  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(4),
  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(4) ~ div {
    width: calc((100% / 4) - 2em - 4px);
  }

  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(5),
  ol.organizational-chart > li > div:first-of-type:nth-last-of-type(5) ~ div {
    width: calc((100% / 5) - 2em - 4px);
  }

  ol.organizational-chart > li > div:before,
  ol.organizational-chart > li > div:after {
    bottom: -1em !important;
    top: inherit !important;
  }

  ol.organizational-chart > li > div:before {
    height: 1em !important;
    left: 50% !important;
    width: 3px !important;
  }

  ol.organizational-chart > li > div:only-of-type:after {
    display: none;
  }

  ol.organizational-chart > li > div:first-of-type:not(:only-of-type):after,
  ol.organizational-chart > li > div:last-of-type:not(:only-of-type):after {
    bottom: -1em;
    height: 3px;
    width: calc(50% + 1em + 3px);
  }

  ol.organizational-chart > li > div:first-of-type:not(:only-of-type):after {
    left: calc(50% + 3px);
  }

  ol.organizational-chart > li > div:last-of-type:not(:only-of-type):after {
    left: calc(-1em - 3px);
  }

  ol.organizational-chart > li > div + div:not(:last-of-type):after {
    height: 3px;
    left: -2em;
    width: calc(100% + 4em);
  }

  /* SECONDARY */
  ol.organizational-chart > li > ol {
    display: flex;
    flex-wrap: nowrap;
  }

  ol.organizational-chart > li > ol:before,
  ol.organizational-chart > li > ol > li:before {
    height: 1em !important;
    left: 50% !important;
    top: 0 !important;
    width: 3px !important;
  }

  ol.organizational-chart > li > ol:after {
    display: none;
  }

  ol.organizational-chart > li > ol > li {
    flex-grow: 1;
    padding-left: 1em;
    padding-right: 1em;
    padding-top: 1em;
  }

  ol.organizational-chart > li > ol > li:only-of-type {
    padding-top: 0;
  }

  ol.organizational-chart > li > ol > li:only-of-type:before,
  ol.organizational-chart > li > ol > li:only-of-type:after {
    display: none;
  }

  ol.organizational-chart > li > ol > li:first-of-type:not(:only-of-type):after,
  ol.organizational-chart > li > ol > li:last-of-type:not(:only-of-type):after {
    height: 3px;
    top: 0;
    width: 50%;
  }

  ol.organizational-chart
    > li
    > ol
    > li:first-of-type:not(:only-of-type):after {
    left: 50%;
  }

  ol.organizational-chart > li > ol > li:last-of-type:not(:only-of-type):after {
    left: 0;
  }

  ol.organizational-chart > li > ol > li + li:not(:last-of-type):after {
    height: 3px;
    left: 0;
    top: 0;
    width: 100%;
  }
}
</style>
