<template>
  <div class="admin-home">
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>通知公告（10条）</span><el-button text type="primary" size="small">more</el-button></div>
        <div class="card-body"><div v-for="n in notices10" :key="n.id" class="n-row"><span :class="n.read?'read':'unread'">{{n.title}}</span><span class="ndate">{{n.date}}</span></div></div>
      </div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#B2151E"></span>待办提醒（20条）</span><el-button text type="primary" size="small">more</el-button></div>
        <div class="card-body"><div v-for="t in todos20" :key="t.id" class="n-row"><span :class="t.done?'read':'unread'">{{t.title}}</span><el-button v-if="!t.done" type="primary" size="small" round>办理</el-button><el-tag v-else type="success" size="small" round>已办</el-tag></div></div>
      </div>
    </div>

    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>在校生类别分布</span></div><div class="card-body chart-box">📊 学博120人 · 学硕680人 · 专硕520人 · 总计1320人<div class="fake-bar"><span style="width:9%" class="bar1">博</span><span style="width:52%" class="bar2">学硕</span><span style="width:39%" class="bar3">专硕</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#8b5cf6"></span>就读生情况</span></div><div class="card-body chart-box">📈 标准就读1080人 · 休学52人 · 延期毕业188人<div class="fake-bar"><span style="width:82%" class="bar2">标准</span><span style="width:4%" class="bar1">休</span><span style="width:14%" class="bar3">延毕</span></div></div></div>
    </div>

    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#f4ca91"></span>年级分布</span></div><div class="card-body chart-box">📊 2023级420人 · 2024级460人 · 2025级440人<div class="fake-bar"><span style="width:32%" class="bar2">2023</span><span style="width:35%" class="bar3">2024</span><span style="width:33%" class="bar1">2025</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>教师情况</span></div><div class="card-body chart-box">👨‍🏫 普通教师186人 · 硕导84人 · 硕博导36人 · 总计306人<div class="fake-bar"><span style="width:61%" class="bar1">普通</span><span style="width:27%" class="bar2">硕导</span><span style="width:12%" class="bar3">博导</span></div></div></div>
    </div>

    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>快捷入口</span></div>
      <div class="card-body"><div class="quick-grid"><el-button v-for="q in quickLinks" :key="q" round>{{q}}</el-button></div></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const notices10=ref(Array.from({length:10},(_,i)=>({id:i+1,title:`关于研究生培养方案修订通知(${i+1})`,read:i>4,date:'2026-06-'+(20-i)})))
const todos20=ref(Array.from({length:20},(_,i)=>({id:i+1,title:`待审批：研究生${['开题报告','中期考核','学位申请','学籍异动','奖学金'][i%5]}（${i+1}号）`,done:i>8})))
const quickLinks=['招生管理','学籍管理','培养方案','课程建设','成绩管理','学位管理','导师管理','科研管理','系统设置']
</script>

<style scoped>
.admin-home{display:flex;flex-direction:column;gap:14px;max-width:1500px}
.n-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px dashed #f1f5f9;font-size:13px;gap:10px}
.n-row:last-child{border-bottom:none}
.unread{font-weight:700;color:#0f172a;cursor:pointer;flex:1}
.read{color:#94a3b8;cursor:pointer;flex:1}
.ndate{color:#94a3b8;font-size:11px;flex-shrink:0}
.chart-box{padding:12px 0;font-size:13px;color:#475569;line-height:2}
.fake-bar{display:flex;height:24px;border-radius:12px;overflow:hidden;margin-top:8px;gap:2px}
.fake-bar span{display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:700;color:#fff}
.bar1{background:#108B96}.bar2{background:#153D97}.bar3{background:#f4ca91;color:#1e293b!important}
.quick-grid{display:flex;flex-wrap:wrap;gap:8px}
</style>
