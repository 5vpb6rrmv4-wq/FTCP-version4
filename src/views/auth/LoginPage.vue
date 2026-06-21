<template>
  <div class="login-page">
    <div class="login-card">
      <div class="login-header">
        <el-icon :size="48" color="#153D97"><School /></el-icon>
        <h1>人才选拔全流程平台</h1>
        <p>Full-cycle Talent Selection Platform</p>
      </div>
      <el-form :model="form" size="large" class="login-form" @submit.prevent="handleLogin">
        <el-form-item><el-input v-model="form.username" placeholder="学号/工号" prefix-icon="User" /></el-form-item>
        <el-form-item><el-input v-model="form.password" type="password" placeholder="密码" prefix-icon="Lock" show-password /></el-form-item>
        <el-form-item>
          <el-radio-group v-model="form.role" class="role-group">
            <el-radio-button value="student">学生</el-radio-button>
            <el-radio-button value="teacher">教师</el-radio-button>
            <el-radio-button value="admin">管理员</el-radio-button>
            <el-radio-button value="leader">领导</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item><el-input v-model="form.captcha" placeholder="验证码" prefix-icon="Key"><template #append>ABCD</template></el-input></el-form-item>
        <el-form-item><el-button type="primary" native-type="submit" round class="login-btn">登 录</el-button></el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const auth = useAuthStore()
const form = reactive({ username: '2023301001', password: '123456', role: 'student' as const, captcha: '' })

async function handleLogin() {
  if (!form.username || !form.password) { ElMessage.warning('请输入账号密码'); return }
  await auth.login(form.username, form.password, form.role)
  ElMessage.success('登录成功')
  const homeMap = { student: '/student/home', teacher: '/teacher/home', admin: '/admin/home', leader: '/leader/home' }
  router.push(homeMap[form.role])
}
</script>

<style scoped>
.login-page{display:flex;align-items:center;justify-content:center;height:100vh;background:linear-gradient(135deg,#0d2a6b,#153D97 50%,#108B96)}
.login-card{background:#fff;border-radius:20px;padding:48px 40px 36px;width:420px;box-shadow:0 20px 60px rgba(0,0,0,.15);text-align:center}
.login-header{margin-bottom:28px}
.login-header h1{font-size:22px;color:#153D97;margin-top:12px}
.login-header p{font-size:12px;color:#64748b;margin-top:4px}
.role-group{width:100%}
.role-group .el-radio-button{flex:1}
.role-group .el-radio-button__inner{width:100%}
.login-btn{width:100%}
</style>
