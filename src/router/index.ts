import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const studentRoutes: RouteRecordRaw[] = [
  {
    path: '/student',
    redirect: '/student/home',
    children: [
      {
        path: 'home', name: 'StudentHome',
        component: () => import('@/views/student/home/HomePage.vue'),
        meta: { title: '个人学业中心', icon: 'HomeFilled', roles: ['student'] },
      },
      {
        path: 'cultivation', name: 'StudentCultivation', redirect: '/student/cultivation/plan',
        meta: { title: '培养', icon: 'Reading' },
        children: [
          { path: 'plan', name: 'SCultPlan', component: () => import('@/views/student/cultivation/PlanPage.vue'), meta: { title: '培养管理' } },
          { path: 'courses', name: 'SCultCourses', component: () => import('@/views/student/cultivation/CoursesPage.vue'), meta: { title: '课务管理' } },
          { path: 'exams', name: 'SCultExams', component: () => import('@/views/student/cultivation/ExamsPage.vue'), meta: { title: '考级管理' } },
          { path: 'modules', name: 'SCultModules', component: () => import('@/views/student/cultivation/ModulesPage.vue'), meta: { title: '必修环节' } },
          { path: 'status', name: 'SCultStatus', component: () => import('@/views/student/cultivation/StatusPage.vue'), meta: { title: '学籍异动' } },
        ],
      },
      {
        path: 'mentorship', name: 'StudentMentorship', redirect: '/student/mentorship/team',
        meta: { title: '导学', icon: 'Connection' },
        children: [
          { path: 'team', name: 'SMentorTeam', component: () => import('@/views/student/mentorship/TeamPage.vue'), meta: { title: '导学团队' } },
          { path: 'academic', name: 'SMentorAcademic', component: () => import('@/views/student/mentorship/AcademicPage.vue'), meta: { title: '学风建设' } },
          { path: 'ideology', name: 'SMentorIdeology', component: () => import('@/views/student/mentorship/IdeologyPage.vue'), meta: { title: '思想建设' } },
          { path: 'culture', name: 'SMentorCulture', component: () => import('@/views/student/mentorship/CulturePage.vue'), meta: { title: '文化建设' } },
          { path: 'jiebang', name: 'SMentorJiebang', component: () => import('@/views/student/mentorship/JiebangPage.vue'), meta: { title: '揭榜挂帅' } },
        ],
      },
      {
        path: 'degree', name: 'StudentDegree', redirect: '/student/degree/thesis',
        meta: { title: '学位', icon: 'Trophy' },
        children: [
          { path: 'thesis', name: 'SDegThesis', component: () => import('@/views/student/degree/ThesisPage.vue'), meta: { title: '学位论文' } },
          { path: 'graduation', name: 'SDegGrad', component: () => import('@/views/student/degree/GraduationPage.vue'), meta: { title: '毕业学位' } },
          { path: 'achievements', name: 'SDegAchieve', component: () => import('@/views/student/degree/AchievementsPage.vue'), meta: { title: '论文成果' } },
        ],
      },
      {
        path: 'research-work', name: 'StudentRW', redirect: '/student/research-work/scholarship',
        meta: { title: '研工管理', icon: 'Stamp' },
        children: [
          { path: 'scholarship', name: 'SRWScholar', component: () => import('@/views/student/researchwork/ScholarshipPage.vue'), meta: { title: '奖助学金' } },
          { path: 'loan', name: 'SRWLoan', component: () => import('@/views/student/researchwork/LoanPage.vue'), meta: { title: '助学贷款' } },
          { path: 'attendance', name: 'SRWLeave', component: () => import('@/views/student/researchwork/LeavePage.vue'), meta: { title: '日常管理' } },
          { path: 'assist', name: 'SRWAssist', component: () => import('@/views/student/researchwork/AssistPage.vue'), meta: { title: '三助一辅' } },
          { path: 'hardship', name: 'SRWHardship', component: () => import('@/views/student/researchwork/HardshipPage.vue'), meta: { title: '困难申请' } },
        ],
      },
      {
        path: 'others', name: 'StudentOthers', redirect: '/student/others/profile',
        meta: { title: '其他', icon: 'Setting' },
        children: [
          { path: 'profile', name: 'SOthProfile', component: () => import('@/views/student/others/ProfilePage.vue'), meta: { title: '个人信息' } },
          { path: 'photo', name: 'SOthPhoto', component: () => import('@/views/student/others/PhotoPage.vue'), meta: { title: '照片核对' } },
          { path: 'docs', name: 'SOthDocs', component: () => import('@/views/student/others/DocsPage.vue'), meta: { title: '证件扫描' } },
          { path: 'notices', name: 'SOthNotices', component: () => import('@/views/student/others/NoticesPage.vue'), meta: { title: '通知公告' } },
        ],
      },
    ],
  },
]

