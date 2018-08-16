import { shallowMount } from '@vue/test-utils'
import Basic from '../components/Basic4.vue'

describe('Basic.vue', () => {
  it('displays correct test', () => {
    const wrapper = shallowMount(Basic)
    expect(wrapper.find('div h1').text()).toEqual('Welcome to Your Vue.js App')
  })
})
