<template>
  <q-page flex>
    <div class="row">
      <div class="col-5">
        <div class="q-pa-md q-gutter-sm">
          <q-btn
            icon="mdi-refresh"
            size="md"
            @click="onToday"
            aria-label="today"
            dense
          ></q-btn>
          <q-btn
            icon="mdi-arrow-left"
            size="md"
            @click="onPrev"
            aria-label="next month"
            dense
          ></q-btn>
          <q-btn
            icon="mdi-arrow-right"
            size="md"
            @click="onNext"
            aria-label="last month"
            dense
          ></q-btn>
        </div>
      </div>

      <div
        class="col text-weight-bold dateHead q-pt-md text-center justify-center"
      >
        {{ monthStr }} - {{ yearStr }}
      </div>
    </div>
    <div class="q-pa-md full-width" style="height: 400px">
      <q-calendar-month
        ref="calendar"
        v-model="selectedDate"
        :day-min-height="70"
        focusable
        hoverable
        bordered
        animated
        @change="onChange"
        @moved="onMoved"
      >
        <!--
            @click-date="onClickDate"
      @click-day="onClickDay"
      @click-head-day="onClickHeadDay"
                @click-workweek="onClickWorkweek"
          @click-head-workweek="onClickHeadWorkweek"
      .-->
        <!--
        <template #day="{ scope: { timestamp } }">
          <template v-for="event in eventsMap[timestamp.date]" :key="event.id">
            <div
              :class="badgeClasses(event, 'day')"
              :style="badgeStyles(event, 'day')"
              class="my-event"
            >
              <div
                class="title q-calendar__ellipsis"
                clickable
                @click="onClick(event)"
              >
                {{ event.title + (event.time ? " - " + event.time : "") }}
                 <q-tooltip>{{ event.details }}</q-tooltip>
              </div>
            </div>
          </template>
        </template>
      -->
        <template #week="{ scope: { week, weekdays } }">
          <template
            v-for="(computedEvent, index) in getWeekEvents(week, weekdays)"
            :key="index"
          >
            <div
              :class="badgeClasses(computedEvent)"
              :style="badgeStyles(computedEvent, week.length)"
            >
              <div
                v-if="computedEvent.event "
                class="title q-calendar__ellipsis"
                clickable
                @click="onClick(computedEvent.event)"
              >
                {{
                  computedEvent.event.title +
                  (computedEvent.event.time
                    ? " - " + computedEvent.event.time
                    : "")
                }}
                <!-- <q-tooltip>{{ computedEvent.event.details }}</q-tooltip> -->
              </div>
            </div>
          </template>
        </template>
      </q-calendar-month>
    </div>
  </q-page>
</template>

<script>
import { defineComponent, ref, computed, onMounted } from "vue";

import {
  QCalendarMonth,
  today,
  addToDate,
  parseDate,
  parseTimestamp,
  daysBetween,
  isOverlappingDates,
  parsed,
  indexOf,
} from "@quasar/quasar-ui-qcalendar";

import { useMeta, useQuasar } from "quasar";

import CalendarEventDialog from "../components/CalendarEventDialog.vue";

const CURRENT_DAY = new Date();
function getCurrentDay(day) {
  const newDay = new Date(CURRENT_DAY);
  newDay.setDate(day);
  const tm = parseDate(newDay);
  return tm.date;
}

import eventData from "../data/calendar.json";
console.log(eventData);
const localEvents = eventData.events;
console.log(localEvents)



const events = ref(localEvents);

console.log(events.value)

