<template>
  <q-btn-dropdown flat dense no-caps dropdown-icon="mdi-dots-grid">
    <q-list>
      <q-separator color="grey-7"></q-separator>
     <q-item bordered dense>
        <q-item-section>
          <q-item-label class="text-center menuheader">{{
            $t('nav.account').toUpperCase()
          }}
          <q-icon name="mdi-account" color="grey-6" size="sm" class="q-pl-sm"
          /></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup :to="{ name: 'member-articles' }">
        <q-item-section avatar>
          <q-icon name="mdi-file-document" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('account.title') }}</q-item-label>
          <q-item-label caption>{{ $t('account.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-separator color="grey-7"></q-separator>

      <q-item bordered dense>
        <q-item-section>
          <q-item-label class="text-center menuheader">{{
            $t('nav.share').toUpperCase()
          }}
          <q-icon name="mdi-share" color="grey-6" size="sm" class="q-pl-sm"
          /></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon name="mdi-account-switch" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('articles.title') }}</q-item-label>
          <q-item-label caption>{{ $t('articles.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon name="mdi-post" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('posts.title') }}</q-item-label>
          <q-item-label caption>{{ $t('posts.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-separator color="grey-7"></q-separator>

      <q-item dense>
        <q-item-section>
          <q-item-label class="text-center menuheader">{{
            $t('nav.communicate').toUpperCase()
          }}
          <q-icon name="mdi-account-voice" color="grey-6" size="sm" class="q-pl-sm"
          /></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon name="mdi-chat" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('chat.title') }}</q-item-label>
          <q-item-label caption>{{ $t('chat.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon name="mdi-account-group" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('groups.title') }}</q-item-label>
          <q-item-label caption>{{ $t('groups.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-separator color="grey-7"></q-separator>

      <q-item dense>
        <q-item-section>
          <q-item-label class="text-center menuheader"
            >{{ $t('nav.sell').toUpperCase() }}
            <q-icon name="mdi-cash" color="grey-6" size="sm" class="q-pl-sm"
          />
          </q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup to="/classifieds">
        <q-item-section avatar>
          <q-icon name="mdi-newspaper" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('classifieds.title') }}</q-item-label>
          <q-item-label caption>{{ $t('classifieds.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon name="mdi-store" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('shops.title') }}</q-item-label>
          <q-item-label caption>{{ $t('shops.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-item clickable v-close-popup>
        <q-item-section avatar>
          <q-icon
            name="mdi-shopping"
            color="primary"
            :hint="$t('marketplace.hint')"
          />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('marketplace.title') }}</q-item-label>
          <q-item-label caption>{{ $t('marketplace.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-separator color="grey-7"></q-separator>

      <q-item dense>
        <q-item-section>
          <q-item-label class="text-center menuheader">{{
            $t('nav.secure').toUpperCase()
          }}
          <q-icon name="mdi-lock" color="grey-6" size="sm" class="q-pl-sm"
          /></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup to="/secretstash">
        <q-item-section avatar>
          <q-icon name="mdi-safe-square" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('secretstash.title') }}</q-item-label>
          <q-item-label caption>{{ $t('secretstash.caption') }}</q-item-label>
        </q-item-section>
      </q-item>

      <q-separator color="grey-7"></q-separator>

      <q-item dense>
        <q-item-section>
          <q-item-label class="text-center menuheader"
            >{{ $t('nav.govern').toUpperCase() }}
            <q-icon name="mdi-vote" color="grey-6" size="sm" class="q-pl-sm"
          /></q-item-label>
        </q-item-section>
      </q-item>
      <q-separator inset></q-separator>

      <q-item clickable v-close-popup to="/classifieds">
        <q-item-section avatar>
          <q-icon name="mdi-newspaper" color="primary" />
        </q-item-section>
        <q-item-section>
          <q-item-label>{{ $t('sharedchain.title') }}</q-item-label>
          <q-item-label caption>{{ $t('sharedchain.caption') }}</q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </q-btn-dropdown>
</template>

<script setup language="ts">
import { useI18n } from 'vue-i18n';

import { useAuthStore } from '../../../stores/auth';

const auth = useAuthStore();


if(!accounts.isSynced) {
  console.log('Please sync me')
}

const { t } = useI18n();
</script>
