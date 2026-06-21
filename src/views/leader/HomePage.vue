<template>
  <div class="leader-home">
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>通知公告（4条）</span><el-button text type="primary" size="small">more</el-button></div><div class="card-body"><div v-for="n in notices" :key="n.id" class="n-row"><span class="unread">{{n.title}}</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#B2151E"></span>待办提醒（4条）</span><el-button text type="primary" size="small">more</el-button></div><div class="card-body"><div v-for="t in todos" :key="t.id" class="n-row"><span class="unread">{{t.title}}</span><el-button type="primary" size="small" round>办理</el-button></div></div></div>
    </div>

    <div class="card-grid-3">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>在校生</span></div><div class="card-body kpi"><span class="kpi-num">1,320</span><span class="kpi-sub">学博120 + 学硕680 + 专硕520</span></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#8b5cf6"></span>教师</span></div><div class="card-body kpi"><span class="kpi-num">306</span><span class="kpi-sub">普通186 + 硕导84 + 博导36</span></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#f4ca91"></span>年度毕业</span></div><div class="card-body kpi"><span class="kpi-num">398</span><span class="kpi-sub">硕士362 + 博士36</span></div></div>
    </div>

    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>一级菜单导航</span></div>
      <div class="card-body"><div class="menu-grid"><el-tag v-for="m in menus" :key="m" size="large" round effect="plain" class="menu-chip">{{m}}</el-tag></div></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const notices=ref([{id:1,title:'教育部关于研究生教育改革指导意见'},{id:2,title:'2026年学位授权点合格评估通知'},{id:3,title:'全国研究生教育质量报告发布'},{id:4,title:'省级重点学科建设中期检查'}])
const todos=ref([{id:1,title:'学科建设经费审批（3项待批）'},{id:2,title:'研究生招生计划审核'},{id:3,title:'学位评定委员会表决事项'},{id:4,title:'导师遴选结果确认'}])
const menus=['招生','学生','研工','培养','督导','成绩','毕业','学位','导师','科研','导学','学科','系统','密码','项目','数据']
</script>

<style scoped>
.leader-home{display:flex;flex-direction:column;gap:14px;max-width:1500px}
.n-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px dashed #f1f5f9;font-size:13px}
.n-row:last-child{border-bottom:none}
.unread{font-weight:700;color:#0f172a;cursor:pointer;flex:1}
.kpi{text-align:center;padding:16px 0}
.kpi-num{display:block;font-size:36px;font-weight:800;color:#153D97}
.kpi-sub{font-size:12px;color:#64748b;margin-top:4px}
.menu-grid{display:flex;flex-wrap:wrap;gap:10px}
.menu-chip{cursor:pointer;font-size:13px!important}
.menu-chip:hover{background:#eff6ff!important;border-color:#153D97!important}
</style>
