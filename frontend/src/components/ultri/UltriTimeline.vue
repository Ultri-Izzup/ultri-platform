<template>
  <div :class="smallScreen ? 'row full-width q-px-xs' : 'row full-width q-px-xl'" :style="smallScreen ? 'width: 100%' : 'width: 80%'">
    <q-timeline :layout="layout" color="secondary">
      <q-timeline-entry heading> The Foundation </q-timeline-entry>

      <q-timeline-entry
        title='Defining a "Tech Co-op"'
        subtitle="December 2022"
        side="left"
        icon="mdi-account-group"
        color="green-5"
      >
        <div>
          A Discord channel was created to discuss what a "tech co-op" was and
          how it could operate. We talked with other co-ops about how they
          operated and what they were looking for. We still use the Discord
          today and refer to those early notes, though things have changed a lot
          in that time.
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Creating a Strong Core"
        subtitle="Early 2023"
        side="right"
        color="green-6"
        icon="mdi-arm-flex"
      >
        <div>
          <div>
            One early understanding was that open, portable systems were
            required. We spent a couple of months trialing various open source
            auth and web solutions, looking for the right balance of power and
            simplicity.
          </div>
          <ul>
            <li>Quasar / Vue3 reactive front end</li>
            <li>OpenResty (Nginx)</li>
            <li>Fastify API</li>
            <li>SuperTokens auth</li>
            <li>Postgres database</li>
            <li>Redis caching</li>
          </ul>
        </div>
      </q-timeline-entry>

      <q-timeline-entry heading>Focus on Sociocracy</q-timeline-entry>

      <q-timeline-entry
        title="Problems Making Decisions"
        subtitle="Spring 2023"
        side="left"
        icon="mdi-alert"
        color="light-blue-5"
      >
        <div>
          Various co-op groups couldn't decide on a project to move fowards, we
          could even decide &quot;how to decide&quot;. This led to looking into
          using Sociocracy to improve the decsion making process. That proved to
          be just another problem, as there was no quick, easy way to know if
          you were using Sociocracy correctly.
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="OpenSociocracy is Born"
        subtitle="May 1, 2023"
        side="right"
        icon="mdi-account-heart"
        color="light-blue-7"
      >
        <div>
          We decided to create the sociocracy tools we wished were there for us,
          and created
          <a href="https://www.opensociocracy.org">OpenSociocracy.org</a>
          to house those efforts. We created another Discord channel and reached
          out to the Sociocracy community for assistance in defining the open
          source tools.
        </div>
        <div>
          We are creating a
          <a href="https://handbook.opensociocracy.org/">sociocracy handbook</a>
          to help people understand when and how to apply sociocratic practices.
          Free versions of many of our tools are available on
          <a href="https://www.opensociocracy.org/">Opensociocracy.org</a>.
        </div>
      </q-timeline-entry>

      <q-timeline-entry heading>Clearer Business Vision</q-timeline-entry>

      <q-timeline-entry
        title="Ultri Launched"
        subtitle="June 2023"
        side="left"
        color="orange-4"
        icon="mdi-rocket-launch"
      >
        <div>
          Since may of our tools aren't directly related to sociocracy, we
          launched Ultri.com so that we could offer services under a name that
          was more generic than "OpenSociocracy".
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Parallel Work on Products"
        subtitle="July 2023"
        side="right"
        color="orange-6"
        icon="mdi-math-norm"
      >
        <div>
          The development team worked on our circles and domains product, as
          well creating a more useful business canvas template.
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Canava is Born"
        subtitle="August 2023"
        side="left"
        color="orange-7"
        icon="mdi-cake-variant"
      >
        <div>
          The concept of
          <a href="https://www.ultri.com/canava">Canava</a> was created to
          provide a more cohesive product around canvas creation and
          customization.
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Canava LAUNCHED"
        subtitle="September 2023"
        side="right"
        color="orange-9"
        icon="mdi-firework"
      >
        <div>
          Less than a month after the idea was conceived, the first version of
          <a href="https://www.ultri.com/canava">Canava</a> with sign in and the
          ability to save canvases was launched.
        </div>
      </q-timeline-entry>

      <q-timeline-entry heading>Work In Progress</q-timeline-entry>

      <q-timeline-entry
        title="Canava Improvements"
        subtitle="September 2023"
        side="left"
        color="purple-4"
      >
        <div>
          We will be rolling out a PRO version with the ability to share
          canvases with the public, or with select groups of viewers and
          editors.
        </div>
      </q-timeline-entry>

      <q-timeline-entry heading>The Future</q-timeline-entry>

      <q-timeline-entry
        title="Circles, Domains and Members"
        subtitle="October 2023"
        side="right"
        color="blue-4"
        icon="mdi-domain"
      >
        <div>
          Our Circle Manager will allow you to define the structure and flow of
          authority within your organization.
          <ul>
            <li>Define Circles</li>
            <li>Define Sociocratic roles for each circle</li>
            <li>Define the circle domain using a variety of canvases</li>
            <li>Assign circle members</li>
            <li>Define drivers and OKR for each circle</li>
            <li>More feature-rich and integrated than Peerdom.</li>
          </ul>
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="VoteTracker - Decison Making"
        subtitle="November 2023"
        side="right"
        color="blue-5"
        icon="mdi-vote"
      >
        <div>
          Our voting and descision making tools will be added to the open source
          office suite.
          <ul>
            <li>Sociocratic rounds</li>
            <li>Majority / unanimous voting</li>
            <li>Ranked choice</li>
            <li>Apportionment</li>
            <li>Better integration than Loomio</li>
          </ul>
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Dashboards - Organize Circles"
        subtitle="December 2023"
        side="right"
        color="blue-7"
        icon="mdi-view-dashboard"
      >
        <div>
          Dashboards will give you a single entry point for all your circle
          activities.
          <ul>
            <li>Calendar</li>
            <li>Todo lists</li>
            <li>List management</li>
            <li>Notion-like fucntionality</li>
          </ul>
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="Izzup - Sharing and Publishing"
        subtitle="Q1 2024"
        side="right"
        color="blue-8"
        icon="mdi-view-dashboard"
      >
        <div>
          Izzup will provide sharing and publishing services to individual and
          businesses.
          <ul>
            <li>Fediverse integration</li>
            <li>Powerful content editors</li>
            <li>Integrated with Ultri business tools</li>
          </ul>
        </div>
      </q-timeline-entry>

      <q-timeline-entry
        title="SharedChain - Blockchain enabling Ultri and Izzup"
        subtitle="Q2-Q4 2024"
        side="right"
        color="blue-9"
        icon="mdi-link-lock"
      >
        <div>
          SharedChain will add blockchain connectivity to Ultri and Izzup
          products
          <ul>
            <li>Use with any software</li>
            <li>Optimized for Ultri and Izzup platforms</li>
            <li>Uses internal provate blockchains</li>
            <li>Enables smart contracts written in Typescript</li>
            <li>WASM server deployment for low energy consumption and speed</li>
          </ul>
        </div>
      </q-timeline-entry>
    </q-timeline>
  </div>
</template>

<script setup>
import { computed } from"vue";
import { Screen } from "quasar";
const layout = computed(() =>
  Screen.lt.sm ? "dense" : Screen.lt.md ? "comfortable" : "loose"
);

const smallScreen = computed(() =>
  Screen.lt.md ? true : false
);

</script>

