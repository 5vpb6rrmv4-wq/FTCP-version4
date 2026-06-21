-- ============================================================
-- 人才选拔全流程平台 (FTCP) — 完整 PostgreSQL 初始化
-- 集成自: 重智院0608 现有SQL Server + 开发需求文档 + 你指定的技术栈
-- 兼容层: 原 XJ0503/js/sys_user 表保留为视图别名
-- ============================================================
-- 第一步: 创建数据库 (需手动执行)
-- CREATE DATABASE ftcp;
-- \c ftcp;

-- ============================================================
-- 一、系统认证表 (从现有 XJ0503/js/sys_user 迁移)
-- ============================================================

-- 统一用户表，role区分角色
CREATE TABLE sys_user (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL DEFAULT '123456',
    real_name VARCHAR(50),
    role VARCHAR(20) NOT NULL DEFAULT 'student' CHECK (role IN ('student','teacher','admin','leader')),
    college VARCHAR(100),
    major VARCHAR(100),
    grade VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    id_card VARCHAR(18),
    gender VARCHAR(4),
    birth_date DATE,
    ethnicity VARCHAR(20),
    political_status VARCHAR(20),
    advisor VARCHAR(50),
    enroll_date DATE,
    duration VARCHAR(10),
    address TEXT,
    status SMALLINT DEFAULT 1,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW(),
    update_time TIMESTAMP DEFAULT NOW()
);
COMMENT ON TABLE sys_user IS '统一用户表，替代原XJ0503学生/js教师/sys_user管理员/leader_user领导表';

-- 兼容视图: 原XJ0503学生表别名
CREATE VIEW XJ0503 AS SELECT username AS xh, real_name AS xm, password AS passwd FROM sys_user WHERE role='student' AND deleted=0;
-- 兼容视图: 原js教师表别名
CREATE VIEW js AS SELECT username AS jsbh, real_name AS jsxm, password AS passwd FROM sys_user WHERE role='teacher' AND deleted=0;

-- 通知公告表
CREATE TABLE sys_notice (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    content TEXT,
    press_date DATE DEFAULT CURRENT_DATE,
    category VARCHAR(20) DEFAULT 'notice' CHECK (category IN ('notice','todo','file','rule')),
    publisher VARCHAR(50),
    target_role VARCHAR(50),
    read_count INT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);
COMMENT ON TABLE sys_notice IS '通知公告表，兼容原Web_Info';

-- 阅读记录表
CREATE TABLE sys_notice_read (
    id BIGSERIAL PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    notice_id BIGINT NOT NULL REFERENCES sys_notice(id),
    read_time TIMESTAMP DEFAULT NOW(),
    UNIQUE(user_id, notice_id)
);
COMMENT ON TABLE sys_notice_read IS '公告阅读记录，兼容原Web_Info_Read';

