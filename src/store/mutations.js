import axios from 'axios'
import * as types from './mutation-types'

export default {
  [types.AUTH_REQUEST] (state) {
    authRequest(state)
  },
  [types.IS_CONNECTED] (state, { code }) {
      isConnected(state, code)
  }
}

const authRequest = () => {
    window.location.href = 'https://oauth.bunq.com/auth?response_type=code&client_id=a2f281751f2cbc38891745428c97595763a2149250b877fc85496547e0a7d88e&redirect_uri=https://easylist.aule.net/'
}

const isConnected = (state, code) => {
    axios.get(`/backend?code=${code}`).then(() => {
        state.code = code
    });
}