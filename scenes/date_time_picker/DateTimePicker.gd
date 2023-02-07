extends Control


enum PopPosition {
	Left,
	Right,
	Top,
	Bottom
}

signal datetime_changed(date)

export(PopPosition) var pop_position: = PopPosition.Bottom

var datetime: Dictionary setget set_datetime


func set_datetime(new_date: Dictionary):
	datetime = new_date
	self.text = Tools.Date.datetime_to_ymdhms(datetime)
	$PickerPopup/LineEdit.text = self.text
	emit_signal("datetime_changed", datetime)


func _ready():
	set_datetime(OS.get_datetime())


func _on_DateTimePicker_focus_entered():
	# 解决 LineEdit focus 触发两次的问题(点击 popup 外的区域隐藏时会触发第二次)
	release_focus()
	$PickerPopup.popup()
	# 取消 popup 内部 LineEdit 光标焦点 (解决弹窗时无法控制焦点位置问题)
	$PickerPopup/LineEdit.release_focus()
	
	match pop_position:
		PopPosition.Left:
			$PickerPopup.pop_position_to_left()
		PopPosition.Right:
			$PickerPopup.pop_position_to_right()
		PopPosition.Top:
			$PickerPopup.pop_position_to_top()
		PopPosition.Bottom:
			$PickerPopup.pop_position_to_bottom()


func _on_DateTimePicker_text_entered(new_text):
	var new_datetime = Tools.Date.datetime_string_to_datetime(new_text)
	
	if new_datetime.month <= 0 or new_datetime.month > 12:
		prints("输入月份 <= 0 或 > 12")
		return
	elif new_datetime.day <= 0 or new_datetime.day > Tools.Date.get_days_in_month(new_datetime.month, new_datetime.year):
		prints("输入天 <= 0 或 >  %d" % Tools.Date.get_days_in_month(new_datetime.month, new_datetime.year))
		return
	elif new_datetime.hour < 0 or new_datetime.hour >= 24:
		prints("输入月份 < 0 或 >= 24")
		return
	elif new_datetime.minute < 0 or new_datetime.minute >= 60:
		prints("输入月份 < 0 或 >= 60")
		return
	elif new_datetime.second < 0 or new_datetime.second >= 60:
		prints("输入月份 < 0 或 >= 60")
		return
	else:
		set_datetime(new_datetime)
