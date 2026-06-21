<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>通知公告</span></div>
      <div class="card-body"><el-table :data="allNotices" size="small" stripe><el-table-column prop="title" label="标题" min-width="300"/><el-table-column prop="date" label="发布日期" width="120"/><el-table-column prop="dept" label="发布单位" width="140"/><el-table-column label="操作" width="80"><template #default><el-button text type="primary" size="small">查看</el-button></template></el-table-column></el-table><el-pagination style="margin-top:16px;justify-content:center" background layout="prev,pager,next" :total="allNotices.length" :page-size="10"/></div>
    </div>
  </div>
</template>
<script setup lang="ts">import {ref} from 'vue';const allNotices=ref([{title:'关于2026年春学期选课通知',date:'2026-06-15',dept:'研究生院'},{title:'学术论坛报名通知',date:'2026-06-10',dept:'科技处'},{title:'学位论文中期检查安排',date:'2026-06-05',dept:'学位办'},{title:'奖助学金评审结果公示',date:'2026-06-01',dept:'研究生院'},{title:'图书馆数据库培训',date:'2026-05-28',dept:'图书馆'},{title:'暑期社会实践报名',date:'2026-05-25',dept:'研工部'}])</script>
<style scoped>.page-section{max-width:1000px}</style>