-- 数据字典
CREATE TABLE sys_dict (
    id BIGSERIAL PRIMARY KEY,
    dict_type VARCHAR(50) NOT NULL,
    dict_label VARCHAR(100),
    dict_value VARCHAR(100),
    sort_order INT DEFAULT 0,
    remark VARCHAR(200),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 二、学生端 - 培养模块 (2.1)
-- ============================================================

-- 2.1.1 学期注册
CREATE TABLE xc_semester_register (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    semester VARCHAR(30) NOT NULL,
    register_date DATE,
    register_location VARCHAR(100),
    register_status VARCHAR(20) DEFAULT '待注册' CHECK (register_status IN ('待注册','已注册','免注册')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW(),
    update_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.1 培养计划
CREATE TABLE xc_cultivation_plan (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    credits NUMERIC(3,1),
    course_type VARCHAR(20) CHECK (course_type IN ('学位课','公共课','选修课','实践环节')),
    semester VARCHAR(20),
    grade NUMERIC(5,2),
    gpa NUMERIC(3,1),
    plan_status VARCHAR(20) DEFAULT '进行中' CHECK (plan_status IN ('进行中','已完成','未通过')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.1 变更导师申请
CREATE TABLE xc_advisor_change (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    original_advisor VARCHAR(50),
    new_advisor VARCHAR(50),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    audit1_status VARCHAR(20) DEFAULT '待审核',
    audit2_status VARCHAR(20) DEFAULT '待审核',
    final_status VARCHAR(20) DEFAULT '审核中' CHECK (final_status IN ('审核中','已通过','已驳回')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.2 课程目录/课表
CREATE TABLE xc_course_catalog (
    id BIGSERIAL PRIMARY KEY,
    course_code VARCHAR(30),
    course_name VARCHAR(200) NOT NULL,
    teacher_ids TEXT,
    teacher_names TEXT,
    credits NUMERIC(3,1),
    hours INT,
    semester VARCHAR(20),
    class_name VARCHAR(200),
    location VARCHAR(100),
    schedule_time VARCHAR(200),
    grade_open SMALLINT DEFAULT 0,
    exam_open SMALLINT DEFAULT 0,
    eval_open SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.2 选课记录
CREATE TABLE xc_course_selection (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    course_id BIGINT NOT NULL REFERENCES xc_course_catalog(id),
    semester VARCHAR(20),
    select_status VARCHAR(20) DEFAULT '已选',
    UNIQUE(student_id, course_id, semester),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.2 成绩
CREATE TABLE xc_course_grade (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    course_id BIGINT NOT NULL REFERENCES xc_course_catalog(id),
    grade NUMERIC(5,2),
    gpa NUMERIC(3,1),
    exam_type VARCHAR(20),
    exam_date TIMESTAMP,
    location VARCHAR(100),
    seat_no VARCHAR(10),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.3 考级成绩
CREATE TABLE xc_exam_level (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    exam_type VARCHAR(50),
    score NUMERIC(5,1),
    exam_date DATE,
    cert_no VARCHAR(100),
    passed SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.4 必修环节
CREATE TABLE xc_required_module (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    module_type VARCHAR(30) CHECK (module_type IN ('文献阅读','社会实践','教学实践','学术报告')),
    title VARCHAR(200),
    content TEXT,
    report_file VARCHAR(500),
    teacher_comment TEXT,
    module_status VARCHAR(20) DEFAULT '进行中' CHECK (module_status IN ('进行中','已完成')),
    complete_date DATE,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- 2.1.5 学籍异动
CREATE TABLE xc_status_change (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    change_type VARCHAR(20) CHECK (change_type IN ('休学','复学','退学','转专业','延期毕业','提前毕业')),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    change_status VARCHAR(20) DEFAULT '审核中' CHECK (change_status IN ('审核中','已通过','已驳回')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 三、学生端 - 导学模块 (2.2)
-- ============================================================
CREATE TABLE xc_mentor_team (
    id BIGSERIAL PRIMARY KEY,
    team_name VARCHAR(200),
    leader_teacher_id VARCHAR(50),
    leader_teacher_name VARCHAR(50),
    member_count INT DEFAULT 0,
    description TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_mentor_team_member (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL REFERENCES xc_mentor_team(id),
    student_id VARCHAR(50) NOT NULL,
    student_name VARCHAR(50),
    grade VARCHAR(10),
    role VARCHAR(30) DEFAULT '团队成员',
    research_direction VARCHAR(300),
    email VARCHAR(100),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_academic_record (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50),
    teacher_id VARCHAR(50),
    record_type VARCHAR(20) CHECK (record_type IN ('学业纪实','学业指导')),
    record_date DATE DEFAULT CURRENT_DATE,
    topic VARCHAR(200),
    content TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_ideology_case (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200),
    category VARCHAR(30),
    content TEXT,
    source VARCHAR(200),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_culture_resource (
    id BIGSERIAL PRIMARY KEY,
    resource_type VARCHAR(20) CHECK (resource_type IN ('文件','活动策划')),
    title VARCHAR(200),
    file_url VARCHAR(500),
    uploader_id VARCHAR(50),
    uploader_name VARCHAR(50),
    proposer_name VARCHAR(50),
    proposed_date DATE,
    resource_status VARCHAR(20) DEFAULT '正常',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_jiebang_task (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(300) NOT NULL,
    category VARCHAR(30) CHECK (category IN ('科研攻关','技术创新','方法研究','揭榜挂帅')),
    publisher VARCHAR(100),
    publish_date DATE DEFAULT CURRENT_DATE,
    deadline DATE,
    description TEXT,
    team_id BIGINT REFERENCES xc_mentor_team(id),
    task_status VARCHAR(20) DEFAULT '招募中' CHECK (task_status IN ('招募中','进行中','已完成')),
    progress_log TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 四、学生端 - 学位模块 (2.3)
-- ============================================================
CREATE TABLE xc_thesis (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    title VARCHAR(500),
    proposal_date DATE,
    proposal_result VARCHAR(20),
    proposal_experts TEXT,
    midterm_date DATE,
    midterm_result VARCHAR(20),
    midterm_rate VARCHAR(10),
    review_apply_date DATE,
    review_result VARCHAR(20),
    review_score NUMERIC(5,1),
    pre_defense_date DATE,
    defense_date DATE,
    defense_result VARCHAR(20),
    excellent_apply SMALLINT DEFAULT 0,
    archive_file VARCHAR(500),
    current_stage VARCHAR(30) DEFAULT '未开始',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_degree_apply (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    degree_type VARCHAR(30),
    apply_date DATE DEFAULT CURRENT_DATE,
    apply_status VARCHAR(20) DEFAULT '未申请',
    employment_company VARCHAR(200),
    employment_position VARCHAR(100),
    employment_type VARCHAR(30),
    early_graduate SMALLINT DEFAULT 0,
    delay_graduate SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_paper_achievement (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    achievement_type VARCHAR(20) CHECK (achievement_type IN ('论文','专利','科研成果','竞赛')),
    title VARCHAR(300) NOT NULL,
    journal_name VARCHAR(300),
    journal_level VARCHAR(30),
    publish_date DATE,
    patent_no VARCHAR(100),
    patent_status VARCHAR(20),
    graduation_check SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 五、学生端 - 研工管理模块 (2.4)
-- ============================================================
CREATE TABLE xc_scholarship (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    scholarship_name VARCHAR(200) NOT NULL,
    scholarship_level VARCHAR(30),
    category VARCHAR(20) CHECK (category IN ('奖学金','个人评优','班级评优','证明打印')),
    amount VARCHAR(30),
    department VARCHAR(100),
    apply_date DATE DEFAULT CURRENT_DATE,
    apply_status VARCHAR(20) DEFAULT '审核中' CHECK (apply_status IN ('审核中','已通过','已驳回')),
    certificate_print SMALLINT DEFAULT 0,
    class_name VARCHAR(100),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_student_loan (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    loan_type VARCHAR(30),
    amount NUMERIC(10,2),
    bank VARCHAR(100),
    apply_date DATE DEFAULT CURRENT_DATE,
    loan_status VARCHAR(20) DEFAULT '审核中' CHECK (loan_status IN ('审核中','已通过','已驳回')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_leave_request (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    leave_type VARCHAR(10) CHECK (leave_type IN ('事假','病假','公假')),
    reason TEXT,
    start_date DATE,
    end_date DATE,
    days INT,
    teacher_audit VARCHAR(20) DEFAULT '待审核',
    college_audit VARCHAR(20) DEFAULT '待审核',
    leave_status VARCHAR(20) DEFAULT '审核中' CHECK (leave_status IN ('审核中','已批准','已驳回','已销假','已撤销')),
    approver_id VARCHAR(50),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_assist_post (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    post_name VARCHAR(200),
    department VARCHAR(100),
    post_type VARCHAR(10) CHECK (post_type IN ('助教','助管','助研','辅')),
    apply_date DATE DEFAULT CURRENT_DATE,
    resign_reason TEXT,
    post_status VARCHAR(20) DEFAULT '审核中' CHECK (post_status IN ('审核中','在岗','已退岗')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_hardship (
    id BIGSERIAL PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    hardship_type VARCHAR(30),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    hardship_status VARCHAR(20) DEFAULT '审核中' CHECK (hardship_status IN ('审核中','已通过','已驳回')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 六、教师相关表
-- ============================================================
CREATE TABLE xc_teacher_course (
    id BIGSERIAL PRIMARY KEY,
    teacher_id VARCHAR(50) NOT NULL,
    course_id BIGINT REFERENCES xc_course_catalog(id),
    course_name VARCHAR(200),
    class_name VARCHAR(200),
    hours INT,
    credits NUMERIC(3,1),
    semester VARCHAR(20),
    syllabus TEXT,
    teach_plan TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_research_project (
    id BIGSERIAL PRIMARY KEY,
    teacher_id VARCHAR(50) NOT NULL,
    project_name VARCHAR(300),
    project_source VARCHAR(100),
    fund NUMERIC(10,2),
    start_date DATE,
    deadline DATE,
    progress INT DEFAULT 0,
    project_status VARCHAR(20) DEFAULT '在研' CHECK (project_status IN ('在研','已结项','已终止')),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_teacher_achievement (
    id BIGSERIAL PRIMARY KEY,
    teacher_id VARCHAR(50) NOT NULL,
    achievement_type VARCHAR(20) CHECK (achievement_type IN ('论文','专利','项目','获奖','教材','课程','竞赛','报告','荣誉','社会服务')),
    title VARCHAR(300) NOT NULL,
    category VARCHAR(30),
    date DATE,
    source VARCHAR(200),
    display_order INT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ============================================================
-- 七、种子数据
-- ============================================================
INSERT INTO sys_user (username, password, real_name, role, college, major, grade, phone, email, advisor, gender, ethnicity, political_status, enroll_date, duration) VALUES
('2023301001', '123456', '张三', 'student', '计算机学院', '计算机科学与技术', '2023', '13800138000', 'zhangsan@cqupt.edu.cn', '李教授', '1', '汉族', '共青团员', '2023-09-01', '3年'),
('2023301002', '123456', '李四', 'student', '计算机学院', '计算机科学与技术', '2023', '13900139000', 'lisi@cqupt.edu.cn', '李教授', '1', '汉族', '共青团员', '2023-09-01', '3年'),
('2024301001', '123456', '王五', 'student', '计算机学院', '软件工程', '2024', '13700137000', 'wangwu@cqupt.edu.cn', '王教授', '1', '汉族', '群众', '2024-09-01', '3年'),
('T2023001', '123456', '李教授', 'teacher', '计算机学院', NULL, NULL, NULL, 'liprof@cqupt.edu.cn', NULL, NULL, NULL, NULL, NULL, NULL),
('T2023002', '123456', '王教授', 'teacher', '计算机学院', NULL, NULL, NULL, 'wangprof@cqupt.edu.cn', NULL, NULL, NULL, NULL, NULL, NULL),
('admin001', '123456', '系统管理员', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('leader001', '123456', '校领导', 'leader', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO sys_dict (dict_type, dict_label, dict_value, sort_order) VALUES
('gender','男','1',1),('gender','女','2',2),
('degree_type','学士','bachelor',1),('degree_type','硕士','master',2),('degree_type','博士','doctor',3),
('course_type','学位课','degree',1),('course_type','公共课','public',2),('course_type','选修课','elective',3),('course_type','实践环节','practice',4),
('change_type','休学','suspend',1),('change_type','复学','resume',2),('change_type','退学','withdraw',3),('change_type','转专业','transfer',4),('change_type','延期毕业','delay',5),('change_type','提前毕业','early',6),
('leave_type','事假','personal',1),('leave_type','病假','sick',2),('leave_type','公假','official',3),
('scholarship_level','国家级','national',1),('scholarship_level','省级','provincial',2),('scholarship_level','校级','school',3);

-- 种子课程数据
INSERT INTO xc_course_catalog (course_code, course_name, teacher_names, credits, hours, semester, class_name, location, schedule_time, grade_open, exam_open, eval_open) VALUES
('CS601','高级算法设计与分析','李教授、张副教授',3,48,'2025-2026-2','2023级计算机硕士班','教学楼A301','周一 8:00-10:25',1,1,0),
('CS602','机器学习理论','王教授、赵讲师',2,32,'2025-2026-2','2023级计算机硕士班','教学楼B205','周二 14:00-16:25',1,0,1),
('EN501','学术英语写作','陈教授、刘副教授',2,32,'2025-2026-2','2023级硕士英语A班','外语楼301','周三 10:00-12:25',0,0,0);

-- 种子导师团队
INSERT INTO xc_mentor_team (team_name, leader_teacher_id, leader_teacher_name, member_count, description) VALUES
('智能计算与数据挖掘团队','T2023001','李教授',12,'专注于深度学习和数据挖掘方向');

INSERT INTO xc_mentor_team_member (team_id, student_id, student_name, grade, role, research_direction, email) VALUES
(1,'2023301001','张三','2023','团队骨干','深度学习、图像识别','zhangsan@cqupt.edu.cn'),
(1,'2023301002','李四','2023','团队成员','自然语言处理','lisi@cqupt.edu.cn'),
(1,'2024301001','王五','2024','团队成员','知识图谱','wangwu@cqupt.edu.cn');

-- 种子揭榜挂帅任务
INSERT INTO xc_jiebang_task (title, category, publisher, deadline, task_status) VALUES
('智能交通流量预测模型研究','科研攻关','科技处','2026-07-01','招募中'),
('基于联邦学习的隐私保护方案','技术创新','信息安全中心','2026-06-30','进行中'),
('大规模知识图谱构建与应用','科研攻关','知识工程实验室','2026-07-15','进行中'),
('边缘计算资源调度优化','技术创新','云计算中心','2026-05-20','已完成'),
('多模态数据融合分析方法','方法研究','数据科学实验室','2026-06-10','进行中');

-- 种子通知
INSERT INTO sys_notice (title, content, category, publisher, target_role) VALUES
('关于2026年春季学期研究生选课通知','选课时间:2026年6月15日-25日，请登录系统完成选课。','notice','研究生院','student'),
('研究生学术论坛报名通知','2026年研究生学术论坛将于7月举行，欢迎报名。','notice','科技处','student,teacher'),
('学位论文中期检查安排','请各学院按计划完成中期检查。','notice','学位办','student,teacher'),
('奖助学金评审结果公示','2026年度奖助学金评审结果已公布。','notice','研究生院','student');
