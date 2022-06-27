// Reference: https://gist.github.com/djD-REK/2e347f5532bb22310daf450f03ec6ad8
const round = (number, decimalPlaces) => {
  const factorOfTen = Math.pow(10, decimalPlaces)
  return Math.round(number * factorOfTen) / factorOfTen
}

console.log(round(0.2345, 3)) // 0.235
