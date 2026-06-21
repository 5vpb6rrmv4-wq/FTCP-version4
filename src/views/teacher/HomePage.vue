<template>
  <div class="teacher-home">
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>通知公告</span></div><div class="card-body"><div v-for="n in notices" :key="n.id" class="n-row"><span class="unread">{{ n.title }}</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>待办提醒</span></div><div class="card-body"><div v-for="t in todos" :key="t.id" class="n-row"><span class="unread">{{ t.title }}</span><el-button type="primary" size="small" round>办理</el-button></div></div></div>
    </div>

    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>本学期课表</span><el-button text type="primary" size="small">授课历史查询</el-button></div>
      <div class="card-body"><el-table :data="teachSchedule" size="small" stripe><el-table-column prop="className" label="班级" min-width="140"/><el-table-column prop="location" label="地点" width="120"/><el-table-column prop="time" label="时间" width="140"/><el-table-column label="操作" width="170"><template #default><el-button size="small" round>选课学生</el-button><el-button size="small" type="primary" round>成绩</el-button></template></el-table-column></el-table></div>
    </div>

    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#8b5cf6"></span>指导研究生（5人）</span><el-button text type="primary" size="small">历史查询</el-button></div>
        <div class="card-body"><el-table :data="students" size="small" stripe><el-table-column prop="grade" label="年级" width="60"/><el-table-column prop="order" label="导师顺序" width="80"/><el-table-column prop="id" label="学号" width="110"/><el-table-column prop="name" label="姓名" width="70"/><el-table-column prop="status" label="状态" width="80"><template #default="{row}"><el-tag :type="row.status==='在校'?'success':'warning'" size="small" round>{{row.status}}</el-tag></template></el-table-column><el-table-column label="学业进度" min-width="180"><template #default="{row}"><span v-for="s in row.progress" :key="s.name" class="mini-dot" :class="s.done?'done':'pending'">{{s.name}}</span></template></el-table-column><el-table-column label="操作" width="90"><template #default="{row}"><el-button v-if="row.needsApproval" type="warning" size="small" round>审批</el-button><el-button v-else text size="small">查看</el-button></template></el-table-column></el-table></div>
      </div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#f4ca91"></span>在研项目</span><el-button text type="primary" size="small">more</el-button></div>
        <div class="card-body"><div v-for="p in projects" :key="p.id" class="r-row"><span style="font-size:13px;font-weight:600">{{p.name}}</span><el-tag size="small" round>{{p.source}}</el-tag><span style="color:#64748b;font-size:11px">{{p.deadline}}</span></div></div>
      </div>
    </div>

    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>成果展示（最佳10项）</span><el-button text type="primary" size="small">more</el-button></div>
      <div class="card-body"><div class="achieve-grid"><span v-for="a in achievements" :key="a.name" class="a-chip"><el-tag size="small" round effect="plain">{{a.cat}}</el-tag>{{a.name}}</span></div></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const notices=ref([{id:1,title:'关于2026年研究生导师培训通知'},{id:2,title:'学位论文评审专家征集通知'},{id:3,title:'研究生学术论坛征集评审专家'},{id:4,title:'2026年度硕导遴选工作启动'}])
const todos=ref([{id:1,title:'指导学生开题报告审核(3人待审)'},{id:2,title:'研究生中期考核评语填写'},{id:3,title:'研究生论文评审评语提交'},{id:4,title:'导师培训材料上传'}])
const teachSchedule=ref([{className:'2023级计算机硕士班',location:'教学楼A301',time:'周一 8:00-10:25'},{className:'2024级计算机硕士班',location:'教学楼B205',time:'周三 14:00-16:25'}])
const students=ref([{grade:'2023',order:'第一导师',id:'2023301001',name:'张三',status:'在校',progress:[{name:'学分',done:true},{name:'开题',done:true},{name:'中期',done:false},{name:'论文',done:false}],needsApproval:true},{grade:'2023',order:'第二导师',id:'2023301002',name:'李四',status:'在校',progress:[{name:'学分',done:true},{name:'开题',done:true},{name:'中期',done:true},{name:'论文',done:false}],needsApproval:false},{grade:'2024',order:'第一导师',id:'2024301001',name:'王五',status:'在校',progress:[{name:'学分',done:true},{name:'开题',done:false},{name:'中期',done:false},{name:'论文',done:false}],needsApproval:false}])
const projects=ref([{id:1,name:'大规模图神经网络训练优化研究',source:'国家自然科学基金',deadline:'2027-12'},{id:2,name:'多模态数据融合分析平台',source:'省科技厅重点研发',deadline:'2026-12'},{id:3,name:'智能推荐系统算法研究',source:'企业横向合作',deadline:'2026-06'},{id:4,name:'边缘计算资源调度理论',source:'教育部重点实验室',deadline:'2028-03'},{id:5,name:'联邦学习隐私保护方案',source:'校企联合实验室',deadline:'2027-06'}])
const achievements=ref([{cat:'论文',name:'IEEE TPAMI深度学习综述'},{cat:'荣誉',name:'国家杰出青年科学基金'},{cat:'项目',name:'智慧城市交通预测系统'},{cat:'专利',name:'图神经网络训练加速方法'},{cat:'论文',name:'NeurIPS 2025 Spotlight'},{cat:'奖励',name:'省科技进步一等奖'},{cat:'教材',name:'《高级算法设计》'},{cat:'课程',name:'国家级一流课程'},{cat:'竞赛',name:'指导研究生获数模国一'},{cat:'报告',name:'人工智能产业白皮书'}])
</script>

<style scoped>
.teacher-home{display:flex;flex-direction:column;gap:14px;max-width:1500px}
.n-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px dashed #f1f5f9;font-size:13px}
.n-row:last-child{border-bottom:none}
.unread{font-weight:700;color:#0f172a;cursor:pointer}
.r-row{display:flex;align-items:center;gap:10px;padding:7px 12px;background:#f8fafc;border-radius:8px;margin-bottom:5px}
.mini-dot{padding:2px 8px;border-radius:10px;font-size:10px;font-weight:600;margin-right:4px}
.mini-dot.done{background:#dcfce7;color:#166534}
.mini-dot.pending{background:#fef3c7;color:#92400e}
.achieve-grid{display:flex;flex-wrap:wrap;gap:8px}
.a-chip{display:flex;align-items:center;gap:6px;padding:6px 12px;background:#f8fafc;border-radius:8px;font-size:12px}
</style>
