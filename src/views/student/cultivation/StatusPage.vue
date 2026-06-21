<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>学籍异动</span><el-button type="primary" size="small" round>提交申请</el-button></div>
      <div class="card-body"><el-table :data="apps" size="small" stripe><el-table-column prop="type" label="类型" width="100"><template #default="{row}"><el-tag size="small" round>{{row.type}}</el-tag></template></el-table-column><el-table-column prop="reason" label="原因" min-width="200"/><el-table-column prop="date" label="日期" width="110"/><el-table-column prop="status" label="状态" width="90"><template #default="{row}"><el-tag :type="row.status==='已通过'?'success':'warning'" size="small" round>{{row.status}}</el-tag></template></el-table-column></el-table></div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const apps=ref([{type:'延期毕业',reason:'科研项目需额外时间完成',date:'2026-05-20',status:'审核中'}])
</script>
<style scoped>.page-section{max-width:800px}</style>
