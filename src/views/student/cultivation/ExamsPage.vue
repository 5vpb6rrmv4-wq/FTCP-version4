<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>考级管理</span></div>
      <div class="card-body">
        <el-tabs type="border-card">
          <el-tab-pane label="入学前外语成绩"><el-descriptions :column="2" border><el-descriptions-item label="考试类型">CET-6</el-descriptions-item><el-descriptions-item label="成绩">568分</el-descriptions-item><el-descriptions-item label="日期">2022-12-10</el-descriptions-item><el-descriptions-item label="证书编号">CET62203201001001</el-descriptions-item></el-descriptions></el-tab-pane>
          <el-tab-pane label="外语考试成绩"><el-table :data="scores" size="small" stripe><el-table-column prop="type" label="类型" width="150"/><el-table-column prop="score" label="成绩" width="80"/><el-table-column prop="date" label="日期" width="120"/><el-table-column label="达标" width="80"><template #default="{row}"><el-tag :type="row.pass?'success':'danger'" size="small" round>{{row.pass?'已达标':'未达标'}}</el-tag></template></el-table-column></el-table></el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const scores=ref([{type:'CET-6',score:568,date:'2022-12-10',pass:true},{type:'学位英语',score:85,date:'2024-06-15',pass:true}])
</script>
<style scoped>.page-section{max-width:800px}</style>
