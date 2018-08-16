import { shallowMount } from '@vue/test-utils'
import { expect } from 'chai'
import Basic from '../components/Basic5.vue'

describe('Basic.vue', () => {
  it('displays correct test', () => {
    const wrapper = shallowMount(Basic)
    expect(wrapper.find('div h1').text()).to.equal('Welcome to Your Vue.js App')
  })
})
