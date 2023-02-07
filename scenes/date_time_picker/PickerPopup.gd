extends Popup


func pop_position_to_left():
	$Picker.rect_position = Vector2.ZERO
	$LineEdit.rect_position = Vector2($Picker.rect_size.x + 5, 0)
	
	rect_global_position = $"..".rect_global_position - $LineEdit.rect_position
	rect_size.x = $Picker/DatePanel.rect_size.x + $LineEdit.rect_size.x + 5
	rect_size.y = $Picker/DatePanel.rect_size.y + $Picker/TimePanel.rect_size.y


func pop_position_to_right():
	
	$LineEdit.rect_position = Vector2.ZERO
	$Picker.rect_position = Vector2($LineEdit.rect_size.x + 5, 0)
	
	rect_global_position = $"..".rect_global_position
	rect_size.x = $Picker/DatePanel.rect_size.x + $LineEdit.rect_size.x + 5
	rect_size.y = $Picker/DatePanel.rect_size.y + $Picker/TimePanel.rect_size.y


func pop_position_to_top():
	$Picker.rect_position = Vector2.ZERO
	$LineEdit.rect_position = Vector2(0, $Picker/DatePanel.rect_size.y + $Picker/TimePanel.rect_size.y + 5)
	
	rect_global_position = $"..".rect_global_position - $LineEdit.rect_position
	rect_size.x = $Picker/DatePanel.rect_size.x
	rect_size.y = $Picker/DatePanel.rect_size.y + $Picker/TimePanel.rect_size.y + $LineEdit.rect_size.y + 5


func pop_position_to_bottom():
	$LineEdit.rect_position = Vector2.ZERO
	$Picker.rect_position = Vector2(0, $LineEdit.rect_size.y + 5)
	
	rect_global_position = $"..".rect_global_position
	rect_size.x = $Picker/DatePanel.rect_size.x
	rect_size.y = $Picker/DatePanel.rect_size.y + $Picker/TimePanel.rect_size.y + $LineEdit.rect_size.y + 5


func picker_popup_resized():
	
	if $"../".pop_position == $"../".PopPosition.Left:
		pop_position_to_left()
	elif $"../".pop_position == $"../".PopPosition.Right:
		pop_position_to_right()
	elif $"../".pop_position == $"../".PopPosition.Top:
		pop_position_to_top()
	elif $"../".pop_position == $"../".PopPosition.Bottom:
		pop_position_to_bottom()


func _on_DatePanel_resized():
	picker_popup_resized()


func _on_TimePanel_resized():
	picker_popup_resized()


func _on_PickerPopup_focus_entered():
	hide()


func _on_PickerPopup_about_to_show():
	$Picker._on_DateButton_pressed()


func _on_PickerPopup_popup_hide():
	get_parent()._on_DateTimePicker_text_entered($LineEdit.text)
