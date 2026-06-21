<template>
  <div class="topnav">
    <div class="tn-left">
      <el-button :icon="Fold" text size="large" class="toggle-btn" @click="$emit('toggle')" />
      <div class="quick-nav">
        <button v-for="m in quickMenus" :key="m.path" class="qn-btn" :class="{ active: isActive(m.path) }" @click="$router.push(m.path)">{{ m.title }}</button>
      </div>
    </div>
    <div class="tn-right">
      <el-dropdown trigger="click">
        <div class="user-chip"><el-avatar :size="30" icon="UserFilled" /><span class="uname">{{ roleLabel }}</span><el-icon><ArrowDown /></el-icon></div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="$router.push('/login')">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { Fold, ArrowDown } from '@element-plus/icons-vue'

defineEmits(['toggle'])
const route = useRoute()

const roleLabel = computed(() => {
  const r = route.path.split('/')[1]
  const map: Record<string,string> = { student: '学生端', teacher: '教师端', admin: '管理员端', leader: '领导端' }
  return map[r] || '未知'
})

const quickMenus = computed(() => {
  const role = route.path.split('/')[1] || 'student'
  const base = '/' + role
  const push = (p: string, t: string) => ({ path: base + p, title: t })
  const menus: { path: string; title: string }[] = [push('/home', '首页')]
  if (role === 'student') {
    menus.push(push('/cultivation', '培养'), push('/mentorship', '导学'), push('/degree', '学位'), push('/research-work', '研工'), push('/others', '其他'))
  } else if (role === 'teacher') {
    menus.push(push('/teaching', '教学'), push('/mentorship', '导学'), push('/supervisor', '导师'), push('/research', '科研'), push('/project', '项目'))
  } else if (role === 'admin') {
    menus.push(push('/enrollment', '招生'), push('/students', '学生'), push('/cultivation', '培养'), push('/degree', '学位'), push('/system', '系统'))
  } else if (role === 'leader') {
    menus.push(push('/enrollment', '招生'), push('/cultivation', '培养'), push('/degree', '学位'), push('/data', '数据'))
  }
  return menus
})

function isActive(path: string) { return route.path.startsWith(path) }
</script>

<style scoped>
.topnav{display:flex;justify-content:space-between;align-items:center;padding:0 20px;height:52px}
.tn-left{display:flex;align-items:center;gap:12px;overflow:hidden;flex:1}
.quick-nav{display:flex;gap:2px}
.qn-btn{padding:6px 16px;border:none;background:transparent;color:#1e293b;font-size:13px;cursor:pointer;border-radius:8px;font-family:inherit}
.qn-btn:hover{background:#f1f5f9}.qn-btn.active{background:#eff6ff;color:#153D97;font-weight:600}
.user-chip{display:flex;align-items:center;gap:8px;padding:5px 8px;border-radius:12px;cursor:pointer}
.user-chip:hover{background:#f8fafc}
.uname{font-size:13px;font-weight:600;color:#1e293b}
</style>
