<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>论文成果</span></div>
      <div class="card-body">
        <el-tabs type="border-card">
          <el-tab-pane label="发表论文"><el-button type="primary" size="small" round style="margin-bottom:12px">登记论文</el-button><el-table :data="papers" size="small" stripe><el-table-column prop="title" label="标题" min-width="260"/><el-table-column prop="journal" label="期刊/会议" min-width="180"/><el-table-column prop="level" label="级别" width="100"><template #default><el-tag type="danger" size="small" round>SCI一区</el-tag></template></el-table-column><el-table-column prop="date" label="日期" width="110"/></el-table></el-tab-pane>
          <el-tab-pane label="科研成果"><el-button type="primary" size="small" round style="margin-bottom:12px">登记成果</el-button><el-table :data="results" size="small" stripe><el-table-column prop="name" label="名称" min-width="240"/><el-table-column prop="cat" label="类别" width="120"><template #default><el-tag size="small" round>软件著作权</el-tag></template></el-table-column><el-table-column prop="date" label="日期" width="110"/></el-table></el-tab-pane>
          <el-tab-pane label="发明专利"><el-button type="primary" size="small" round style="margin-bottom:12px">登记专利</el-button><el-table :data="patents" size="small" stripe><el-table-column prop="name" label="名称" min-width="260"/><el-table-column prop="no" label="专利号" min-width="160"/><el-table-column prop="date" label="日期" width="110"/><el-table-column prop="status" label="状态" width="90"><template #default><el-tag type="success" size="small" round>已授权</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="毕业达标查询"><el-descriptions :column="2" border><el-descriptions-item label="论文要求">1篇SCI/EI</el-descriptions-item><el-descriptions-item label="已发表">1篇</el-descriptions-item><el-descriptions-item label="专利要求">1项</el-descriptions-item><el-descriptions-item label="已授权">1项</el-descriptions-item></el-descriptions><el-tag type="success" size="large" round style="margin-top:12px">已达标</el-tag></el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">import {ref} from 'vue'
const papers=ref([{title:'基于深度学习的图像识别算法研究',journal:'IEEE Trans. Image Processing',level:'SCI一区',date:'2026-03-15'}])
const results=ref([{name:'智能推荐算法优化系统',cat:'软件著作权',date:'2025-12-10'}])
const patents=ref([{name:'一种基于注意力机制的图像分类方法',no:'CN202310012345.6',date:'2025-08-15',status:'已授权'}])
</script>
<style scoped>.page-section{max-width:1100px}</style>
