extends Node

var conditionSettings = preload("res://WeaponsAndEquipmentConditions/ConditionSettings.tres")
var McmHelpers = load("res://ModConfigurationMenu/Scripts/Doink Oink/MCM_Helpers.tres")

var config = ConfigFile.new()

const FILE_PATH = "user://MCM/WeaponsAndEquipmentConditions"
const MOD_ID = "WeaponsAndEquipmentConditions"

func _ready() -> void:
	config.set_value("Bool", "conditionEnabled", {
		"name" = "Show Weapons and Equipment Conditions - Enabled",
		"tooltip" = "",
		"default" = true,
		"value" = true
	})


	if McmHelpers != null:
		conditionSettings.mcmHelpers = McmHelpers
		if !FileAccess.file_exists(FILE_PATH + "/config.ini"):
			DirAccess.open("user://").make_dir(FILE_PATH)
			config.save(FILE_PATH + "/config.ini")
		else:
			McmHelpers.CheckConfigurationHasUpdated(MOD_ID, config, FILE_PATH + "/config.ini")
			config.load(FILE_PATH + "/config.ini")

		_on_waec_config_updated(config)

		McmHelpers.RegisterConfiguration(
			MOD_ID,
			"Weapons and Equipment Conditions",
			FILE_PATH,
			"Weapons and Equipment Conditions",
			{
				"config.ini" = _on_waec_config_updated
			}
		)

func _on_waec_config_updated(_config: ConfigFile):
	print("Weapons and Equipment Conditions config updated")

	conditionSettings.conditionEnabled = _config.get_value("Bool", "conditionEnabled")["value"]
	
	conditionSettings.mcmEnabled = true
