<template>
  <div class="page-section">
    <div class="home-card"><div class="card-header"><span class="card-title"><span class="title-dot"></span>照片核对</span></div>
      <div class="card-body"><el-alert title="请上传本人近期免冠蓝底证件照，480x640像素，JPG格式" type="info" :closable="false" show-icon style="margin-bottom:20px"/><el-row :gutter="30"><el-col :span="8"><div style="border:2px dashed #e2e8f0;border-radius:14px;text-align:center;padding:40px 20px"><el-icon :size="48" color="#cbd5e1"><UserFilled/></el-icon><p style="margin-top:10px;color:#94a3b8">学籍照片</p><el-tag type="success" round>已上传</el-tag></div></el-col><el-col :span="16"><el-upload drag action="#" :auto-upload="false" :limit="1" accept=".jpg,.jpeg"><el-icon :size="40"><UploadFilled/></el-icon><div style="margin-top:8px;color:#64748b">拖到此处或<em style="color:#153D97;font-weight:600">点击上传</em></div></el-upload><el-button type="primary" round style="margin-top:16px">确认上传</el-button></el-col></el-row></div>
    </div>
  </div>
</template>
<style scoped>.page-section{max-width:900px}</style>
