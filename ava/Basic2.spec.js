import { shallowMount } from '@vue/test-utils'
import test from 'ava'
import Basic from '../components/Basic2.vue'

test('Basic.vue', t => {
  const wrapper = shallowMount(Basic)
  t.is(wrapper.find('div h1').text(), 'Welcome to Your Vue.js App')
})
