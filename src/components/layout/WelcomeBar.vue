<template>
  <div class="wbar">
    <div class="wbar-left">
      <span>欢迎 {{ userLabel }}</span>
      <el-tag size="small" effect="dark" round>{{ roleLabel }}</el-tag>
    </div>
    <div class="wbar-right">
      <div class="chip"><el-icon><Timer /></el-icon>本学期第 {{ week }} 周</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Timer } from '@element-plus/icons-vue'
import { useAuthStore } from '@/stores/auth'

const auth = useAuthStore()
const userLabel = computed(() => auth.user?.realName || '')
const roleLabel = computed(() => {
  const r = auth.role
  return { student: '学生', teacher: '教师', admin: '管理员', leader: '领导' }[r] || ''
})
const week = computed(() => {
  const start = new Date('2026-02-17')
  const now = new Date()
  return Math.max(1, Math.min(20, Math.floor((now.getTime() - start.getTime()) / (7*86400000)) + 1))
})
</script>

<style scoped>
.wbar{display:flex;justify-content:space-between;align-items:center;padding:10px 24px;background:linear-gradient(135deg,#0d2a6b,#153D97 50%,#108B96);color:#fff;font-size:14px;flex-shrink:0}
.wbar-left{display:flex;align-items:center;gap:10px}
.wbar-right{display:flex;align-items:center;gap:10px}
.chip{display:flex;align-items:center;gap:6px;padding:5px 14px;background:rgba(255,255,255,.1);border-radius:20px;font-size:12px}
</style>
