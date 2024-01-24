import { createRouter, createWebHistory } from 'vue-router'
import EmployeeManagement from '../views/HR/EmployeeManagement.vue';
import OrganizationSettings from '../views/HR/OrganizationSettings.vue';
import UpdateForm from '../views/HR/UpdateForm.vue';
import MgtClusters from '../views/HR/Clusters/MgtClusters.vue';
import MgtDepts from '../views/HR/Departments/MgtDepts.vue';
import MgtPositions from '../views/HR/Positions/MgtPositions.vue';
import MgtProjects from '../views/Projects/MgtProjects.vue';
import MgtModules from '@/views/Projects/MgtModules.vue';
import UpdateModule from '@/views/Projects/UpdateModule.vue';
import UpdateProjects from '@/views/Projects/UpdateProject.vue';
import UpdatePositions from '@/views/HR/Positions/UpdatePositions';
import MgtPayrolls from '@/views/Finance/MgtPayrolls';
import UpdatePayroll from '@/views/Finance/UpdatePayroll';
import UpdateEmployees from '@/views/Employees/UpdateEmployees';
import AddEmployees from '@/views/Employees/AddEmployees';
import MgtEmployees from '@/views/Employees/MgtEmployees';

import Loader from '@/utils/Loader.vue';

const routes = [
  {
    path: '/',
    component: () => import('@/layouts/default/Default.vue'),
    children: [
      {
        path: '',
        name: 'Home',
        // route level code-splitting
        // this generates a separate chunk (Home-[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import('@/views/Home.vue'),
      },
    ],
  },
  {
    path: '/ManageEmployees',
    name: 'ManageEmployees',
    component: EmployeeManagement,
  },
  {
    path: '/OrganizationSettings',
    name: 'OrganizationSettings',
    component: OrganizationSettings,
  },
  {
    path: '/UpdateForm',
    name: 'UpdateForm',
    component: UpdateForm,
  },

  {
    path: '/MgtClusters',
    name: 'MgtClusters',
    component: MgtClusters,
  },

  { path: '/MgtDepts', name: 'MgtDepts', component: MgtDepts, },
  { path: '/MgtDepts', name: 'MgtDepts', component: MgtDepts, },
  { path: '/MgtPositions', name: 'MgtPositions', component: MgtPositions, },
  { path: '/MgtProjects', name: 'MgtProjects', component: MgtProjects, },
  { path: '/MgtModules', name: 'MgtModules', component: MgtModules, },
  { path: '/Loader', name: 'Loader', component: Loader, },
  { path: '/UpdateModule', name: 'UpdateModule', component: UpdateModule, },
  { path: '/UpdateProjects', name: 'UpdateProjects', component: UpdateProjects, },
  { path: '/UpdatePositions', name: 'UpdatePositions', component: UpdatePositions, },
  { path: '/MgtPayrolls', name: 'MgtPayrolls', component: MgtPayrolls, },
  { path: '/UpdatePayroll', name: 'UpdatePayroll', component: UpdatePayroll, },
  { path: '/MgtEmployees', name: 'MgtEmployees', component: MgtEmployees, },
  { path: '/UpdateEmployees', name: 'UpdateEmployees', component: UpdateEmployees, },
  { path: '/AddEmployees', name: 'AddEmployees', component: AddEmployees, },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
})

export default router
