populate_menu_tabs = ->	
	navbar = $('.category_menu')
	$.each property, (index, category)->
		navbar.append("<li index='#{index}'><a href='#'>#{category}</a></li>")
	navbar.find('li[index=7]').addClass('active')

populate_selects = ->
	from_select = $('select[name=from]')	
	to_select = $('select[name=to]')
	from_select.find('option').remove()
	to_select.find('option').remove()

	$.each unit[get_current_index()], (i, unit_option)->
		from_select.append("<option>#{unit_option}</option>")
		to_select.append("<option>#{unit_option}</option>")
	to_select.prop('selectedIndex', 1);

get_current_index = ->
	parseInt $('.category_menu').find('li.active').attr('index')

calculate = ->
	selected_from_unit_index = $('select[name=from]').prop('selectedIndex')
	selected_to_unit_index = $('select[name=to]').prop('selectedIndex')
	
	#TODO check if not -1
	if (selected_from_unit_index != -1 ) && (selected_to_unit_index != -1)
		from_factor = factor[get_current_index()][selected_from_unit_index]
		to_factor = factor[get_current_index()][selected_to_unit_index]
		result = ($('input[name=how_many_from]').val() * from_factor) / to_factor
		$('input[name=how_many_to]').val(result)

$ ->
	populate_menu_tabs()
	populate_selects()
	$('input[name=how_many_from]').val('1')
	calculate()
	$('.category_menu a').click( ->
		$('.category_menu li.active').removeClass('active')
		$(this).parent().addClass('active')
		populate_selects()
		$('input[name=how_many_from]').val('1')
		calculate()
		return false
	)

	$('button.go').click( -> calculate() )

