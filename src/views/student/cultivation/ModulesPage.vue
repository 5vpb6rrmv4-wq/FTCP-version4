<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>必修环节</span></div>
      <div class="card-body">
        <el-tabs type="border-card">
          <el-tab-pane label="文献阅读"><el-button type="primary" size="small" round style="margin-bottom:12px">录入</el-button><el-table :data="d1" size="small" stripe><el-table-column prop="title" label="文献名称" min-width="240"/><el-table-column prop="date" label="日期" width="110"/><el-table-column label="状态" width="90"><template #default><el-tag type="success" size="small" round>已完成</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="社会实践"><el-table :data="d2" size="small" stripe><el-table-column prop="title" label="实践名称" min-width="200"/><el-table-column prop="loc" label="地点" width="120"/><el-table-column prop="date" label="日期" width="110"/></el-table></el-tab-pane>
          <el-tab-pane label="教学实践"><el-table :data="d3" size="small" stripe><el-table-column prop="title" label="实践名称" min-width="180"/><el-table-column prop="course" label="课程" width="130"/><el-table-column prop="date" label="日期" width="110"/></el-table></el-tab-pane>
          <el-tab-pane label="学术报告"><el-table :data="d4" size="small" stripe><el-table-column prop="title" label="报告题目" min-width="260"/><el-table-column prop="date" label="日期" width="110"/></el-table></el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const d1=ref([{title:'深度学习综述文献阅读报告',date:'2026-03-10'}])
const d2=ref([{title:'暑期社会调研实践',loc:'重庆市',date:'2025-08-20'}])
const d3=ref([{title:'本科生助教教学实践',course:'程序设计基础',date:'2026-01-15'}])
const d4=ref([{title:'人工智能前沿技术学术报告',date:'2026-04-20'}])
</script>
<style scoped>.page-section{max-width:1000px}</style>
