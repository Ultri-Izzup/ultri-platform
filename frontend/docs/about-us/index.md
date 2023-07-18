<script setup>
import { VPTeamMembers } from 'vitepress/theme'

const topMembers = [
  {
    avatar: 'https://handbook.opensociocracy.org/team/brian.jpg',
    name: 'Brian Winkers',
    title: 'Founding Member',
    links: [
      { icon: 'github', link: 'https://github.com/bwinkers' },
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/bwinkers/' }
    ],
    desc: 'Over 35 years experience with startups, community building and web development.'
  },
  {
    avatar: 'https://handbook.opensociocracy.org/team/will.png',
    name: 'Will Stedden',
    title: 'Founding Member',
    links: [
      { icon: 'github', link: 'https://github.com/stedn' },
      { icon: 'mastodon', link: 'https://sigmoid.social/@bonkerfield' },
      { icon: 'linkedin', link: 'https://linkedin.com/in/willstedden' }
    ],
    desc: 'Likes to build things, has a passion for economic democracy and getting stuff done.'
  },
]

const founders = [
  {
    avatar: 'https://handbook.opensociocracy.org/team/brian.jpg',
    name: 'Brian Winkers',
    title: 'Founding Member',
    links: [
      { icon: 'github', link: 'https://github.com/bwinkers' },
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/bwinkers/' }
    ],
    desc: 'Over 35 years experience with startups, community building and web development.'
  },
  {
    avatar: 'https://handbook.opensociocracy.org/team/will.png',
    name: 'Will Stedden',
    title: 'Founding Member',
    links: [
      { icon: 'github', link: 'https://github.com/stedn' },
      { icon: 'mastodon', link: 'https://sigmoid.social/@bonkerfield' },
      { icon: 'linkedin', link: 'https://linkedin.com/in/willstedden' }
    ],
    desc: 'Likes to build things, has a passion for economic democracy and getting stuff done.'
  },
  {
    avatar: 'https://www.ultri.com/team/diego.jpeg',
    name: 'Diego Acevedo',
    title: 'Founding Member',
    links: [
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/diegoacevedonetwork/' }
    ],
    desc: 'Democratic workplace advocate.'
  },
]
</script>

# About Ultri Co-op

## Founding Members

<VPTeamMembers size="small" :members="founders" />

## Products and Services

[Products](/tech-coop-products/)

[Services](/tech-coop-services/)
