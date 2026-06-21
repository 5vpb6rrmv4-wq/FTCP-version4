<template>
  <el-container class="app-root">
    <el-aside :width="sidebarCollapsed ? '64px' : '220px'" class="app-sidebar">
      <SideNav :collapsed="sidebarCollapsed" @toggle="sidebarCollapsed=!sidebarCollapsed" />
    </el-aside>
    <el-container class="main-area">
      <el-header height="auto" class="top-bar">
        <TopNav :role="userRole" @toggle="sidebarCollapsed=!sidebarCollapsed" />
      </el-header>
      <WelcomeBar :role="userRole" />
      <BreadcrumbBar />
      <el-main class="page-content">
        <router-view />
      </el-main>
    </el-container>

    <div id="print-root" class="print-area">
      <div class="print-content">
        <h2>{{ printTitle }}</h2>
        <table><tbody><tr v-for="r in printRows" :key="r.label">
          <td class="print-label">{{ r.label }}</td><td class="print-value">{{ r.value }}</td>
        </tr></tbody></table>
        <p class="print-footer">人才选拔全流程平台 · 打印时间: {{ printTime }}</p>
      </div>
    </div>
  </el-container>
</template>

<script setup lang="ts">
import { ref, computed, onUnmounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { usePrint } from '@/composables/usePrint'
import SideNav from './SideNav.vue'
import TopNav from './TopNav.vue'
import WelcomeBar from './WelcomeBar.vue'
import BreadcrumbBar from './BreadcrumbBar.vue'

const auth = useAuthStore()
const sidebarCollapsed = ref(false)
const userRole = computed(() => auth.role)
const { printTitle, printRows } = usePrint()
const printTime = ref('')
function onBefore() { printTime.value = new Date().toLocaleString() }
window.addEventListener('beforeprint', onBefore)
onUnmounted(() => window.removeEventListener('beforeprint', onBefore))
</script>

<style scoped>
.app-root { height: 100vh; position: relative; }
.app-sidebar { background: linear-gradient(180deg,#0d2a6b,#153D97 50%,#108B96); transition: width .2s; overflow-x: hidden; flex-shrink: 0; box-shadow: 2px 0 20px rgba(0,0,0,.1); z-index: 10; }
.main-area { flex-direction: column; overflow: hidden; }
.top-bar { padding: 0; background: #fff; border-bottom: 1px solid #e2e8f0; z-index: 5; }
.print-area { display: none; position: absolute; inset: 0; background: #fff; z-index: 9999; }
.print-content { max-width: 700px; margin: 0 auto; padding: 40px 20px; }
.print-content h2 { font-size: 18px; color: #000; text-align: center; margin-bottom: 20px; }
.print-content table { width: 100%; border-collapse: collapse; }
.print-content td { padding: 8px 12px; border: 1px solid #ddd; font-size: 13px; }
.print-label { width: 120px; background: #f5f5f5; font-weight: 600; }
.print-value { color: #000; }
.print-footer { text-align: center; margin-top: 24px; font-size: 10px; color: #999; }
</style>
