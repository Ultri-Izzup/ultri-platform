<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>Ultri Co-op</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-expansion-item
        expand-separator
        icon="mdi-account-group"
        :label="$t('homepageDrawer.co-op-ownership.label')"
        :caption="$t('homepageDrawer.co-op-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepageDrawer.co-op-ownership.blurb') }}
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn  class="text-center" rounded color="primary" :label="$t('homepageDrawer.join-the-discussion')" href="https://discord.gg/rZBBhKwe"></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
        </q-card>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-account"
        :label="$t('homepageDrawer.user-ownership.label')"
        :caption="$t('homepageDrawer.user-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepageDrawer.user-ownership.blurb') }}
          </q-card-section>
        </q-card>
        <q-card-actions class="text-center justify-center">
            <q-btn  class="text-center items-center" rounded color="primary" :label="$t('homepageDrawer.join-the-discussion')" href="https://discord.gg/rZBBhKwe"></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-code-braces"
        :label="$t('homepageDrawer.developer-ownership.label')"
        :caption="$t('homepageDrawer.developer-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepageDrawer.developer-ownership.blurb') }}
          </q-card-section>
          <q-card-actions class="text-center justify-center">
            <q-btn  class="text-center items-center" rounded color="primary" :label="$t('homepageDrawer.join-the-discussion')" href="https://discord.gg/rZBBhKwe"></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
        </q-card>
      </q-expansion-item>
    </q-list>
  </div>
</template>

<script setup></script>

<style lang="scss"></style>
