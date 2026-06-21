<template>
<div class="page-section"><div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>学位论文</span></div><div class="card-body"><el-tabs type="border-card" tab-position="left">
<el-tab-pane v-for="s in stages" :key="s.key" :label="s.label">
  <div v-if="s.done" style="min-height:200px"><el-descriptions :column="2" border size="small"><el-descriptions-item v-for="f in s.info" :key="f.key" :label="f.label">{{s.data[f.key]||'-'}}</el-descriptions-item></el-descriptions><el-button type="primary" size="small" round style="margin-top:12px" @click="dlg.row=s.data;dlg.title=s.label;dlg.show=true;dlg.mode='view'">查看详情</el-button><el-button type="success" size="small" round style="margin-top:12px;margin-left:8px" @click="dlg.row=s.data;dlg.title=s.label;dlg.show=true;dlg.mode='print'">打印</el-button></div>
  <el-empty v-else :description="s.empty||'待安排'" :image-size="80"><el-button v-if="s.action" type="primary" round>{{s.action}}</el-button></el-empty>
</el-tab-pane>
</el-tabs>

<el-dialog v-model="dlg.show" :title="dlg.title" width="600px">
  <template v-if="dlg.mode==='view'||dlg.mode==='print'"><div :style="dlg.mode==='print'?'text-align:center':''"><h3 v-if="dlg.mode==='print'" style="color:#153D97;margin-bottom:16px">{{dlg.title}}</h3><table style="width:100%;border-collapse:collapse;font-size:13px"><tr v-for="(v,k) in dlg.row" :key="k" style="border-bottom:1px solid #f0f0f0"><td style="padding:8px 12px;font-weight:600;width:120px;background:#f8fafc">{{k}}</td><td style="padding:8px 12px">{{v||'-'}}</td></tr></table><p v-if="dlg.mode==='print'" style="margin-top:20px;color:#94a3b8;font-size:11px">{{new Date().toLocaleString()}}</p></div></template>
  <template #footer><el-button v-if="dlg.mode==='print'" type="primary" @click="window.print()">打印</el-button><el-button @click="dlg.show=false">关闭</el-button></template>
</el-dialog>
</div></div></div></template>
<script setup lang="ts">
import {ref,reactive} from 'vue'
const dlg=reactive({show:false,title:'',mode:'view',row:{} as any})
const stages=ref([
{key:'proposal',label:'开题报告',done:true,empty:'待安排',info:[{key:'title',label:'论文题目'},{key:'date',label:'开题日期'},{key:'result',label:'开题结果'},{key:'experts',label:'评审专家'}],data:{title:'基于深度学习的图像识别算法研究与优化',date:'2025-03-20',result:'通过',experts:'王教授、赵教授、周教授'}},
{key:'midterm',label:'中期报告',done:true,info:[{key:'title',label:'论文题目'},{key:'date',label:'检查日期'},{key:'result',label:'结果'},{key:'rate',label:'完成度'}],data:{title:'基于深度学习的图像识别算法研究与优化',date:'2026-01-15',result:'通过',rate:'60%'}},
{key:'review',label:'评审报名',done:false,empty:'报名开放: 2026年9月1日-15日'},
{key:'reviewMgt',label:'评审管理',done:false,empty:'暂无评审记录'},
{key:'preDefense',label:'预答辩',done:false,empty:'待安排',action:'提交预答辩申请'},
{key:'defense',label:'答辩管理',done:false,empty:'待安排'},
{key:'excellent',label:'优秀论文申请',done:false,empty:'暂无记录',action:'申请优秀论文'},
{key:'archive',label:'论文存档',done:false,empty:'答辩通过后上传',action:'上传论文'},
])
</script>
<style scoped>.page-section{max-width:1100px}</style>
