extends "res://Scripts/Pickup.gd"

var conditionSettings = preload("res://WeaponsAndEquipmentConditions/ConditionSettings.tres")

func UpdateTooltip():
	if slotData.itemData == null:
		return

	if slotData.itemData.showAmount:
		gameData.tooltip = slotData.itemData.name + " [" + "x" + str(slotData.amount) + "]"
	else:
		gameData.tooltip = slotData.itemData.name

		if slotData.itemData.carrier and slotData.nested.size() != 0:
			for nested in slotData.nested:
				if nested.plate:
					gameData.tooltip = slotData.itemData.name + " [" + nested.rating + "]"
					break

	gameData.tooltip += _build_condition_text()

	if slotData.itemData.file == "Cat" and gameData.catDead:
		gameData.tooltip += " (RIP)"

func _build_condition_text() -> String:
	if not conditionSettings.conditionEnabled:
		return ""

	if not _should_show_condition():
		return ""

	return " " + _format_condition(slotData.condition)

func _should_show_condition() -> bool:
	if slotData.itemData.showCondition:
		return true

	if slotData.itemData.type == "Rig" and slotData.nested.size() != 0:
		for nested in slotData.nested:
			if nested.type == "Armor":
				return true

	return false

func _format_condition(value: float) -> String:
	var color := "green"
	if value <= 25:
		color = "red"
	elif value <= 50:
		color = "yellow"

	return "[color=%s](%s%%)[/color]" % [color, str(int(round(value)))]
