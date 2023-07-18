import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Ultri",
  base: "/co-op/",
  description: "Build it - Use it - Own it",
  head: [
    [
      'script',
      { async: '', src: 'https://www.googletagmanager.com/gtag/js?id=G-GKG2LWGGKE' }
    ],
    [
      'script',
      {},
      "window.dataLayer = window.dataLayer || [];\nfunction gtag(){dataLayer.push(arguments);}\ngtag('js', new Date());\ngtag('config', 'G-GKG2LWGGKE');"
    ]
  ],
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '../' },
      { text: 'About Us', link: '/about-us/' },
      { text: 'Join', link: '/coop-membership-packages/' },
      { text: 'Own It', link: '/ownership/' },

    //  { text: 'Projects', link: '/tech-coop-projects/' },
    //  {
    //    text: 'Projects',
    //    ariaLabel: 'Project Menu',
    //    items: [
    //      { text: 'Sociocracy Handbook', link: 'https://handbook.opensociocracy.org/' },
    //      { text: 'Sociocracy Logbook', link: 'https://www.ultri.com/logbook' }
    //    ]
    //  }
    ],

    sidebar: [
        {
          text: 'Join Now',
          items: [
            { text: 'Membership Options', link: '/coop-membership-packages/' },

        ]
      },
      {
        text: 'Ownership Model',
        items: [
          { text: 'Purpose', link: '/ownership/' },
          { text: 'Stakeholders', link: '/ownership/stakeholders/' },
          { text: 'Benefits', link: '/ownership/benefits/' },
          { text: 'Expectations', link: '/ownership/responsibilities/' },
          { text: 'Governance', link: '/ownership/governance/' },
          { text: 'Financial', link: '/ownership/financial/' },
          { text: 'Guidance', link: '/ownership/guidance/' },
          { text: 'Investments', link: '/ownership/investments/' },
          { text: 'Co-op Bylaws', link: '/bylaws/' },
          { text: 'Financial Projections', link: '/market/' },
        ]
      },
      {
        text: 'Co-op Projects',
        items: [
          { text: 'Sociocracy Handbook', link: 'https://handbook.opensociocracy.org/' },
          { text: 'Sociocracy Logbook', link: 'https://www.ultri.com/logbook' },
          { text: 'Circle Builder', link: 'https://github.com/OpenSociocracy/circle-builder' },
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/OpenSociocracy' }
    ]
  }
})
