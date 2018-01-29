import Home from './components/Home.vue';
import Create from './components/Create.vue';
import About from './components/About.vue';

export default [
  {
    path: '/',
    component: Home
  },
  {
    path: '/create',
    component: Create
  },
  {
    path: '/about',
    component: About
  }
]
