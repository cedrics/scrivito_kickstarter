# When in-place editing is active and the editor is in an editable working copy, check if the
# iframe widget is configured properly or otherwise display an error message.

$ ->
  errorMessageTemplate = (headline, message) ->
    template = $('<div></div>')
      .addClass('alert')
      .addClass('alert-danger')

    headline = $('<h4></h4>')
      .text(headline)
      .appendTo(template)

    text = $(message)
      .appendTo(template)

    template

  displayErrorMessage = (headline, message) ->
    widget = $('.iframe-widget')
    iframe = widget.find('iframe')

    # Only display the error message when the iframe is missing or the error message already exists.
    unless iframe.length || widget.find('.alert').length
      errorMessageTemplate(headline, message).appendTo(widget)

  headline = 'Iframe widget'
  message = "<p>You don't have a <strong>source</strong> URL set. Please use the
    <strong>Widget properties</strong> to set it.</p>"

  scrivito.on 'content', ->
    if scrivito.in_editable_view()
      displayErrorMessage(headline, message)
