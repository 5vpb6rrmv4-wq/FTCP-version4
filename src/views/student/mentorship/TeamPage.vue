<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>导学团队</span></div>
      <div class="card-body">
        <el-table :data="items" size="small" stripe>
          <el-table-column prop="name" label="姓名" width="80"/>
          <el-table-column prop="id" label="学号" width="120"/>
          <el-table-column prop="grade" label="年级" width="60"/>
          <el-table-column prop="role" label="角色" width="100"><template #default><el-tag size="small" round>团队成员</el-tag></template></el-table-column>
          <el-table-column prop="research" label="研究方向" min-width="200"/>
          <el-table-column label="操作" width="80"><template #default><el-button text type="primary" size="small">查看</el-button></template></el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const items=ref([{name:'张三',id:'2023301001',grade:'2023',research:'深度学习、图像识别'},{name:'李四',id:'2023301002',grade:'2023',research:'自然语言处理'},{name:'王五',id:'2024301001',grade:'2024',research:'知识图谱'}])
</script>
<style scoped>.page-section{max-width:1100px}</style>
