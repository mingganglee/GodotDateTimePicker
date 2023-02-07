extends PanelContainer


signal current_date_changed(date)


var current_date: Dictionary setget set_current_date


func set_current_date(new_date: Dictionary):
	current_date = new_date
	emit_signal("current_date_changed", new_date)
	$Date/Control/Current/Year.text = "%d %s" % [new_date.year, tr("Year")]
	$Date/Control/Current/Month.text = "%02d %s" % [new_date.month, tr("Month")]


func _ready():
	$"../../../".connect("datetime_changed", self, "set_current_date")


func show_date():
	$DateButton.hide()
	$Date/Days.refresh_by_datetime(get_node("../../../").datetime)
	$Date.show()


func hide_date():
	$DateButton.show()
	$Date.hide()
	$Date/Days.clear()


func prev_year():
	set_current_date(Tools.Date.datetime_to_prev_year(current_date))


func next_year():
	set_current_date(Tools.Date.datetime_to_next_year(current_date))


func prev_month():
	set_current_date(Tools.Date.datetime_to_prev_month(current_date))


func next_month():
	set_current_date(Tools.Date.datetime_to_next_month(current_date))
