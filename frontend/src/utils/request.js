import axios from 'axios'
import Vue from 'vue'
import { Message } from 'element-ui'

const request = axios.create({
  baseURL: 'http://localhost:8080/api',
  timeout: 10000
})

request.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

request.interceptors.response.use(
  response => {
    if (response.status === 200) {
      return response.data
    } else {
      Message.error('请求失败')
      return Promise.reject(response)
    }
  },
  error => {
    if (error.response) {
      switch (error.response.status) {
        case 401:
          Message.error('未授权，请登录')
          Vue.prototype.$router.push('/login')
          break
        case 403:
          Message.error('拒绝访问')
          break
        case 404:
          Message.error('请求错误，未找到该资源')
          break
        case 500:
          Message.error('服务器错误')
          break
        default:
          Message.error(error.response.data.message || '未知错误')
      }
    } else {
      Message.error('网络错误')
    }
    return Promise.reject(error)
  }
)

export default request
