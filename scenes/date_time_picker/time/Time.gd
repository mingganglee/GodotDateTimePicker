extends HBoxContainer


const hour_second = 3600
const minute_second = 60
const one_second = 1


var long_pressed = null


func refresh(date: Dictionary):
	$Hour/Value.text = "%02d" % date.hour
	$Minute/Value.text = "%02d" % date.minute
	$Second/Value.text = "%02d" % date.second


func _on_hms_changed(second):
	var new_date = Tools.Date.datetime_offset_second($"../../../../".datetime, second)
	$"../../../../".datetime = new_date


func _ready():
	$Hour/Add.connect("button_down", self, "_on_button_down", [hour_second])
	$Hour/Subtract.connect("button_down", self, "_on_button_down", [-hour_second])
	$Hour/Add.connect("button_up", self, "_on_button_up")
	$Hour/Subtract.connect("button_up", self, "_on_button_up")
	
	$Minute/Add.connect("button_down", self, "_on_button_down", [minute_second])
	$Minute/Subtract.connect("button_down", self, "_on_button_down", [-minute_second])
	$Minute/Add.connect("button_up", self, "_on_button_up")
	$Minute/Subtract.connect("button_up", self, "_on_button_up")
	
	$Second/Add.connect("button_down", self, "_on_button_down", [one_second])
	$Second/Subtract.connect("button_down", self, "_on_button_down", [-one_second])
	$Second/Add.connect("button_up", self, "_on_button_up")
	$Second/Subtract.connect("button_up", self, "_on_button_up")
	
	$"../../../../".connect("datetime_changed", self, "refresh")


func _process(delta):
	if long_pressed != null:
		long_pressed.timeout -= delta
		if long_pressed.timeout <= 0:
			long_pressed.count += 1
			long_pressed.timeout = 0.1
			_on_hms_changed(long_pressed.value)


func _on_button_down(value):
	long_pressed = {
		"value": value,
		"timeout": 0.5,
		"count": 0
	}


func _on_button_up():
	if long_pressed.count == 0:
		_on_hms_changed(long_pressed.value)
	
	long_pressed = null
