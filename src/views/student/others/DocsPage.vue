<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>证件扫描</span></div>
      <div class="card-body"><el-table :data="docsList" size="small" stripe><el-table-column type="index" label="#" width="50"/><el-table-column prop="name" label="证件名称" min-width="180"/><el-table-column prop="type" label="类型" width="130"/><el-table-column label="上传状态" width="100"><template #default="{row}"><el-tag :type="row.up?'success':'warning'" size="small" round>{{row.up?'已上传':'待上传'}}</el-tag></template></el-table-column><el-table-column label="审核" width="90"><template #default="{row}"><el-tag :type="row.ok?'success':'info'" size="small" round>{{row.ok?'已审核':'待审核'}}</el-tag></template></el-table-column><el-table-column label="操作" width="120"><template #default="{row}"><el-button v-if="!row.up" type="primary" size="small" round>上传</el-button><el-button v-else text type="primary" size="small">查看</el-button></template></el-table-column></el-table></div>
    </div>
  </div>
</template>
<script setup lang="ts">import {ref} from 'vue';const docsList=ref([{name:'本科毕业证书',type:'学历证书',up:true,ok:true},{name:'学士学位证书',type:'学位证书',up:true,ok:true},{name:'身份证（正反面）',type:'身份证明',up:true,ok:true},{name:'录取通知书',type:'录取材料',up:true,ok:false},{name:'政审表',type:'审核材料',up:false,ok:false}])</script>
<style scoped>.page-section{max-width:1000px}</style>
