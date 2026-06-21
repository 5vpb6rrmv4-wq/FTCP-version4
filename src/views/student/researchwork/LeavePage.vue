<template>
<div class="page-section"><div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>日常管理</span><el-button type="primary" size="small" round @click="openAdd">请假申请</el-button></div><div class="card-body">
<el-table :data="leaves" size="small" stripe empty-text="暂无记录"><el-table-column prop="type" label="类型" width="70"/><el-table-column prop="reason" label="事由" min-width="180"/><el-table-column prop="start" label="开始" width="110"/><el-table-column prop="end" label="结束" width="110"/><el-table-column prop="days" label="天数" width="50"/><el-table-column label="状态" width="90"><template #default="{row}"><el-tag :type="row.status==='已批准'?'success':row.status==='审核中'?'warning':'info'" size="small" round>{{row.status}}</el-tag></template></el-table-column>
<el-table-column label="操作" width="260" fixed="right"><template #default="{row}"><span class="btn-row"><el-button text type="primary" size="small" @click="viewDetail(row)">详情</el-button><el-button v-if="row.status==='审核中'" text type="warning" size="small" @click="editRow(row)">修改</el-button><el-button v-if="row.status==='审核中'" text type="danger" size="small" @click="leaves=leaves.filter(l=>l.id!==row.id);$message.success('已删除')">删除</el-button><el-button v-if="row.status==='审核中'" text type="warning" size="small" @click="row.status='已撤销';$message.success('已撤销')">撤销</el-button><el-button v-if="row.status==='已批准'" text type="success" size="small" @click="row.status='已销假';$message.success('销假成功')">销假</el-button><el-button text type="success" size="small" @click="handlePrint(row)">打印</el-button></span></template></el-table-column>
</el-table>

<el-dialog v-model="dlg.show" :title="dlg.title" width="580px">
  <el-descriptions v-if="dlg.mode==='view'" :column="2" border size="small"><el-descriptions-item v-for="f in leaveFields" :key="f.key" :label="f.label"><span>{{dlg.row[f.key]||'-'}}</span></el-descriptions-item></el-descriptions>
  <el-form v-else :model="dlg.row" label-width="90px"><el-form-item label="请假类型"><el-select v-model="dlg.row.type" style="width:100%"><el-option label="事假" value="事假"/><el-option label="病假" value="病假"/><el-option label="公假" value="公假"/></el-select></el-form-item><el-form-item label="开始日期"><el-date-picker v-model="dlg.row.start" type="date" style="width:100%"/></el-form-item><el-form-item label="结束日期"><el-date-picker v-model="dlg.row.end" type="date" style="width:100%"/></el-form-item><el-form-item label="请假事由"><el-input v-model="dlg.row.reason" type="textarea" :rows="3"/></el-form-item></el-form>
  <template #footer><span v-if="dlg.mode==='view'"><el-button type="warning" @click="dlg.mode='edit'">编辑</el-button><el-button type="success" @click="handlePrint(dlg.row)">打印</el-button><el-button @click="dlg.show=false">关闭</el-button></span><span v-else><el-button @click="dlg.mode='view'">取消</el-button><el-button type="primary" @click="saveEdit">保存</el-button></span></template></el-dialog>
</div></div></div></template>
<script setup lang="ts">
import {ref,reactive} from 'vue';import {ElMessage as $m} from 'element-plus';import {usePrint} from '@/composables/usePrint'
const {doPrint}=usePrint()
const leaves=ref([{id:1,type:'事假',reason:'回家探亲',start:'2026-05-01',end:'2026-05-05',days:5,status:'已批准',approver:'李教授'},{id:2,type:'病假',reason:'感冒发烧',start:'2026-06-10',end:'2026-06-11',days:2,status:'审核中',approver:'待审批'}])
const leaveFields=[{key:'type',label:'类型'},{key:'reason',label:'事由'},{key:'start',label:'开始日期'},{key:'end',label:'结束日期'},{key:'days',label:'天数'},{key:'status',label:'状态'},{key:'approver',label:'审批人'}]
const dlg=reactive({show:false,title:'',mode:'view',row:{} as any})
function viewDetail(row:any){dlg.row={...row};dlg.title='详情';dlg.mode='view';dlg.show=true}
function editRow(row:any){dlg.row={...row};dlg.title='修改假条';dlg.mode='edit';dlg.show=true}
function openAdd(){dlg.row={id:Date.now(),type:'事假',reason:'',start:'',end:'',days:0,status:'审核中',approver:'待审批'};dlg.title='请假申请';dlg.mode='edit';dlg.show=true}
function saveEdit(){const idx=leaves.value.findIndex(l=>l.id===dlg.row.id);if(idx>=0)leaves.value[idx]=dlg.row;else leaves.value.unshift(dlg.row);dlg.show=false;$m.success('保存成功')}
function handlePrint(row:any){doPrint('请假单',row,{type:'类型',reason:'事由',start:'开始日期',end:'结束日期',days:'天数',status:'状态',approver:'审批人'})}
</script>
<style scoped>.page-section{max-width:1200px}.btn-row{display:inline-flex;align-items:center;gap:1px;white-space:nowrap}</style>
