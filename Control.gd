extends Control



func _init():
	TranslationServer.set_locale('zh')


func _ready():
	$DateTimePicker.connect("datetime_changed", self, "datetime_changed")

func datetime_changed(datetime):
	print(datetime)
