import Vue from 'vue'
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
    window.location.href = 'https://oauth.bunq.com/auth?response_type=code&client_id=88ad9f89f0081f7d17a9552a7ff8403b48882a521dcd5a7d7229aab16e721386&redirect_uri=https://easylist.aule.net/'
}

const isConnected = (state, code, guid) => {
  if (guid) {
    state.guid = guid;
  } else {
    axios.get(`/backend?code=${code}`).then(response => {
      state.code = code;
      state.guid = response.data.guid;
      Vue.cookie.set("guid", state.guid, 90);
    });
  }
  state.connected = true;
};