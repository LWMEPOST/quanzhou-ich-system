# 福建泉州非遗传承文化展示与推荐系统

## 项目简介
本项目旨在利用 SpringBoot + Vue2 技术栈，构建一个集非遗展示、活动管理、智能推荐于一体的综合平台。

## 目录结构
- `backend`: 后端项目 (Spring Boot 2.7 + MyBatis Plus)
- `frontend`: 前端项目 (Vue 2 + Element UI)
- `db`: 数据库脚本

## 快速开始

### 1. 环境准备
- JDK 1.8+ (推荐 JDK 11)
- Maven 3.6+
- Node.js 14+
- MySQL 8.0+
- Redis

### 2. 数据库初始化
1. 登录 MySQL: `mysql -u root -p`
2. 执行脚本：`source db/schema.sql`

### 3. 后端启动
```bash
cd backend
mvn clean install
mvn spring-boot:run
```
启动成功后访问：http://localhost:8080

### 4. 前端启动
```bash
cd frontend
npm install
npm run serve
```
启动成功后访问：http://localhost:8081

## 核心功能
1. **非遗展示**: 视频、图文详情。
2. **智能推荐**: 基于用户行为标签的混合推荐算法。
3. **数据可视化**: ECharts 展示热门非遗与用户画像。

## 技术栈
- **后端**: Spring Boot 2.7, MyBatis Plus, MySQL 8.0, Redis
- **前端**: Vue 2, Element UI, Axios
- **特色**: 基于用户行为的智能推荐系统

## 项目截图
- 首页展示泉州非遗文化
- 非遗瑰宝列表与详情
- 传承大师展示
- 社区活动管理
- 用户行为监控与数据可视化

## License
GPL-3.0
