<template>
<div class="page-section"><div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>数据统计</span><el-button type="primary" size="small" round @click="openAdd">新增</el-button></div><div class="card-body"><el-table :data="rows" size="small" stripe empty-text="暂无数据"><el-table-column prop="metric" label="指标" width="180"/><el-table-column prop="value" label="数值" width="120"/><el-table-column prop="unit" label="单位" width="80"/><el-table-column prop="note" label="备注" min-width="200"/><el-table-column label="操作" width="260" fixed="right"><template #default="scope"><span class="btn-row"><el-button text type="primary" size="small" @click="viewDetail(scope.row)">详情</el-button><el-button text type="warning" size="small" @click="editRow(scope.row)">编辑</el-button><el-button text type="danger" size="small" @click="deleteRow(scope.row)">删除</el-button><el-button text type="success" size="small" @click="doPrint(scope.row)">打印</el-button></span></template></el-table-column></el-table>
<el-dialog v-model="dlg.show" :title="dlg.title" width="620px"><el-descriptions v-if="dlg.mode==='view'" :column="2" border size="small"><el-descriptions-item v-for="f in dlgFields" :key="f.key" :label="f.label"><span>{{dlg.row[f.key]||'-'}}</span></el-descriptions-item></el-descriptions><el-form v-else :model="dlg.row" label-width="90px"><el-form-item v-for="f in dlgFields" :key="f.key" :label="f.label"><el-input v-model="dlg.row[f.key]"/></el-form-item></el-form><template #footer><span v-if="dlg.mode==='view'"><el-button type="warning" @click="dlg.mode='edit'">编辑</el-button><el-button type="success" @click="doPrint(dlg.row)">打印</el-button><el-button @click="dlg.show=false">关闭</el-button></span><span v-else><el-button @click="dlg.mode='view'">取消</el-button><el-button type="primary" @click="saveEdit">保存</el-button></span></template></el-dialog></div></div></div></template>
<script setup lang="ts">
import {ref,reactive} from 'vue';import {ElMessage,ElMessageBox} from 'element-plus';import {usePrint} from '@/composables/usePrint'
const {doPrint}=usePrint()
const dlgFields=[{key:"metric",label:"指标"},{key:"value",label:"数值"},{key:"unit",label:"单位"},{key:"note",label:"备注"}];
const rows=ref([{metric:"在籍研究生总数",value:"1320",unit:"人",note:"学博120+学硕680+专硕520"},
{metric:"按期毕业率",value:"92.5％",unit:"-",note:"2025年度"},
{metric:"科研产出指数",value:"78.3",unit:"分",note:"论文+专利+项目"},
{metric:"教师总数",value:"306",unit:"人",note:"186+84+36"}]);
const dlg=reactive({show:false,title:'',mode:'view',row:{} as any})
function viewDetail(row:any){dlg.row={...row};dlg.title='详情';dlg.mode='view';dlg.show=true}
function editRow(row:any){dlg.row={...row};dlg.title='编辑';dlg.mode='edit';dlg.show=true}
function openAdd(){dlg.row={id:Date.now(),metric:"",value:"",unit:"",note:""};dlg.title='新增';dlg.mode='edit';dlg.show=true}
function saveEdit(){const idx=rows.value.findIndex((r:any)=>r.id===dlg.row.id);if(idx>=0)rows.value[idx]=dlg.row;else rows.value.unshift(dlg.row);dlg.show=false;ElMessage.success('保存成功')}
function deleteRow(row:any){ElMessageBox.confirm('确认删除？','确认',{type:'warning'}).then(()=>{rows.value=rows.value.filter((r:any)=>r.id!==row.id);ElMessage.success('已删除')})}
</script>
<style scoped>.page-section{max-width:1200px}.btn-row{display:inline-flex;align-items:center;gap:1px;white-space:nowrap}</style>