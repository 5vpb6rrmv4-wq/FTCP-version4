import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { UserInfo, RoleType } from '@/types'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('FTCP-Token') || '')
  const user = ref<UserInfo | null>(null)
  const permissions = ref<string[]>([])

  const isLoggedIn = computed(() => !!token.value)
  const role = computed(() => user.value?.role || 'student')

  async function login(username: string, password: string, role: RoleType) {
    // Mock login — replace with actual API call
    const mockUser: UserInfo = {
      id: 1,
      username,
      realName: role === 'student' ? '张三' : role === 'teacher' ? '李教授' : '管理员',
      role,
      college: '计算机科学与技术学院',
      major: '计算机科学与技术',
      grade: '2023',
    }
    user.value = mockUser
    token.value = 'mock-token-' + Date.now()
    localStorage.setItem('FTCP-Token', token.value)
    permissions.value = role === 'admin' ? ['*'] : ['dashboard', 'profile']
  }

  function logout() {
    token.value = ''
    user.value = null
    permissions.value = []
    localStorage.removeItem('FTCP-Token')
  }

  return { token, user, permissions, isLoggedIn, role, login, logout }
})
