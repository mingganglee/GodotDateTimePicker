extends PanelContainer


func show_time():
	$TimeButton.hide()
	$Time.show()

func hide_time():
	$TimeButton.show()
	$Time.hide()
