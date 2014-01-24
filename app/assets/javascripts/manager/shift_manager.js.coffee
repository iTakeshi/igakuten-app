$ ->
    $(document).on 'click', '.shift-cell-body', ->
        $(@).closest('.shift-cell').toggleClass 'active'

    $(document).on 'click', '.selector-close', ->
        $(@).closest('.shift-cell').removeClass 'active'
