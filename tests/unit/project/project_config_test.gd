## Example suite: guards the engine decisions recorded by /setup-engine
## (project.yaml engine block). Copy this layout for real systems.
extends GdUnitTestSuite

const EXPECTED_NAME := "Bonefire"
const EXPECTED_RENDERER := "mobile"


func test_application_name_matches_project_name() -> void:
	# Arrange
	var key := "application/config/name"

	# Act
	var value: String = ProjectSettings.get_setting(key, "")

	# Assert
	assert_str(value).is_equal(EXPECTED_NAME)


func test_rendering_method_is_mobile_renderer() -> void:
	# Arrange
	var key := "rendering/renderer/rendering_method"

	# Act
	var value: String = ProjectSettings.get_setting(key, "")

	# Assert
	assert_str(value).is_equal(EXPECTED_RENDERER)
