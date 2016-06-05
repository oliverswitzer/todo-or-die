$(document).ready(function() {
  $('select').material_select();

  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });

  var wordCountSliderElement = document.getElementById('word-count-slider');

  noUiSlider.create(wordCountSliderElement, {
    start: 0,
    connect: 'lower',
    step: 250,
    range: {
      min: 0,
      max: 10000
    },
    format: {
      to: function(value) {
        if(value > 0) {
          return (value / 1000);
        } else {
          return 0;
        }
      },
      from: function(value) {
        if(value > 0) {
          return (value / 1000);
        } else {
          return 0;
        }
      }
    }
  });

  var wordCountValue = $("<input style='display:none' id='word-count-value'>");
  var wordCountDisplay = $("<span id='word-count-text'/>");

  wordCountValue.appendTo(wordCountSliderElement);
  wordCountDisplay.appendTo(wordCountSliderElement);

  wordCountSliderElement.noUiSlider.on('update', function (countValue) {
    wordCountValue.val(countValue);
    wordCountDisplay.html(countValue + "K words");
  });

});
