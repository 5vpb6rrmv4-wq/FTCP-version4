<template>
  <el-dialog v-model="visible" :title="title" width="650px" @close="$emit('close')">
    <el-descriptions v-if="mode==='view'" :column="2" border size="small">
      <el-descriptions-item v-for="f in fields" :key="f.key" :label="f.label" :span="f.span||1">
        <span v-if="!f.type || f.type==='text'">{{ data[f.key] || '-' }}</span>
        <el-tag v-else-if="f.type==='tag'" :type="data[f.key]===f.tagOk?'success':'warning'" size="small" round>{{ data[f.key] || '-' }}</el-tag>
        <el-tag v-else-if="f.type==='status'" :type="statusType(data[f.key])" size="small" round>{{ data[f.key] || '-' }}</el-tag>
      </el-descriptions-item>
    </el-descriptions>

    <el-form v-else-if="mode==='edit'" :model="editData" label-width="90px" size="default">
      <el-form-item v-for="f in fields" :key="f.key" :label="f.label" v-show="f.editable!==false">
        <el-input v-if="!f.editType || f.editType==='input'" v-model="editData[f.key]" />
        <el-input v-else-if="f.editType==='textarea'" v-model="editData[f.key]" type="textarea" :rows="3" />
        <el-select v-else-if="f.editType==='select'" v-model="editData[f.key]" style="width:100%">
          <el-option v-for="o in (f.options||[])" :key="o" :label="o" :value="o" />
        </el-select>
        <el-date-picker v-else-if="f.editType==='date'" v-model="editData[f.key]" type="date" style="width:100%" />
      </el-form-item>
    </el-form>

    <div v-else-if="mode==='print'" class="print-preview" id="print-area">
      <h2 style="text-align:center;margin-bottom:16px;color:#153D97">{{ printTitle || title }}</h2>
      <table style="width:100%;border-collapse:collapse;font-size:13px">
        <tr v-for="f in fields" :key="f.key" style="border-bottom:1px solid #f0f0f0">
          <td style="padding:8px 12px;font-weight:600;width:120px;background:#f8fafc;color:#475569">{{ f.label }}</td>
          <td style="padding:8px 12px">{{ data[f.key] || '-' }}</td>
        </tr>
      </table>
      <p style="text-align:center;margin-top:24px;color:#94a3b8;font-size:11px">打印时间: {{ new Date().toLocaleString() }}</p>
    </div>

    <template #footer>
      <span v-if="mode==='view'">
        <el-button @click="mode='edit';initEdit()" type="warning">编辑</el-button>
        <el-button @click="mode='print'" type="success">打印</el-button>
        <el-button @click="visible=false">关闭</el-button>
      </span>
      <span v-else-if="mode==='edit'">
        <el-button @click="mode='view'">取消</el-button>
        <el-button type="primary" @click="handleSave">保存</el-button>
      </span>
      <span v-else-if="mode==='print'">
        <el-button @click="doPrint" type="primary">打印</el-button>
        <el-button @click="mode='view'">返回</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, watch, reactive } from 'vue'
import { ElMessage } from 'element-plus'

const props = defineProps<{
  modelValue: boolean
  title: string
  data: Record<string, any>
  fields: Array<{key:string,label:string,span?:number,type?:string,tagOk?:string,editable?:boolean,editType?:string,options?:string[]}>
  printTitle?: string
}>()
const emit = defineEmits(['update:modelValue','close','save'])

const visible = ref(props.modelValue)
const mode = ref<'view'|'edit'|'print'>('view')
const editData = reactive<Record<string,any>>({})

watch(() => props.modelValue, v => { visible.value = v; if(v) mode.value='view' })
watch(visible, v => emit('update:modelValue', v))

function initEdit() { props.fields.forEach(f => editData[f.key] = props.data[f.key]) }
function statusType(s:string) { return s==='已通过'||s==='已完成'||s==='已注册'?'success':s==='审核中'||s==='待注册'?'warning':'info' }
function handleSave() { ElMessage.success('保存成功'); emit('save', {...editData}); mode.value='view'; visible.value=false }
function doPrint() { window.print() }
</script>
