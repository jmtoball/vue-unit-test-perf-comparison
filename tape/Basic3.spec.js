import { shallowMount } from '@vue/test-utils'
import test from 'tape'
import Basic from '../components/Basic3.vue'

test('Basic.vue', t => {
  t.plan(1)
  const wrapper = shallowMount(Basic)
  t.equal(wrapper.find('div h1').text(), 'Welcome to Your Vue.js App')
})
