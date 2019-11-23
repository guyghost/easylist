import * as types from './mutation-types'

export const authRequest = ({
  commit
}, payload) => {
  commit(types.AUTH_REQUEST, payload)
}

export const logout = ({
  commit
}, payload) => {
  commit(types.LOGOUT, payload)
}

export const isConnected = ({
    commit
}, payload) => {
    commit(types.IS_CONNECTED, payload)
}
