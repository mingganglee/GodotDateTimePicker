extends VBoxContainer


var number_of_rows = 7
var number_of_columns = 6
const week_names = [ 
		"Sunday", "Monday", "Tuesday", "Wednesday", 
		"Thursday", "Friday", "Saturday" ]

var top_node
var first_day_of_month


func _ready():
	top_node = $"../../../../../"
	$"../../".connect("current_date_changed", self, "refresh_by_datetime")


func refresh_by_datetime(datetime: Dictionary):
	first_day_of_month = Tools.Date.date_converted_to_first_day_of_month(datetime)
	refresh()


func refresh():
	clear()
	generate_calender()


func clear():
	for child in get_children():
		child.queue_free()


func generate_day_button(datetime: Dictionary):
	var btn = Button.new()
	btn.rect_min_size = Vector2(55, 45)
	btn.text = "%02d" % datetime.day
	btn.connect("pressed", get_node("../../../../../"), "set_datetime", [datetime])
#	btn.connect("pressed", get_node("../../../../"), "grab_focus")
	
	if datetime.month != first_day_of_month.month:
		btn.add_color_override("font_color_focus", "#514f56")
		btn.add_color_override("font_color", "#514f56")
		btn.add_color_override("font_color_pressed", "#409eff")
	
	if datetime.year == top_node.datetime.year and datetime.month == top_node.datetime.month and datetime.day == top_node.datetime.day:
		btn.add_color_override("font_color_focus", "#409eff")
		btn.add_color_override("font_color", "#409eff")
		btn.add_color_override("font_color_hover", "#409eff")
		btn.add_color_override("font_color_pressed", "#409eff")
	
	return btn


func generate_weeks():
	var weeks = HBoxContainer.new()
	weeks.add_constant_override("separation", 0)
	weeks.alignment = BoxContainer.ALIGN_CENTER
	for week in week_names:
		var label = Label.new()
		label.align = Label.ALIGN_CENTER
		label.valign = Label.VALIGN_CENTER
		label.rect_min_size = Vector2(55, 35)
		label.text = tr(week)
		weeks.add_child(label)
	add_child(weeks)


func generate_days(calender_start_date: Dictionary):
	for col in range(number_of_columns):
		var hbox = HBoxContainer.new()
		hbox.add_constant_override("separation", 0)
		hbox.alignment = BoxContainer.ALIGN_CENTER
		for row in range(number_of_rows):
			var date = Tools.Date.datetime_to_next_day(calender_start_date, col * number_of_rows + row)
			hbox.add_child(generate_day_button(date))
		add_child(hbox)


func generate_calender():
	var calender_start_date = Tools.Date.datetime_to_prev_day(first_day_of_month, first_day_of_month.weekday)
	generate_weeks()
	generate_days(calender_start_date)
