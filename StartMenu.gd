extends Control


func _on_join_button_pressed():
	get_parent().start_client($VBoxContainer/JoinBox/JoinIp.text)


func _on_host_button_pressed():
	get_parent().start_server()
