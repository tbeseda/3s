$ ->
  $('#the-files li a').click ->
    $.getJSON '/url', filename: $(@).data('key'), (response) ->
      window.prompt 'Your URL, sir; it\'s good for 1 month:', response.url
