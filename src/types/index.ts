export type RoleType = 'student' | 'teacher' | 'admin' | 'leader'

export interface UserInfo {
  id: number
  username: string
  realName: string
  role: RoleType
  college?: string
  major?: string
  grade?: string
  avatar?: string
}

export interface MenuItem {
  path: string
  name: string
  title: string
  icon?: string
  children?: MenuItem[]
  meta?: {
    hidden?: boolean
    roles?: RoleType[]
  }
}

export interface Notification {
  id: number
  title: string
  date: string
  read: boolean
  category: 'notice' | 'todo'
}

export interface TodoItem extends Notification {
  status: 'pending' | 'done' | 'ignored'
}

export interface ApiResponse<T = unknown> {
  code: number
  msg: string
  data: T
}
