$(document).ready ->

  # https://wiki.openmrs.org/display/docs/Check+Digit+Algorithm
  checkDigit = (value) ->
    stringValue = value.toString()
    length      = stringValue.length

    resultString = ''
    for i in [length-1..0]
      even = ((length-1 - i) % 2 == 0)

      if even
        resultString = (parseInt(stringValue[i]) * 2).toString() + resultString
      else
        resultString = stringValue[i] + resultString

    resultSum = 0
    for i in [0..resultString.length-1]
      resultSum += parseInt(resultString[i])

    10 - (resultSum % 10)

  calculateCodabar = (value) ->
    stringValue = value.toString()
    stringValue = stringValue.slice(-7)

    while (stringValue.length < 7)
      stringValue = "0" + stringValue

    result = "233870" + stringValue

    check = checkDigit(result)

    result + check.toString()

  $("input[name='codabar_input']").each ->
    $(this).on "keyup", (event) =>
      $output = $(this).parent().next().find('p')

      $output.html(calculateCodabar($(event.currentTarget).val()))
