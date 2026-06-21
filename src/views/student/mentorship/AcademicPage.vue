<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>学风建设</span></div>
      <div class="card-body">
        <el-table :data="items" size="small" stripe>
          <el-table-column prop="name" label="名称" min-width="260"/>
          <el-table-column prop="date" label="日期" width="120"/>
          <el-table-column label="操作" width="100"><template #default><el-button text type="primary" size="small">查看</el-button></template></el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const items=ref([{name:'示例数据一',date:'2026-06-15'},{name:'示例数据二',date:'2026-06-10'}])
</script>
<style scoped>.page-section{max-width:1000px}</style>
