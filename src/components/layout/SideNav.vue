<template>
  <div class="side-wrapper">
    <div class="logo-area"><el-icon :size="22" color="#fff"><School /></el-icon><span v-show="!collapsed" class="logo-text">人才选拔全流程平台</span></div>
    <el-menu :default-active="activeMenu" :collapse="collapsed" background-color="transparent" text-color="rgba(255,255,255,.7)" active-text-color="#fff" router class="side-menu">
      <el-menu-item v-for="item in menuItems" :key="item.path" :index="item.path">
        <el-icon><component :is="item.icon" /></el-icon>
        <template #title>{{ item.title }}</template>
      </el-menu-item>
    </el-menu>
    <div v-show="!collapsed" class="side-footer"><span class="ver-tag">FTCP v2.0</span></div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
defineProps<{ collapsed: boolean }>()

const route = useRoute()
const activeMenu = computed(() => {
  const segs = route.path.split('/').filter(Boolean)
  return '/' + segs.slice(0, 2).join('/')
})

const menuItems = computed(() => {
  const role = route.path.split('/')[1] || 'student'
  const base = '/' + role
  const items: { path: string; title: string; icon: string }[] = []
  const push = (p: string, t: string, i: string) => items.push({ path: base + p, title: t, icon: i })

  if (role === 'student') {
    push('/home', '个人学业中心', 'HomeFilled')
    push('/cultivation', '培养', 'Reading')
    push('/mentorship', '导学', 'Connection')
    push('/degree', '学位', 'Trophy')
    push('/research-work', '研工管理', 'Stamp')
    push('/others', '其他', 'Setting')
  } else if (role === 'teacher') {
    push('/home', '教师驾驶舱', 'HomeFilled')
    push('/teaching', '教学', 'Reading')
    push('/mentorship', '导学', 'Connection')
    push('/supervisor', '导师', 'User')
    push('/research', '科研', 'DataAnalysis')
    push('/project', '项目', 'Folder')
    push('/secretary', '秘书', 'Monitor')
    push('/expert', '专家', 'MagicStick')
    push('/spec', '规范', 'Document')
  } else if (role === 'admin') {
    push('/home', '管理者驾驶舱', 'HomeFilled')
    push('/enrollment', '招生', 'List')
    push('/students', '学生', 'User')
    push('/research-work', '研工', 'Stamp')
    push('/cultivation', '培养', 'Reading')
    push('/degree', '学位', 'Trophy')
    push('/supervisor', '导师', 'Avatar')
    push('/system', '系统', 'Setting')
  } else if (role === 'leader') {
    push('/home', '全局业务大看板', 'HomeFilled')
    push('/enrollment', '招生', 'List')
    push('/cultivation', '培养', 'Reading')
    push('/degree', '学位', 'Trophy')
    push('/data', '数据统计', 'DataAnalysis')
  } else {
    push('/home', '首页', 'HomeFilled')
  }
  return items
})
</script>

<style scoped>
.side-wrapper{display:flex;flex-direction:column;height:100%}
.logo-area{display:flex;align-items:center;padding:16px 14px;gap:10px;height:60px;border-bottom:1px solid rgba(255,255,255,.1)}
.logo-text{color:#fff;font-size:14px;font-weight:700;white-space:nowrap}
.side-menu{border-right:none;flex:1;padding:8px 0}
.side-menu .el-menu-item{margin:3px 10px!important;border-radius:10px!important;height:44px;line-height:44px}
.side-menu .el-menu-item:hover{background:rgba(255,255,255,.1)!important}
.side-menu .el-menu-item.is-active{background:rgba(16,139,150,.3)!important;font-weight:600}
.side-footer{padding:12px 16px;border-top:1px solid rgba(255,255,255,.1)}
.ver-tag{font-size:10px;color:rgba(255,255,255,.3);background:rgba(255,255,255,.06);padding:2px 8px;border-radius:99px}
</style>
