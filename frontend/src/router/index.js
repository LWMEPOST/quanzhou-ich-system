import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/UserHome.vue')
    },
    {
      path: '/ich',
      name: 'ich',
      component: () => import('@/views/ich/IchExplore.vue')
    },
    {
      path: '/master',
      name: 'master',
      component: () => import('@/views/master/MasterExplore.vue')
    },
    {
      path: '/activity',
      name: 'activity',
      component: () => import('@/views/activity/ActivityExplore.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/Login.vue')
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('@/views/Register.vue')
    },
    {
      path: '/admin',
      name: 'admin',
      component: () => import('@/views/AdminLogin.vue')
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('@/views/dashboard/Dashboard.vue')
    }
  ]
})

export default router
