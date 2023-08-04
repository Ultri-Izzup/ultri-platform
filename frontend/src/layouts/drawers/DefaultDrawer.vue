<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-btn flat icon="mdi-arrow-left" size="md" v-if="route.name != 'home'" no-caps clickable :to="{ name: 'home'}"><q-toolbar-title>Ultri</q-toolbar-title></q-btn><q-toolbar-title v-if="route.name == 'home'">Ultri</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-expansion-item
        expand-separator
        icon="mdi-account-group"
        :label="$t('homepageDrawer.coopOwnership.label')"
        :caption="$t('homepageDrawer.coopOwnership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t("homepageDrawer.coopOwnership.blurb") }}
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn
              class="text-center"
              rounded
              color="primary"
              :label="$t('nav.joinTheDiscussion')"
              href="https://discord.gg/kSxMTVra"
            ></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
        </q-card>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-account"
        :label="$t('homepageDrawer.userOwnership.label')"
        :caption="$t('homepageDrawer.userOwnership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t("homepageDrawer.userOwnership.blurb") }}
          </q-card-section>
        </q-card>
        <q-card-actions class="text-center justify-center">
          <q-btn
            class="text-center items-center"
            rounded
            color="primary"
            :label="$t('nav.joinTheDiscussion')"
            href="https://discord.gg/kSxMTVra"
          ></q-btn>
        </q-card-actions>
        <q-card-actions class="justify-center">
          <a href="https://coop.ultri.com">Watch it get made</a>
        </q-card-actions>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-code-braces"
        :label="$t('homepageDrawer.developerOwnership.label')"
        :caption="$t('homepageDrawer.developerOwnership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t("homepageDrawer.developerOwnership.blurb") }}
          </q-card-section>
          <q-card-actions class="text-center justify-center">
            <q-btn
              class="text-center items-center"
              rounded
              color="primary"
              :label="$t('nav.joinTheDiscussion')"
              href="https://discord.gg/kSxMTVra"
            ></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
        </q-card>
      </q-expansion-item>
    </q-list>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";
const route = useRoute();

</script>

<style lang="scss"></style>
