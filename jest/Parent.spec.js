import { shallowMount } from '@vue/test-utils'
import Parent from '../components/Parent.vue'
import Child from '../components/Child.vue'

describe('Parent.vue', () => {
  it('renders 3 Child components', () => {
    const wrapper = shallowMount(Parent)
    expect(wrapper.findAll(Child).length).toBe(3)
  })

  it('renders 3 Child components', () => {
    const wrapper = shallowMount(Parent)
    expect(wrapper.findAll(Child).length).toBe(3)
  })
})