export default defineComponent({
  name: "CalendarPage",
  emits: ["newTitle"],
  components: {
    QCalendarMonth,
  },
  setup(props, { emit }) {
    emit("newTitle", "Ultri Co-op Events");

    const $q = useQuasar();

    const metaData = {
      // sets document title
      title: "Community Events",
    };
    // needs to be called in setup()
    useMeta(metaData);

    const selectedDate = ref(today()),
      calendar = ref(null),
      startDate = ref(today()),
      endDate = ref(today());

    function onMoved(data) {
      console.log("onMoved", data);
    }

    function onChange(data) {
      startDate.value = data.start;
      endDate.value = data.end;
    }

    function onClickDate(data) {
      console.log("onClickDate", data);
    }

    function onClickDay(data) {
      console.log("onClickDay", data);
    }

    function onClickHeadDay(data) {
      console.log("onClickHeadDay", data);
    }

    function onToday() {
      selectedDate.value = today();
    }

    function onPrev() {
      calendar.value.prev();
    }

    function onNext() {
      calendar.value.next();
    }

    const eventMap = ref({});

    const months = {
      "01": {
        full: "January",
        abbr: "Jan",
      },
      "02": {
        full: "February",
        abbr: "Feb",
      },
      "03": {
        full: "March",
        abbr: "Mar",
      },
      "04": {
        full: "April",
        abbr: "Apr",
      },
      "05": {
        full: "May",
        abbr: "May",
      },
      "06": {
        full: "June",
        abbr: "Jun",
      },
      "07": {
        full: "July",
        abbr: "Jul",
      },
      "08": {
        full: "August",
        abbr: "Aug",
      },
      "09": {
        full: "September",
        abbr: "Sep",
      },
      10: {
        full: "October",
        abbr: "Oct",
      },
      11: {
        full: "November",
        abbr: "Nov",
      },
      12: {
        full: "December",
        abbr: "Dec",
      },
    };

    const yearStr = computed(() => {
      return selectedDate.value.substring(0, 4);
    });

    const monthStr = computed(() => {
      const m = selectedDate.value.substring(5, 7);
      return months[m].full;
    });

    onMounted(async () => {

    });

    const detailOpen = ref(false);

    return {
      selectedDate,
      calendar, // ref
      onMoved,
      onChange,
      onClickDate,
      onClickDay,
      onClickHeadDay,
      onToday,
      onPrev,
      onNext,
      events,
      detailOpen,
      eventMap,
      yearStr,
      monthStr,
    };
  },
  computed: {
    eventsMap() {
      const map = {};
      if (events.value.length > 0) {
        events.value.forEach((event) => {
          (map[event.date] = map[event.date] || []).push(event);
          //console.log(event);
          if (event.days !== undefined) {
            let timestamp = parseTimestamp(event.date);
            let days = event.days;
            // add a new event for each day
            // skip 1st one which would have been done above
            do {
              timestamp = addToDate(timestamp, { day: 1 });
              if (!map[timestamp.date]) {
                map[timestamp.date] = [];
              }
              map[timestamp.date].push(event);
              // already accounted for 1st day
            } while (--days > 1);
          }
        });
      }
      //console.log(map);
      return map;
    },
  },

  methods: {
    getWeekEvents(week, weekdays) {
      const firstDay = parsed(week[0].date + " 00:00");
      const lastDay = parsed(week[week.length - 1].date + " 23:59");
      const eventsWeek = [];
      this.events.forEach((event, id) => {
        //console.log(event.end);
        //const startDate = parsed(event.start + ' 00:00')
        //const endDate = parsed(event.end + ' 23:59')
        const startDate = parsed(event.start);
        const endDate = parsed(event.end);

        //console.log("START")
        //console.log(startDate)
        //console.log("END")
        //console.log(endDate)

        if (isOverlappingDates(startDate, endDate, firstDay, lastDay)) {
          const left = daysBetween(firstDay, startDate, true);
          const right = daysBetween(endDate, lastDay, true);
          eventsWeek.push({
            id, // index event
            left, // Position initial day [0-6]
            right, // Number days available
            size: week.length - (left + right), // Size current event (in days)
            event, // Info
          });
        }
      });
      const events = [];
      if (eventsWeek.length > 0) {
        const infoWeek = eventsWeek.sort((a, b) => a.left - b.left);
        infoWeek.forEach((_, i) => {
          this.insertEvent(events, week.length, infoWeek, i, 0, 0);
        });
      }
      return events;
    },
    insertEvent(events, weekLength, infoWeek, index, availableDays, level) {
      const iEvent = infoWeek[index];

      if (iEvent !== undefined && iEvent.left >= availableDays) {
        // If you have space available, more events are placed
        if (iEvent.left - availableDays) {
          // It is filled with empty events
          events.push({ size: iEvent.left - availableDays });
        }
        // The event is built
        events.push({ size: iEvent.size, event: iEvent.event });
        if (level !== 0) {
          // If it goes into recursion, then the item is deleted
          infoWeek.splice(index, 1);
        }
        const currentAvailableDays = iEvent.left + iEvent.size;
        if (currentAvailableDays < weekLength) {
          const indexNextEvent = indexOf(
            infoWeek,
            (e) => e.id !== iEvent.id && e.left >= currentAvailableDays
          );
          this.insertEvent(
            events,
            weekLength,
            infoWeek,
            indexNextEvent !== -1 ? indexNextEvent : index,
            currentAvailableDays,
            level + 1
          );
        } // else: There are no more days available, end of iteration
      } else {
        events.push({ size: weekLength - availableDays });
        // end of iteration
      }
    },

    badgeClasses(computedEvent) {
      if (computedEvent.event !== undefined) {
        return {
          "my-event": true,
          "text-white": true,
          [`bg-${computedEvent.event.bgcolor}`]: true,
          "rounded-border": true,
          "q-calendar__ellipsis": true,
        };
      }
      return {
        "my-void-event": true,
      };
    },
    badgeStyles(computedEvent, weekLength) {
      const s = {};
      if (computedEvent.size !== undefined) {
        s.width = (100 / weekLength) * computedEvent.size + "%";
      }
      return s;
    },
    isBetweenDatesWeek(dateStart, dateEnd, weekStart, weekEnd) {
      return (
        (dateEnd < weekEnd && dateEnd >= weekStart) ||
        dateEnd === weekEnd ||
        (dateEnd > weekEnd && dateStart <= weekEnd)
      );
    },
    onClick(event) {
      //console.log("clicked");
      //console.log(event);

      this.$q
        .dialog({
          component: CalendarEventDialog,

          // props forwarded to your custom component
          componentProps: {
            event: event,
            html: true,
          },
          html: true,
        })
        .onOk((data) => {})
        .onCancel(() => {
          // console.log('>>>> Cancel')
        })
        .onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        });
    },
    onClickWorkweek(data) {
      console.log("onClickWorkweek", data);
    },
    onClickHeadWorkweek(data) {
      console.log("onClickHeadWorkweek", data);
    },
  },
});
</script>

<style src="@quasar/quasar-ui-qcalendar/dist/QCalendarMonth.min.css"></style>
<style lang="sass"  scoped>
.dateHead
  font-size: 1.75em
.my-event
  position: relative
  display: inline-flex
  white-space: nowrap
  font-size: 12px
  height: 16px
  max-height: 16px
  margin: 1px 0 0 0
  justify-content: center
  text-overflow: ellipsis
  overflow: hidden
  cursor: pointer
.title
  position: relative
  display: flex
  justify-content: center
  align-items: center
  height: 100%
.my-void-event
  display: inline-flex
  white-space: nowrap
  height: 1px
.text-white
  color: white
.bg-blue
  background: blue
.bg-green
  background: green
.bg-orange
  background: orange
.bg-red
  background: red
.bg-teal
  background: teal
.bg-grey
  background: grey
.bg-purple
  background: purple
.rounded-border
  border-radius: 2px
</style>
