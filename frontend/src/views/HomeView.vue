<template>
  <div class="home-view">
    <el-container>
      <el-header class="main-header">
        <div class="header-content">
          <div class="logo">泉州非遗</div>
          <el-menu
            mode="horizontal"
            :router="true"
            class="nav-menu"
            background-color="transparent"
            text-color="#fff"
            active-text-color="#ffd04b"
          >
            <el-menu-item index="/">首页</el-menu-item>
            <el-menu-item index="/ich">非遗瑰宝</el-menu-item>
            <el-menu-item index="/master">传承大师</el-menu-item>
            <el-menu-item index="/activity">社区活动</el-menu-item>
          </el-menu>
          <div class="user-actions">
            <el-button v-if="!isLoggedIn" type="text" @click="$router.push('/login')">登录</el-button>
            <el-button v-if="!isLoggedIn" type="primary" @click="$router.push('/register')">注册</el-button>
            <el-dropdown v-else>
              <span class="user-info">
                <i class="el-icon-user"></i>
                {{ username }}
              </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click.native="goToProfile">个人中心</el-dropdown-item>
                <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </div>
      </el-header>
      <router-view />
    </el-container>
  </div>
</template>

<script>
export default {
  name: 'HomeView',
  computed: {
    isLoggedIn() {
      return !!localStorage.getItem('token')
    },
    username() {
      return localStorage.getItem('username') || '用户'
    }
  },
  methods: {
    goToProfile() {
      this.$router.push('/user/profile')
    },
    logout() {
      localStorage.removeItem('token')
      localStorage.removeItem('username')
      this.$message.success('已退出登录')
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>
.home-view {
  min-height: 100vh;
}

.main-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 100%;
  max-width: 1400px;
  margin: 0 auto;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  color: #fff;
}

.nav-menu {
  flex: 1;
  margin: 0 40px;
  border: none;
}

.user-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.user-info {
  color: #fff;
  cursor: pointer;
}
</style>
