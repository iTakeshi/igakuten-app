$ ->
    $(document).on 'click', '.shift-cell-body', ->
        $(@).closest('.index_table').find('.active').removeClass 'active'
        $(@).closest('.shift-cell').toggleClass 'active'

    $(document).on 'click', '.selector-close', ->
        $(@).closest('.shift-cell').removeClass 'active'
