<template>
  <div class="bc-bar">
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/' + role + '/home' }">
        <el-icon><HomeFilled /></el-icon> {{ homeTitle }}
      </el-breadcrumb-item>
      <el-breadcrumb-item v-if="parentTitle">{{ parentTitle }}</el-breadcrumb-item>
      <el-breadcrumb-item v-if="currentTitle">{{ currentTitle }}</el-breadcrumb-item>
    </el-breadcrumb>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { HomeFilled } from '@element-plus/icons-vue'

const route = useRoute()
const role = computed(() => route.path.split('/')[1])
const homeTitle = computed(() => {
  const r = role.value
  return { student: '个人学业中心', teacher: '教师驾驶舱', admin: '管理者驾驶舱', leader: '全局业务大看板' }[r] || '首页'
})
const currentTitle = computed(() => route.meta?.title as string || '')
const parentTitle = computed(() => route.meta?.parent as string || '')
</script>

<style scoped>
.bc-bar{padding:10px 24px;background:#fff;border-bottom:1px solid #f1f5f9;flex-shrink:0}
</style>
