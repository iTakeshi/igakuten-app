$ ->
    $(document).on 'click', '.shift-cell-body', ->
        $shiftCell = $(@).closest('.shift-cell')
        if $shiftCell.hasClass 'active'
            $shiftCell.removeClass 'active'
        else
            $(@).closest('.index_table').find('.active').removeClass 'active'
            $(@).closest('.shift-cell').addClass 'active'

    $(document).on 'click', '.selector-close', ->
        $(@).closest('.shift-cell').removeClass 'active'
