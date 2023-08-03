<template>
  <q-dialog>
    <q-card>
      <q-bar>
        <span v-if="$q.screen.lt.md">Ultri</span><span v-else>Ultri Co-op</span>

        <q-space></q-space>

        <q-btn icon="mdi-close" round dense v-close-popup></q-btn>
      </q-bar>
      <q-card-section>
        <div class="text-body1 text-weight-medium q-px-md col eventPopup">
          {{ localEvent.title }}
        </div>
        <hr />
        <div class="q-px-md col" v-if="localEvent.allDay == 'FALSE'">
          <span class="text-weight-medium">Start:</span>
          {{ dateTimeStr(localEvent.start) }}
        </div>
        <div class="q-px-md col" v-if="localEvent.allDay == 'FALSE'">
          <span class="text-weight-medium">End:</span>
          {{ dateTimeStr(localEvent.end) }}
        </div>
        <div class="q-px-md col" v-if="localEvent.allDay == 'TRUE'">
          <span class="text-weight-medium">All Day:</span>
          {{ dateStr(localEvent.date) }}
        </div>
        <hr />
        <div class="q-px-md col">
          <span class="text-weight-medium">Location:</span>
          {{ localEvent.location }}
        </div>
        <hr />
        <div class="q-px-md col" v-html="localEvent.details"></div>
      </q-card-section>
      <q-card-actions class="text-center justify-center">
        <q-btn-dropdown color="primary" label="Add to Calendar" icon="mdi-calendar">
          <q-list>
            <q-item clickable v-close-popup :href="getCalendarLink('google')"  target="_blank">
              <q-item-section>
                <q-item-label>Google</q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup :href="getCalendarLink('outlook')"  target="_blank">
              <q-item-section>
                <q-item-label>Outlook</q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup :href="getCalendarLink('office365')"  target="_blank">
              <q-item-section>
                <q-item-label>Office 365</q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup :href="getCalendarLink('yahoo')"  target="_blank">
              <q-item-section>
                <q-item-label>Yahoo</q-item-label>
              </q-item-section>
            </q-item>

            <q-item clickable v-close-popup :href="getCalendarLink('ics')" target="_blank">
              <q-item-section>
                <q-item-label>Download .ics file</q-item-label>
              </q-item-section>
            </q-item>
          </q-list>
        </q-btn-dropdown>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script>
import { defineComponent, unref } from "vue";

import { useQuasar, date } from 'quasar'

import { parseTimestamp } from "@quasar/quasar-ui-qcalendar";
import { google, outlook, office365, yahoo, ics } from "calendar-link";

export default defineComponent({
  name: "CalendarEventDialog",
  components: {},
  props: ["event"],
  setup(props, { emit }) {
    console.log(props.event);

    const localEvent = unref(props.event);

    console.log(localEvent)



    const $q = useQuasar()

    const dateTimeStr = (dateTime) => {
      const options = {
        weekday: "short",
        year: "numeric",
        month: "long",
        day: "numeric",
      };

      const calDate = new Date(dateTime);
      console.log(calDate)

      console.log(calDate.getTimezoneOffset())

       calDate.setMinutes(calDate.getMinutes() - calDate.getTimezoneOffset());

      return (
        calDate.toLocaleString()
      );
    };

    const dateStr = (dateIn) => {
      const options = {
        weekday: "long",
        year: "numeric",
        month: "long",
        day: "numeric",
      };

      const date = new Date(dateIn);
      return date.toLocaleDateString("us-EN", options);
    };

    const getCalendarLink = (target) => {
      const startDate = new Date(localEvent.start);

      startDate.setMinutes(startDate.getMinutes() - startDate.getTimezoneOffset());

      let event;

      if (localEvent.allDay == "TRUE") {
        event = {
          title: localEvent.title,
          description: localEvent.details,
          allDay: true,
        };
      } else {
        event = {
          title: localEvent.title,
          description: localEvent.details,
          start: startDate,
          duration: [localEvent.duration, "minute"],
        };
      }

      let link;

      switch (target) {
        case "google":
          link = google(event);
          break;
        case "outlook":
          link = outlook(event);
          break;
        case "office365":
          link = office365(event);
          break;
        case "yahoo":
          link = yahoo(event);
          break;
        case "ics":
          link = ics(event);
          break;
      }

      return link;
    };

    return {
      dateTimeStr,
      dateStr,
      getCalendarLink,
      localEvent
    };
  },
});
</script>

<style scoped>
.eventPopup {
  min-width: 250px;
}
.date-head {
  font-size: 1.3em;
  font-style: italic;
}
</style>
