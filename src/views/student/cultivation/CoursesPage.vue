<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>课务管理</span></div>
      <div class="card-body">
        <el-tabs type="border-card" v-model="tab">
          <el-tab-pane label="开课目录" name="1"><el-table :data="catalog" size="small" stripe><el-table-column prop="code" label="编号" width="100"/><el-table-column prop="name" label="课程名称" min-width="180"/><el-table-column label="教师" min-width="100"><template #default="{row}"><span style="font-size:12px">{{row.teachers}}</span></template></el-table-column><el-table-column prop="credits" label="学分" width="60"/><el-table-column prop="semester" label="开课学期" width="130"/></el-table></el-tab-pane>
          <el-tab-pane label="网上选课" name="2"><el-alert title="选课开放: 2026年6月15日-25日" type="success" :closable="false" style="margin-bottom:12px"/><el-table :data="avail" size="small" stripe><el-table-column type="selection" width="40"/><el-table-column prop="name" label="课程" min-width="160"/><el-table-column label="教师" width="120"><template #default="{row}"><span style="font-size:12px">{{row.teachers}}</span></template></el-table-column><el-table-column prop="credits" label="学分" width="60"/><el-table-column label="操作" width="80"><template #default><el-button type="primary" size="small" round>选课</el-button></template></el-table-column></el-table><el-button type="primary" round style="margin-top:12px">提交选课</el-button></el-tab-pane>
          <el-tab-pane label="选课结果" name="3"><el-table :data="selected" size="small" stripe><el-table-column prop="name" label="课程" min-width="160"/><el-table-column label="教师" width="120"><template #default="{row}"><span style="font-size:12px">{{row.teachers}}</span></template></el-table-column><el-table-column prop="credits" label="学分" width="60"/><el-table-column prop="time" label="时间" width="130"/><el-table-column prop="location" label="地点" width="100"/></el-table></el-tab-pane>
          <el-tab-pane label="学期课表" name="4"><el-table :data="schedule" size="small" stripe><el-table-column prop="course" label="课程" min-width="140"/><el-table-column prop="credits" label="学分" width="50"/><el-table-column label="教师" width="120"><template #default="{row}"><span style="font-size:12px">{{row.teachers}}</span></template></el-table-column><el-table-column prop="time" label="时间" width="120"/><el-table-column prop="location" label="地点" width="90"/></el-table></el-tab-pane>
          <el-tab-pane label="成绩查询" name="5"><el-table :data="grades" size="small" stripe><el-table-column prop="course" label="课程" min-width="160"/><el-table-column prop="semester" label="学期" width="130"/><el-table-column prop="credits" label="学分" width="50"/><el-table-column prop="grade" label="成绩" width="60"><template #default="{row}"><span :style="{color:row.grade>=90?'#16a34a':row.grade>=80?'#153D97':'#333',fontWeight:'700'}">{{row.grade}}</span></template></el-table-column></el-table><div style="text-align:right;font-weight:600;margin-top:8px">平均绩点: 3.6</div></el-tab-pane>
          <el-tab-pane label="考试查询" name="6"><el-table :data="exams" size="small" stripe><el-table-column prop="course" label="课程" min-width="140"/><el-table-column prop="type" label="类型" width="80"/><el-table-column prop="date" label="时间" width="150"/><el-table-column prop="location" label="地点" width="120"/><el-table-column prop="seat" label="座位" width="60"/></el-table></el-tab-pane>
          <el-tab-pane label="调停补课" name="7"><el-table :data="adjusts" size="small" stripe><el-table-column prop="course" label="课程" min-width="140"/><el-table-column prop="type" label="类型" width="80"><template #default><el-tag size="small" round>调课</el-tag></template></el-table-column><el-table-column prop="original" label="原安排" min-width="120"/><el-table-column prop="adjusted" label="调整后" min-width="120"/></el-table></el-tab-pane>
          <el-tab-pane label="重修管理" name="8"><el-table :data="retakes" size="small" stripe><el-table-column prop="course" label="课程" min-width="160"/><el-table-column prop="grade" label="原成绩" width="70"/><el-table-column prop="date" label="申请日期" width="110"/><el-table-column prop="status" label="状态" width="90"><template #default><el-tag size="small" round>审核中</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="免修管理" name="9"><el-button type="primary" size="small" round style="margin-bottom:12px">申请免修</el-button><el-table :data="exempts" size="small" stripe><el-table-column prop="course" label="课程" min-width="160"/><el-table-column prop="reason" label="原因" min-width="160"/><el-table-column prop="status" label="状态" width="90"><template #default><el-tag size="small" round>审核中</el-tag></template></el-table-column></el-table></el-tab-pane>
          <el-tab-pane label="教学评价" name="10"><el-table :data="evals" size="small" stripe><el-table-column prop="course" label="课程" min-width="160"/><el-table-column label="教师" width="90"><template #default><el-tag size="small" round>李教授</el-tag></template></el-table-column><el-table-column label="状态" width="90"><template #default="{row}"><el-tag :type="row.done?'success':'warning'" size="small" round>{{row.done?'已评价':'待评价'}}</el-tag></template></el-table-column><el-table-column label="操作" width="80"><template #default="{row}"><el-button v-if="!row.done" type="primary" size="small" round>评价</el-button><el-button v-else text type="primary" size="small">查看</el-button></template></el-table-column></el-table></el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
const tab=ref('1')
const catalog=ref([{code:'CS601',name:'高级算法设计与分析',teachers:'李教授、张副教授',credits:3,semester:'2025-2026-2'},{code:'CS602',name:'机器学习理论',teachers:'王教授、赵讲师',credits:2,semester:'2025-2026-2'}])
const avail=ref([{name:'自然语言处理',teachers:'周教授',credits:2}])
const selected=ref([{name:'高级算法设计与分析',teachers:'李教授、张副教授',credits:3,time:'周一 8:00-10:25',location:'A301'},{name:'机器学习理论',teachers:'王教授、赵讲师',credits:2,time:'周二 14:00-16:25',location:'B205'}])
const schedule=ref([{course:'高级算法设计',credits:3,teachers:'李教授、张副教授',time:'周一 8:00',location:'A301'},{course:'机器学习理论',credits:2,teachers:'王教授、赵讲师',time:'周二 14:00',location:'B205'}])
const grades=ref([{course:'高级算法设计与分析',semester:'2025-2026-1',credits:3,grade:92},{course:'机器学习理论',semester:'2025-2026-1',credits:2,grade:88}])
const exams=ref([{course:'高级算法设计',type:'闭卷',date:'2026-07-05 09:00',location:'A301',seat:'15'}])
const adjusts=ref([{course:'机器学习理论',original:'周二14:00 A301',adjusted:'周四14:00 B205'}])
const retakes=ref([]),exempts=ref([])
const evals=ref([{course:'高级算法设计',done:true},{course:'机器学习理论',done:false}])
</script>
<style scoped>.page-section{max-width:1100px}</style>
