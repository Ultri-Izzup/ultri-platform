<template>
  <q-page class="flex row fit">
    <div class="row fit q-px-lg q-ma-sm text-h4 text-bold">Membership Options</div>
    <div class="row fit q-px-md">
      <div class="col-xs-12 col-sm-6 col-md-3 text-center q-pa-md flex vertical-top">
        <q-card class="fit">
          <q-card-section :class="color.darkMode ? 'free-head-dk' : 'free-head-lt' + ' text-bold'"
            >Free <br />No Co-op Benefits <br /><span class="text-h5 text-bold"
              >$0</span
            ></q-card-section
          >
          <q-card-section>
            <ul class="text-left">
              <li>NO co-op voting rights</li>
              <li>NO co-op profit sharing</li>
              <li>Access to Logbook tools</li>
              <li>NO ability to save work</li>
              <li>Access to member projects</li>
            </ul>
          </q-card-section>
          <q-card-actions class="justify-center q-pb-lg">
            <q-btn
              rounded
              label="Join Now"
              color="primary"
              @click="triggerSignInDialog()"
            ></q-btn>
          </q-card-actions>
        </q-card>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-3 text-center q-pa-md flex">
        <q-card class="fit">
          <q-card-section :class="color.darkMode ? 'monthly-head-dk' : 'monthly-head-lt' + ' text-bold'"
            >Monthly<br />Co-op Membership <br /><span class="text-h5 text-bold"
              >$20 / month</span
            >
          </q-card-section>
          <q-card-section>
            <div>
              <ul class="text-left">
                <li>Full voting rights</li>
                <li>Yearly profit sharing</li>
                <li>Logbook access</li>
                <li>Fediverse account</li>
                <li>Access to future apps</li>
              </ul>
            </div>
          </q-card-section>
          <q-card-actions class="justify-center q-pb-lg">
            <q-btn
              rounded
              label="Join Now"
              color="primary"
              @click="triggerSignInDialog()"
            ></q-btn>
          </q-card-actions>
        </q-card>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-3 text-center q-pa-md flex">
        <q-card class="fit">
          <q-card-section :class="color.darkMode ? 'yearly-head-dk' : 'yearly-head-lt' + ' text-bold'"
            >Yearly<br />Co-op Membership<br /><span class="text-h5 text-bold"
              >$200 / year</span
            ></q-card-section
          >
          <q-card-section>
            <div>
              <ul class="text-left">
                <li>All monthly benefits</li>
                <li>Customized Logbook entrance</li>
                <li>Ability to run for board seat</li>
                <li>Able to have a circle role</li>
                <li>Free domain your first year</li>
              </ul>
            </div>
          </q-card-section>
          <q-card-actions class="justify-center q-pb-lg">
            <q-btn
              rounded
              label="Join Now"
              color="primary"
              @click="triggerSignInDialog()"
            ></q-btn>
          </q-card-actions>
        </q-card>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-3 text-center q-pa-md flex">
        <q-card class="fit">
          <q-card>
            <q-card-section :class="color.darkMode ? 'organization-head-dk' : 'organization-head-lt' + ' text-bold'"
              >Organization<br />Co-op Memberships<br /><span class="text-h5 text-bold"
                >$1000 / year</span
              ></q-card-section
            >
            <q-card-section>
              <div>
                <ul class="text-left">
                  <li>5 individual memberships</li>
                  <li>Shared access between members</li>
                  <li>Free yearly domain -or- hosting</li>
                  <li>Early access to lab products</li>
                  <li>Priority Support</li>
                </ul>
              </div>
            </q-card-section>
            <q-card-actions class="justify-center q-pb-lg">
              <q-btn
                rounded
                label="Join Now"
                color="primary"
                @click="triggerSignInDialog()"
              ></q-btn>
            </q-card-actions>
          </q-card>
        </q-card>
      </div>
      <div class="row full-width fit">
        <div class="col-12 text-center fit q-pa-md">
          <q-card>
            <q-card class="fit">
              <q-card-section :class="color.darkMode ? 'lifetime-head-dk' : 'lifetime-head-lt' + ' text-bold'"
                >Lifetime<br />Membership<br /><span class="text-h5 text-bold"
                  >$2000 / onetime</span
                ></q-card-section
              >
              <q-card-section>
                <div class="row fill-width text-center justify-center">
                  <ul class="text-left">
                    <li>Full individual benefits, FOREVER</li>
                    <li>A seat on the Ultri Board of Directors</li>
                    <li>Prioritization of the features you want</li>
                    <li>Early acces to lab products</li>
                    <li>Special, permanent, mention on the website</li>
                  </ul>
                </div>
              </q-card-section>
              <q-card-actions class="justify-center q-pb-lg">
                <q-btn
                  rounded
                  label="Join Now"
                  color="primary"
                  @click="triggerSignInDialog()"
                ></q-btn>
              </q-card-actions>
            </q-card>
          </q-card>
        </div>
      </div>
    </div>
  </q-page>
</template>

<script setup>
import { useQuasar } from "quasar";
import { useAuthStore } from "../stores/auth";
import { ref } from "vue";
import { useColorStore } from "../stores/color";

const auth = useAuthStore();
const color = useColorStore();

const plan = ref("yearly");

const triggerSignInDialog = async () => {
  auth.setTargetUrl("/member");
  auth.setSignInRequired(true);
  console.log(auth.targetUrl);
};

const $q = useQuasar();

console.log($q.dark.isActive);
</script>

<style lang="scss">
.free-head-lt {
  background-color: $tnt-p-90;
}
.free-head-dk {
  background-color: $shd-p-20;
}
.monthly-head-lt {
  background-color: $tnt-p-80;
}
.monthly-head-dk {
  background-color: $shd-p-30;
}
.yearly-head-lt {
  background-color: $tnt-p-70;
}
.yearly-head-dk {
  background-color: $shd-p-40;
}
.organization-head-lt {
  background-color: $tnt-p-60;
}
.organization-head-dk {
  background-color: $shd-p-50;
}
.lifetime-head-lt {
  background-color: $tnt-p-50;
}
.lifetime-head-dk {
  background-color: $shd-p-60;
}
.price-box {
  border-color: $tnt-p-90;
  border-style: solid;
}
</style>