const teacherRoutes: RouteRecordRaw[] = [
  {
    path: '/teacher',
    redirect: '/teacher/home',
    children: [
      { path: 'home', name: 'TeacherHome', component: () => import('@/views/teacher/HomePage.vue'), meta: { title: '教师驾驶舱', icon: 'HomeFilled', roles: ['teacher'] } },
      { path: 'teaching', name: 'TTeaching', component: () => import('@/views/teacher/TeachingPage.vue'), meta: { title: '教学', icon: 'Reading', roles: ['teacher'] } },
      { path: 'supervisor', name: 'TSupervisor', component: () => import('@/views/teacher/SupervisorPage.vue'), meta: { title: '导师', icon: 'User', roles: ['teacher'] } },
      { path: 'research', name: 'TResearch', component: () => import('@/views/teacher/ResearchPage.vue'), meta: { title: '科研', icon: 'DataAnalysis', roles: ['teacher'] } },
      { path: 'project', name: 'TProject', component: () => import('@/views/teacher/ProjectPage.vue'), meta: { title: '项目', icon: 'Folder', roles: ['teacher'] } },
      { path: 'secretary', name: 'TSecretary', component: () => import('@/views/teacher/SecretaryPage.vue'), meta: { title: '秘书', icon: 'Monitor', roles: ['teacher'] } },
      { path: 'expert', name: 'TExpert', component: () => import('@/views/teacher/ExpertPage.vue'), meta: { title: '专家', icon: 'MagicStick', roles: ['teacher'] } },
      { path: 'spec', name: 'TSpec', component: () => import('@/views/teacher/SpecPage.vue'), meta: { title: '规范', icon: 'Document', roles: ['teacher'] } },
    ],
  },
]

const adminRoutes: RouteRecordRaw[] = [
  {
    path: '/admin',
    redirect: '/admin/home',
    children: [
      { path: 'home', name: 'AdminHome', component: () => import('@/views/admin/HomePage.vue'), meta: { title: '管理者驾驶舱', icon: 'HomeFilled', roles: ['admin'] } },
      { path: 'enrollment', name: 'AEnroll', component: () => import('@/views/admin/EnrollmentPage.vue'), meta: { title: '招生', icon: 'List', roles: ['admin'] } },
      { path: 'students', name: 'AStudents', component: () => import('@/views/admin/StudentsPage.vue'), meta: { title: '学生', icon: 'User', roles: ['admin'] } },
      { path: 'system', name: 'ASys', component: () => import('@/views/admin/SystemPage.vue'), meta: { title: '系统', icon: 'Setting', roles: ['admin'] } },
    ],
  },
]

const leaderRoutes: RouteRecordRaw[] = [
  {
    path: '/leader',
    redirect: '/leader/home',
    children: [
      { path: 'home', name: 'LeaderHome', component: () => import('@/views/leader/HomePage.vue'), meta: { title: '全局业务大看板', icon: 'HomeFilled', roles: ['leader'] } },
      { path: 'enrollment', name: 'LEnroll', component: () => import('@/views/leader/PlaceholderPage.vue'), meta: { title: '招生', icon: 'List', roles: ['leader'] } },
      { path: 'cultivation', name: 'LCult', component: () => import('@/views/leader/PlaceholderPage.vue'), meta: { title: '培养', icon: 'Reading', roles: ['leader'] } },
      { path: 'degree', name: 'LDegree', component: () => import('@/views/leader/PlaceholderPage.vue'), meta: { title: '学位', icon: 'Trophy', roles: ['leader'] } },
      { path: 'data', name: 'LData', component: () => import('@/views/leader/DataPage.vue'), meta: { title: '数据统计', icon: 'DataAnalysis', roles: ['leader'] } },
    ],
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/login', name: 'Login', component: () => import('@/views/auth/LoginPage.vue'), meta: { title: '登录' } },
    {
      path: '/',
      component: () => import('@/components/layout/MainLayout.vue'),
      redirect: '/student/home',
      children: [...studentRoutes, ...teacherRoutes, ...adminRoutes, ...leaderRoutes],
    },
    { path: '/:pathMatch(.*)*', redirect: '/student/home' },
  ],
})

// Route guard
router.beforeEach((to, _from, next) => {
  const token = localStorage.getItem('FTCP-Token')
  if (to.path !== '/login' && !token) {
    next('/login')
  } else {
    next()
  }
})

export default router
