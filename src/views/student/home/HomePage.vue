<template>
  <div class="home-page">
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>通知公告</span><el-button text type="primary" size="small">more</el-button></div><div class="card-body"><div v-for="n in notices" :key="n.id" class="n-row"><span :class="n.read?'read':'unread'">{{ n.title }}</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>待办提醒</span><el-button text type="primary" size="small">more</el-button></div><div class="card-body"><div v-for="t in todos" :key="t.id" class="n-row"><span :class="t.done?'read':'unread'">{{ t.title }}</span><el-button v-if="!t.done" type="primary" size="small" round>办理</el-button></div></div></div>
    </div>
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>本学期课表</span></div><div class="card-body"><el-table :data="schedule" size="small" stripe><el-table-column prop="course" label="课程" min-width="130"/><el-table-column prop="class" label="班级" min-width="120"/><el-table-column prop="hours" label="课时" width="50"/><el-table-column prop="credits" label="学分" width="50"/><el-table-column label="教师" min-width="80"><template #default="{row}"><span style="font-size:12px">{{ row.teachers }}</span></template></el-table-column><el-table-column prop="time" label="时间" width="110"/><el-table-column prop="location" label="地点" width="90"/></el-table></div></div>
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#108B96"></span>课程进度</span></div><div class="card-body"><div class="cbar" v-for="c in credits" :key="c.name"><span class="cl">{{ c.name }}</span><el-progress :percentage="c.pct" :stroke-width="10" :color="c.pct>=100?'#108B96':'#f4ca91'"/><span class="cn" :class="c.pct>=100?'done':'pend'">{{c.done}}/{{c.req}}</span></div></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#8b5cf6"></span>科研进度</span></div><div class="card-body"><h4 style="font-size:13px;margin-bottom:6px">已完成</h4><div v-for="a in achievements" :key="a.name" class="r-row"><el-tag size="small" round>{{a.cat}}</el-tag><span>{{a.name}}</span></div><h4 style="font-size:13px;margin:10px 0 6px">在研项目</h4><div v-for="p in projects" :key="p" class="r-row"><span>{{p}}</span></div></div></div>
    </div>
    <div class="card-grid-2">
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot" style="background:#f4ca91"></span>揭榜挂帅</span><el-button text type="primary" size="small" @click="$router.push('/student/mentorship/jiebang')">more</el-button></div><div class="card-body"><el-table :data="jiebangTasks" size="small" stripe><el-table-column type="index" label="#" width="40"/><el-table-column prop="title" label="项目名称" min-width="220" show-overflow-tooltip/><el-table-column prop="cat" label="类别" width="100"><template #default="{row}"><el-tag size="small" round effect="plain">{{row.cat}}</el-tag></template></el-table-column><el-table-column label="操作" width="70"><template #default><el-button text type="primary" size="small">详情</el-button></template></el-table-column></el-table></div></div>
      <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>学业进展</span></div><div class="card-body"><div class="prow"><span v-for="n in nodes" :key="n.id" class="pn" :class="n.status" @click="$router.push(n.path)">{{n.name}}</span></div></div></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const notices=ref([{id:1,title:'关于2026年春季学期研究生选课通知',read:false},{id:2,title:'研究生学术论坛报名通知',read:false},{id:3,title:'学位论文中期检查安排',read:true},{id:4,title:'奖助学金评审结果公示',read:false}])
const todos=ref([{id:1,title:'学位论文开题报告提交',done:false},{id:2,title:'学期注册信息确认',done:false},{id:3,title:'奖学金申请材料补充',done:true},{id:4,title:'教学评价填写',done:false}])
const schedule=ref([{course:'高级算法设计',class:'2023级计算机硕士班',hours:48,credits:3,teachers:'李教授、张副教授',time:'周一 8:00',location:'A301'},{course:'机器学习理论',class:'2023级计算机硕士班',hours:32,credits:2,teachers:'王教授、赵讲师',time:'周二 14:00',location:'B205'},{course:'学术英语写作',class:'2023级硕士英语A班',hours:32,credits:2,teachers:'陈教授、刘副教授',time:'周三 10:00',location:'外语楼301'}])
const credits=ref([{name:'公共必修课',req:6,done:6,pct:100},{name:'学科基础课',req:8,done:8,pct:100},{name:'专业选修课',req:10,done:6,pct:60},{name:'公共选修课',req:4,done:2,pct:50},{name:'实践环节',req:4,done:2,pct:50}])
const achievements=ref([{cat:'论文',name:'基于深度学习的图像识别研究'},{cat:'专利',name:'智能推荐算法优化'},{cat:'会议',name:'2026全国AI学术会议'},{cat:'竞赛',name:'全国数模竞赛二等奖'}])
const projects=ref(['大规模图神经网络训练优化','多模态数据融合分析方法研究'])
const nodes=ref([{id:1,name:'个人',status:'always',path:'/student/others/profile'},{id:2,name:'研工',status:'always',path:'/student/research-work/scholarship'},{id:3,name:'导学',status:'always',path:'/student/mentorship/team'},{id:4,name:'培养',status:'active',path:'/student/cultivation/plan'},{id:5,name:'科研',status:'always',path:'/student/degree/achievements'},{id:6,name:'开题',status:'done',path:'/student/degree/thesis'},{id:7,name:'中期',status:'active',path:'/student/degree/thesis'},{id:8,name:'论文',status:'pending',path:'/student/degree/thesis'},{id:9,name:'答辩',status:'pending',path:'/student/degree/thesis'},{id:10,name:'学位',status:'pending',path:'/student/degree/graduation'},{id:11,name:'毕业',status:'pending',path:'/student/degree/graduation'}])
const jiebangTasks=ref([{title:'智能交通流量预测模型研究',cat:'科研攻关'},{title:'基于联邦学习的隐私保护方案',cat:'技术创新'},{title:'大规模知识图谱构建与应用',cat:'科研攻关'},{title:'边缘计算资源调度优化',cat:'技术创新'},{title:'多模态数据融合分析方法',cat:'方法研究'}])
</script>

<style scoped>
.home-page{display:flex;flex-direction:column;gap:14px;max-width:1400px}
.n-row{display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px dashed #f1f5f9;font-size:13px}
.n-row:last-child{border-bottom:none}
.unread{font-weight:700;color:#0f172a;cursor:pointer}.read{color:#94a3b8;cursor:pointer}
.cbar{display:flex;align-items:center;gap:10px;margin-bottom:10px}
.cl{width:90px;font-size:12px;flex-shrink:0}
.cn{font-size:11px;font-weight:700;flex-shrink:0;width:44px;text-align:right}
.cn.done{color:#108B96}.cn.pend{color:#dc2626}
.r-row{display:flex;align-items:center;gap:8px;padding:6px 10px;background:#f8fafc;border-radius:8px;font-size:12px;margin-bottom:4px}
.prow{display:flex;flex-wrap:wrap;gap:6px;justify-content:center}
.pn{display:inline-flex;align-items:center;justify-content:center;padding:8px 16px;border-radius:10px;font-size:13px;font-weight:600;cursor:pointer;border:2px solid transparent;transition:all .1s}
.pn:hover{transform:translateY(-2px);box-shadow:0 4px 12px rgba(0,0,0,.1)}
.pn.always{background:linear-gradient(135deg,#1e293b,#334155);color:#fff;border-color:#475569}
.pn.active{background:#eff6ff;color:#153D97;border-color:#93c5fd}
.pn.done{background:#f0fdf4;color:#108B96;border-color:#86efac}
.pn.pending{background:#f8fafc;color:#94a3b8;border-color:#e2e8f0}
</style>
