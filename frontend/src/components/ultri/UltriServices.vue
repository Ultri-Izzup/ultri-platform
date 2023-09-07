<template>
  <div class="row  justify-evenly full-width">
    <div
      class="text-h2 full-width text-center text-bold navbar-brand-link q-ma-md"
    >
      <span class="text-h3 text-bold">{{
        $t("services.heading2", "Put our experience to work for you.")
      }}</span>
    </div>
    <div :style="Screen.lt.md ? 'width: 97%' : 'width: 80%'">
      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">Software Project Management</p>
          <p class="text-body1 text-grey-9">
            We can manage all aspects of a software project. The work can be done by our developers, your developers, third-party development resources, or some combination.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">Software Development Training</p>
          <p class="text-body1 text-grey-9">
            We offer free training on open source software development for developers at all levels. We pair developers with more senior developers to solve problems and close tickets in open source projects. We can tailor the projects and tasks to the developers tastes.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">
            Ultri Platform Development
          </p>
          <p class="text-body1 text-grey-9">
            Get the biggest bang for your buck, we create a custom app using the
            same existing and tested platform our website is built on. We can
            have a custom app up in matter of weeks. All at a very low cost
            initial, and more importantly a very low TCO.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section>
          <p class="text-h5 text-bold text-primary">Custom Development</p>
          <p class="text-body1 text-grey-9">
            We can develop open source solutions using technologies outside of
            our stack, we just can't benefit from as much code reuse. We choose to release our software as open source, but we realize
            that doesn't work for everyone. We can create proprietary software
            just as easily as we can open source.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">Software Testing</p>
          <p class="text-body1 text-grey-9">
            Whether you need routine testing or one off testing we have you covered.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">Romanian/English Translation Services</p>
          <p class="text-body1 text-grey-9">
            We can assist in translating your website to or from Romanian and English. We have experience with managing large translation projects. More languages coming soon.
          </p>
        </q-card-section>
      </q-card>

      <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">Domain Sales and Valuations</p>
          <p class="text-body1 text-grey-9">
            We owned and managed a number of domains since 1995. We've been involved in multiple sales and appraisals, including a couple of six figure domains sales where our valuations were key in completing the transaction. Let us explain why your current domain apprasail isn't worth the paper its written on.
            </p>
        </q-card-section>
        </q-card>

        <q-card :class="Screen.lt.md ? 'q-my-md' : 'q-my-xl'">
        <q-card-section class="q-px-md">
          <p class="text-h5 text-bold text-primary">SOC2 Prep</p>
          <p class="text-body1 text-grey-9">
            Do you have an important SOC2 deadline? We have experience in meeting tough SOC deadlines with perfect audit results.
            </p>
        </q-card-section>
      </q-card>
    </div>
  </div>
</template>

<script setup>
import { computed } from"vue";
import { Screen } from "quasar";
const layout = computed(() =>
  Screen.lt.sm ? "dense" : Screen.lt.md ? "comfortable" : "loose"
);


</script>

