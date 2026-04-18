extends "res://Scripts/HUD.gd"

var rich_tooltip: RichTextLabel = null

func _ready():
	super()
	await get_tree().process_frame

	if label and rich_tooltip == null:
		rich_tooltip = RichTextLabel.new()
		rich_tooltip.name = "ModRichTooltip"

		rich_tooltip.position = label.position
		rich_tooltip.size = label.size
		rich_tooltip.anchor_left = label.anchor_left
		rich_tooltip.anchor_top = label.anchor_top
		rich_tooltip.anchor_right = label.anchor_right
		rich_tooltip.anchor_bottom = label.anchor_bottom
		rich_tooltip.offset_left = label.offset_left
		rich_tooltip.offset_top = label.offset_top
		rich_tooltip.offset_right = label.offset_right
		rich_tooltip.offset_bottom = label.offset_bottom

		rich_tooltip.bbcode_enabled = true
		rich_tooltip.scroll_active = false
		rich_tooltip.fit_content = true
		rich_tooltip.autowrap_mode = TextServer.AUTOWRAP_OFF
		rich_tooltip.clip_contents = false
		rich_tooltip.mouse_filter = Control.MOUSE_FILTER_IGNORE

		if "theme" in label:
			rich_tooltip.theme = label.theme
		if "theme_type_variation" in label:
			rich_tooltip.theme_type_variation = label.theme_type_variation

		add_child(rich_tooltip)
		move_child(rich_tooltip, label.get_index() + 1)

		label.visible = false

func _physics_process(_delta):
	if Engine.get_physics_frames() % 10 == 0 and !gameData.isTransitioning:

		if FPS.visible:
			frames.text = str(Engine.get_frames_per_second())

		if rich_tooltip:
			rich_tooltip.bbcode_text = str(gameData.tooltip)
			rich_tooltip.visible = gameData.interaction and !gameData.transition

		tooltip.visible = gameData.interaction and !gameData.transition
		transition.visible = gameData.transition and !gameData.interaction and !gameData.isPlacing and !gameData.isInserting
		oxygen.visible = gameData.isSwimming
		permadeath.visible = gameData.permadeath or gameData.difficulty == 3
		magazine.visible = gameData.isChecking
		chamber.visible = gameData.isChecking
		malfunction.visible = gameData.jammed
		magnet.visible = gameData.magnet

		if gameData.decor:
			if showDecor or gameData.tutorial:
				decor.show()
				stats.hide()
		else:
			decor.hide()
			stats.show()

		if !gameData.decor and gameData.isPlacing:
			if showPlacement or gameData.tutorial:
				placement.show()
				stats.hide()
		elif !gameData.decor:
			placement.hide()
			stats.show()
