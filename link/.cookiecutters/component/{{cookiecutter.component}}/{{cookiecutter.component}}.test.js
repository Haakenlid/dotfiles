import {{cookiecutter.component}} from './index'
import renderer from 'react-test-renderer'

describe('{{cookiecutter.component}}', () => {
  test('renders correctly', () => {
    const tree = renderer.create(<{{cookiecutter.component}} />).toJSON()
    expect(tree).toEqual(expect.any(Object))
    expect(tree).toMatchSnapshot()
  })
})
