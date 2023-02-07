extends VBoxContainer


func _on_DateButton_pressed():
	$DatePanel.show_date()
	$TimePanel.hide_time()


func _on_TimeButton_pressed():
	$DatePanel.hide_date()
	$TimePanel.show_time()

