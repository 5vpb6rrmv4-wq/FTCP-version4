<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>毕业学位</span></div>
      <div class="card-body">
        <el-tabs type="border-card">
          <el-tab-pane label="学位申请"><el-button type="primary" size="small" round>发起申请</el-button><el-table :data="apps" size="small" stripe><el-table-column prop="type" label="申请学位" width="140"/><el-table-column prop="date" label="日期" width="120"/><el-table-column prop="status" label="状态" width="100"><template #default><el-tag type="warning" size="small" round>未申请</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="注册信息核对"><el-descriptions :column="2" border><el-descriptions-item label="姓名">张三</el-descriptions-item><el-descriptions-item label="学号">2023301001</el-descriptions-item><el-descriptions-item label="专业">计算机科学与技术</el-descriptions-item><el-descriptions-item label="授予学位">工学硕士</el-descriptions-item></el-descriptions><el-button type="primary" round style="margin-top:12px">确认信息</el-button></el-tab-pane>
          <el-tab-pane label="学位授予核对"><el-empty description="尚未生成" :image-size="60"/></el-tab-pane>
          <el-tab-pane label="毕业证书"><el-empty description="尚未生成" :image-size="60"/></el-tab-pane>
          <el-tab-pane label="学位证书"><el-empty description="尚未生成" :image-size="60"/></el-tab-pane>
          <el-tab-pane label="就业登记"><el-button type="primary" size="small" round>登记就业</el-button><el-table :data="jobs" size="small" stripe><el-table-column prop="company" label="单位" min-width="200"/><el-table-column prop="position" label="职位" width="140"/><el-table-column prop="type" label="类型" width="100"><template #default><el-tag size="small" round>校招</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="提前毕业"><el-button type="primary" size="small" round>申请提前毕业</el-button><el-empty description="暂无记录" :image-size="40"/></el-tab-pane>
          <el-tab-pane label="延期毕业"><el-button type="primary" size="small" round>申请延期毕业</el-button><el-empty description="暂无记录" :image-size="40"/></el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">import {ref} from 'vue';const apps=ref([{type:'工学硕士',date:'',status:'未申请'}]);const jobs=ref([])</script>
<style scoped>.page-section{max-width:1000px}</style>
