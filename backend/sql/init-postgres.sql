-- ============================================================
-- 人才选拔全流程平台 (FTCP) PostgreSQL 初始化脚本
-- ============================================================
CREATE DATABASE ftcp;
\c ftcp;

-- ==================== 系统表 ====================
CREATE TABLE sys_user (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    real_name VARCHAR(50),
    role VARCHAR(20) NOT NULL DEFAULT 'student',
    college VARCHAR(100),
    major VARCHAR(100),
    grade VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    status SMALLINT DEFAULT 1,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW(),
    update_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE sys_notice (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(300),
    content TEXT,
    publish_date DATE DEFAULT CURRENT_DATE,
    category VARCHAR(20) DEFAULT 'notice',
    publisher VARCHAR(50),
    target_role VARCHAR(50),
    read_count INT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE sys_dict (
    id BIGSERIAL PRIMARY KEY,
    dict_type VARCHAR(50),
    dict_label VARCHAR(100),
    dict_value VARCHAR(100),
    sort_order INT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== 2.1 培养 ====================
CREATE TABLE xc_cultivation_plan (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    course_name VARCHAR(200),
    credits DECIMAL(3,1),
    course_type VARCHAR(20),
    semester VARCHAR(20),
    status VARCHAR(20) DEFAULT '进行中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_semester_register (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    semester VARCHAR(30),
    register_date DATE,
    location VARCHAR(100),
    status VARCHAR(20) DEFAULT '待注册',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_advisor_change (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    original_advisor VARCHAR(50),
    new_advisor VARCHAR(50),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_course_catalog (
    id BIGSERIAL PRIMARY KEY,
    course_code VARCHAR(30),
    course_name VARCHAR(200) NOT NULL,
    teachers VARCHAR(200),
    credits DECIMAL(3,1),
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

CREATE TABLE xc_course_grade (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    grade DECIMAL(5,2),
    gpa DECIMAL(3,1),
    exam_type VARCHAR(20),
    exam_date TIMESTAMP,
    location VARCHAR(100),
    seat_no VARCHAR(10),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_exam_level (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    exam_type VARCHAR(50),
    score DECIMAL(5,1),
    exam_date DATE,
    cert_no VARCHAR(100),
    passed SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_required_module (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    module_type VARCHAR(30),
    title VARCHAR(200),
    content TEXT,
    report_file VARCHAR(500),
    teacher_comment TEXT,
    status VARCHAR(20) DEFAULT '进行中',
    complete_date DATE,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_status_change (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    change_type VARCHAR(20),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== 2.2 导学 ====================
CREATE TABLE xc_mentor_team (
    id BIGSERIAL PRIMARY KEY,
    team_name VARCHAR(200),
    leader_teacher VARCHAR(50),
    member_count INT DEFAULT 0,
    student_id BIGINT,
    student_name VARCHAR(50),
    grade VARCHAR(10),
    role VARCHAR(30),
    research_direction VARCHAR(300),
    email VARCHAR(100),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_academic_record (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT,
    record_type VARCHAR(20),
    record_date DATE DEFAULT CURRENT_DATE,
    advisor VARCHAR(50),
    topic VARCHAR(200),
    content TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_ideology_case (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200),
    category VARCHAR(20),
    content TEXT,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_culture_resource (
    id BIGSERIAL PRIMARY KEY,
    resource_type VARCHAR(20),
    title VARCHAR(200),
    file_url VARCHAR(500),
    uploader VARCHAR(50),
    proposer VARCHAR(50),
    proposed_date DATE,
    status VARCHAR(20),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_jiebang_task (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(300),
    category VARCHAR(30),
    publisher VARCHAR(100),
    publish_date DATE DEFAULT CURRENT_DATE,
    deadline DATE,
    status VARCHAR(20) DEFAULT '招募中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== 2.3 学位 ====================
CREATE TABLE xc_thesis (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    title VARCHAR(500),
    proposal_date DATE,
    proposal_result VARCHAR(20),
    midterm_date DATE,
    midterm_result VARCHAR(20),
    review_result VARCHAR(20),
    defense_date DATE,
    defense_result VARCHAR(20),
    excellent_apply SMALLINT DEFAULT 0,
    archive_file VARCHAR(500),
    status VARCHAR(30) DEFAULT '未开始',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_degree_apply (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    degree_type VARCHAR(30),
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '未申请',
    employment_company VARCHAR(200),
    employment_position VARCHAR(100),
    employment_type VARCHAR(30),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_paper_achievement (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    achievement_type VARCHAR(20),
    title VARCHAR(300),
    journal_level VARCHAR(30),
    publish_date DATE,
    patent_no VARCHAR(100),
    status VARCHAR(20),
    graduation_check SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== 2.4 研工管理 ====================
CREATE TABLE xc_scholarship (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    name VARCHAR(200),
    level VARCHAR(20),
    category VARCHAR(20),
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '审核中',
    certificate_print SMALLINT DEFAULT 0,
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_student_loan (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    loan_type VARCHAR(30),
    amount DECIMAL(10,2),
    bank VARCHAR(100),
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_leave_request (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    leave_type VARCHAR(10),
    reason TEXT,
    start_date DATE,
    end_date DATE,
    days INT,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_assist_post (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    post_name VARCHAR(200),
    department VARCHAR(100),
    post_type VARCHAR(10),
    apply_date DATE DEFAULT CURRENT_DATE,
    resign_reason TEXT,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_hardship (
    id BIGSERIAL PRIMARY KEY,
    student_id BIGINT NOT NULL,
    hardship_type VARCHAR(30),
    reason TEXT,
    apply_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT '审核中',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== 教师相关表 ====================
CREATE TABLE xc_teacher_course (
    id BIGSERIAL PRIMARY KEY,
    teacher_id BIGINT NOT NULL,
    course_name VARCHAR(200),
    class_name VARCHAR(200),
    hours INT,
    semester VARCHAR(20),
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE xc_research_project (
    id BIGSERIAL PRIMARY KEY,
    teacher_id BIGINT NOT NULL,
    project_name VARCHAR(300),
    source VARCHAR(100),
    fund DECIMAL(10,2),
    start_date DATE,
    deadline DATE,
    progress INT DEFAULT 0,
    status VARCHAR(20) DEFAULT '在研',
    deleted SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT NOW()
);

-- ==================== Seed Data ====================
INSERT INTO sys_user (username, password, real_name, role, college, major, grade) VALUES
('2023301001', '123456', '张三', 'student', '计算机学院', '计算机科学与技术', '2023'),
('T2023001', '123456', '李教授', 'teacher', '计算机学院', '计算机科学与技术', NULL),
('admin001', '123456', '系统管理员', 'admin', NULL, NULL, NULL),
('leader001', '123456', '校领导', 'leader', NULL, NULL, NULL);

INSERT INTO sys_dict (dict_type, dict_label, dict_value, sort_order) VALUES
('degree_type', '硕士', 'master', 1),
('degree_type', '博士', 'doctor', 2),
('gender', '男', '1', 1),
('gender', '女', '2', 2),
('course_type', '学位课', 'degree', 1),
('course_type', '选修课', 'elective', 2);

INSERT INTO xc_course_catalog (course_code, course_name, teachers, credits, hours, semester, class_name, location, schedule_time) VALUES
('CS601', '高级算法设计与分析', '李教授、张副教授', 3, 48, '2025-2026-2', '2023级计算机硕士班', '教学楼A301', '周一 8:00-10:25'),
('CS602', '机器学习理论', '王教授、赵讲师', 2, 32, '2025-2026-2', '2023级计算机硕士班', '教学楼B205', '周二 14:00-16:25'),
('EN501', '学术英语写作', '陈教授、刘副教授', 2, 32, '2025-2026-2', '2023级硕士英语A班', '外语楼301', '周三 10:00-12:25');

INSERT INTO xc_jiebang_task (title, category, publisher, deadline, status) VALUES
('智能交通流量预测模型研究', '科研攻关', '科技处', '2026-07-01', '招募中'),
('基于联邦学习的隐私保护方案', '技术创新', '信息安全中心', '2026-06-30', '进行中'),
('大规模知识图谱构建与应用', '科研攻关', '知识工程实验室', '2026-07-15', '进行中'),
('边缘计算资源调度优化', '技术创新', '云计算中心', '2026-05-20', '已完成'),
('多模态数据融合分析方法', '方法研究', '数据科学实验室', '2026-06-10', '进行中');
