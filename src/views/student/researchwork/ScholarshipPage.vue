<template>
<div class="page-section"><div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>奖助学金</span></div><div class="card-body"><el-tabs type="border-card">
<el-tab-pane label="奖学金申请"><el-button type="primary" size="small" round style="margin-bottom:12px" @click="openAdd">新增申请</el-button>
<el-table :data="apps" size="small" stripe empty-text="暂无数据"><el-table-column prop="name" label="名称" min-width="160"/><el-table-column prop="level" label="级别" width="90"/><el-table-column prop="date" label="日期" width="110"/><el-table-column label="状态" width="90"><template #default="{row}"><el-tag :type="row.status==='已通过'?'success':'warning'" size="small" round>{{row.status}}</el-tag></template></el-table-column>
<el-table-column label="操作" width="260" fixed="right"><template #default="{row}"><span class="btn-row"><el-button text type="primary" size="small" @click="viewDetail(row)">详情</el-button><el-button text type="primary" size="small" @click="editRow(row)">编辑</el-button><el-button text type="danger" size="small" @click="deleteRow(row)">删除</el-button><el-button text type="success" size="small" @click="handlePrint(row)">打印</el-button></span></template></el-table-column></el-table></el-tab-pane>
<el-tab-pane label="个人评优"><el-button type="primary" size="small" round style="margin-bottom:12px" @click="openAwardAdd">新增申请</el-button><el-table :data="awards" size="small" stripe empty-text="暂无数据"><el-table-column prop="name" label="名称" min-width="160"/><el-table-column prop="level" label="级别" width="90"/><el-table-column prop="date" label="日期" width="110"/><el-table-column prop="status" label="状态" width="90"><template #default="{row}"><el-tag :type="row.status==='已通过'?'success':'warning'" size="small" round>{{row.status}}</el-tag></template></el-table-column><el-table-column label="操作" width="210" fixed="right"><template #default="{row}"><span class="btn-row"><el-button text type="primary" size="small" @click="viewDetail(row)">详情</el-button><el-button text type="danger" size="small" @click="awards=awards.filter(a=>a.id!==row.id)">删除</el-button><el-button text type="success" size="small" @click="handlePrint(row)">打印</el-button></span></template></el-table-column></el-table></el-tab-pane>
<el-tab-pane label="班级评优"><el-table :data="classAwards" size="small" stripe empty-text="暂无数据"><el-table-column prop="name" label="名称" min-width="160"/><el-table-column prop="className" label="班级" width="140"/><el-table-column prop="date" label="日期" width="110"/><el-table-column label="操作" width="140"><template #default><span class="btn-row"><el-button text type="primary" size="small">详情</el-button><el-button text type="success" size="small">打印</el-button></span></template></el-table-column></el-table></el-tab-pane>
<el-tab-pane label="证明打印"><el-table :data="certs" size="small" stripe empty-text="暂无记录"><el-table-column prop="name" label="名称" min-width="160"/><el-table-column prop="year" label="年度" width="80"/><el-table-column label="操作" width="140"><template #default="{row}"><span class="btn-row"><el-button type="primary" size="small" round @click="handlePrint({...row,label:'奖学金证明'})">打印证明</el-button><el-button text type="danger" size="small" @click="certs=certs.filter(c=>c.id!==row.id)">删除</el-button></span></template></el-table-column></el-table></el-tab-pane>
</el-tabs>

<!-- Detail/Edit Dialog -->
<el-dialog v-model="dlg.show" :title="dlg.title" width="580px">
  <el-descriptions v-if="dlg.mode==='view'" :column="2" border size="small"><el-descriptions-item v-for="f in fields" :key="f.key" :label="f.label"><span>{{dlg.row[f.key]||'-'}}</span></el-descriptions-item></el-descriptions>
  <el-form v-else :model="dlg.row" label-width="90px"><el-form-item v-for="f in fields" :key="f.key" :label="f.label"><el-input v-model="dlg.row[f.key]"/></el-form-item></el-form>
  <template #footer><span v-if="dlg.mode==='view'"><el-button type="warning" @click="dlg.mode='edit'">编辑</el-button><el-button type="success" @click="handlePrint(dlg.row)">打印</el-button><el-button @click="dlg.show=false">关闭</el-button></span><span v-else><el-button @click="dlg.mode='view'">取消</el-button><el-button type="primary" @click="saveEdit">保存</el-button></span></template>
</el-dialog>
</div></div></div></template>
<script setup lang="ts">
import {ref,reactive} from 'vue';import {ElMessage,ElMessageBox} from 'element-plus';import {usePrint} from '@/composables/usePrint'
const {doPrint}=usePrint()
const apps=ref([{id:1,name:'国家奖学金',level:'国家级',date:'2026-03-01',status:'审核中',amount:'20000元',dept:'教育部'},{id:2,name:'学业奖学金一等奖',level:'校级',date:'2025-10-15',status:'已通过',amount:'8000元',dept:'研究生院'}])
const awards=ref([{id:1,name:'优秀研究生',level:'校级',date:'2026-04-10',status:'已通过',dept:'研究生院'}])
const classAwards=ref([{id:1,name:'优秀班集体',className:'2023级计算机硕士班',date:'2026-04-20',status:'已通过'}])
const certs=ref([{id:1,name:'学业奖学金奖',year:'2025'},{id:2,name:'国家奖学金',year:'2026'}])
const fields=[{key:'name',label:'名称'},{key:'level',label:'级别'},{key:'date',label:'日期'},{key:'status',label:'状态'},{key:'amount',label:'金额'},{key:'dept',label:'主管部门'}]
const dlg=reactive({show:false,title:'',mode:'view',row:{} as any})
function viewDetail(row:any){dlg.row={...row};dlg.title='详情';dlg.mode='view';dlg.show=true}
function editRow(row:any){dlg.row={...row};dlg.title='编辑';dlg.mode='edit';dlg.show=true}
function openAdd(){dlg.row={id:Date.now(),name:'',level:'校级',date:new Date().toISOString().split('T')[0],status:'审核中',amount:'',dept:''};dlg.title='新增奖学金申请';dlg.mode='edit';dlg.show=true}
function openAwardAdd(){const a={id:Date.now(),name:'',level:'校级',date:new Date().toISOString().split('T')[0],status:'审核中',dept:''};awards.value.unshift(a)}
function saveEdit(){const idx=apps.value.findIndex(a=>a.id===dlg.row.id);if(idx>=0)apps.value[idx]=dlg.row;else apps.value.unshift(dlg.row);dlg.show=false;ElMessage.success('保存成功')}
function deleteRow(row:any){ElMessageBox.confirm('确认删除该申请？','确认',{type:'warning'}).then(()=>{apps.value=apps.value.filter(a=>a.id!==row.id);ElMessage.success('已删除')})}
function handlePrint(row:any){doPrint('奖学金信息',row,{name:'名称',level:'级别',date:'日期',status:'状态',amount:'金额',dept:'主管部门'})}
</script>
<style scoped>.page-section{max-width:1200px}.btn-row{display:inline-flex;align-items:center;gap:1px;white-space:nowrap}</style>
