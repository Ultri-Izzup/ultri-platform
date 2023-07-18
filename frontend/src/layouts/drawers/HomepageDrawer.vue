<template>
  <div>
    <q-toolbar class="bg-primary text-white shadow-2">
      <q-toolbar-title>Ultri Co-op</q-toolbar-title>
    </q-toolbar>
    <q-list>
      <q-expansion-item
        expand-separator
        icon="mdi-account-group"
        :label="$t('homepage-drawer.co-op-ownership.label')"
        :caption="$t('homepage-drawer.co-op-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepage-drawer.co-op-ownership.blurb') }}
          </q-card-section>
          <q-card-actions class="justify-center">
            <q-btn  class="text-center" rounded color="primary" :label="$t('homepage-drawer.join-the-discussion')" href="https://discord.gg/GE8NqcJx"></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
        </q-card>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-account"
        :label="$t('homepage-drawer.user-ownership.label')"
        :caption="$t('homepage-drawer.user-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepage-drawer.user-ownership.blurb') }}
          </q-card-section>
        </q-card>
        <q-card-actions class="text-center justify-center">
            <q-btn  class="text-center items-center" rounded color="primary" :label="$t('homepage-drawer.join-the-discussion')" href="https://discord.gg/GE8NqcJx"></q-btn>
          </q-card-actions>
          <q-card-actions class="justify-center">
            <a href="https://coop.ultri.com">Watch it get made</a>
          </q-card-actions>
      </q-expansion-item>
      <q-expansion-item
        expand-separator
        icon="mdi-code-braces"
        :label="$t('homepage-drawer.developer-ownership.label')"
        :caption="$t('homepage-drawer.developer-ownership.caption')"
        group="coops"
      >
        <q-card>
          <q-card-section>
            {{ $t('homepage-drawer.developer-ownership.blurb') }}
          </q-card-section>
          <q-card-actions class="text-center justify-center">
            <q-btn  class="text-center items-center" rounded color="primary" :label="$t('homepage-drawer.join-the-discussion')" href="https://discord.gg/GE8NqcJx"></q-btn>
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
