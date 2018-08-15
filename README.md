# Vue Unit Test Performance Comparison

This is a performance comparison between test runners testing Vue SFCs.

## Comparison

| Runner         | 1 test     | 10 tests   | 100 tests  | 1000 tests | memory     |
| :------------- | :--------- | :--------- | :--------- | :--------- | :--------- |
| tape           | 1.55     s | 1.56     s | 2.01     s | 6.06     s | 239372.00  |
| jest           | 2.27     s | 2.80     s | 4.60     s | 21.67    s | 170020.00  |
| mocha-webpack  | 2.37     s | 2.40     s | 3.04     s | 8.28     s | 253648.00  |
| karma-mocha    | 8.31     s | 8.88     s | 14.50    s | 22.19    s | 2160518.66 |
| ava            | 3.74     s | 5.90     s | 29.85    s | 280.78   s | 123810.66  |

## Details

The tests use two SFC. You can see the tests inside the runner directories.

The time is the average of 10 runs.

## Results

Currently tape is the fastest.

AVA is by far the slowest. This is because the [current suggested method](https://github.com/avajs/ava/blob/master/docs/recipes/precompiling-with-webpack.md) does not utilize caching. If caching was added, it would be comparable to Jest.

## Usage

Running the test script will generate a results table in RESULTS.md:

```
npm test
```

**Warning: It takes around 5 minutes to run**

## Contributing

Feel free to add an extra test setup. The aim of this project is to find the best setup out there.

### Add a new setup
* Create directory with a descriptive name, using test template below
* Add `Basic.spec.js` file with 30 tests
* Create a `test` script in your package.json
* Add name of directory to `test_runners` array in `test.sh`
* Run tests from the root by running `npm test`

### Test template
Copy this and change the syntax to match your test runner.
```js
it('renders correct text', () => {
  const wrapper = shallow(Basic)
  expect(wrapper.find('.hello h1').text()).toBe('Welcome to Your Vue.js App')
})
```
