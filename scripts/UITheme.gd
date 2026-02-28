extends Node

# Merkezi tema uygulayıcı - tüm sahneler bu AutoLoad'dan tema alır

static func apply_button_style(btn: Button, color: Color = Color(0.25, 0.35, 0.8)):
	var style_normal = StyleBoxFlat.new()
	style_normal.bg_color = color
	style_normal.corner_radius_top_left = 12
	style_normal.corner_radius_top_right = 12
	style_normal.corner_radius_bottom_left = 12
	style_normal.corner_radius_bottom_right = 12
	style_normal.content_margin_left = 16
	style_normal.content_margin_right = 16
	style_normal.content_margin_top = 10
	style_normal.content_margin_bottom = 10

	var style_hover = StyleBoxFlat.new()
	style_hover.bg_color = color.lightened(0.15)
	style_hover.corner_radius_top_left = 12
	style_hover.corner_radius_top_right = 12
	style_hover.corner_radius_bottom_left = 12
	style_hover.corner_radius_bottom_right = 12
	style_hover.content_margin_left = 16
	style_hover.content_margin_right = 16
	style_hover.content_margin_top = 10
	style_hover.content_margin_bottom = 10

	var style_pressed = StyleBoxFlat.new()
	style_pressed.bg_color = color.darkened(0.2)
	style_pressed.corner_radius_top_left = 12
	style_pressed.corner_radius_top_right = 12
	style_pressed.corner_radius_bottom_left = 12
	style_pressed.corner_radius_bottom_right = 12
	style_pressed.content_margin_left = 16
	style_pressed.content_margin_right = 16
	style_pressed.content_margin_top = 8
	style_pressed.content_margin_bottom = 8

	btn.add_theme_stylebox_override("normal", style_normal)
	btn.add_theme_stylebox_override("hover", style_hover)
	btn.add_theme_stylebox_override("pressed", style_pressed)
	btn.add_theme_color_override("font_color", Color.WHITE)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)

static func apply_panel_style(panel: PanelContainer, alpha: float = 0.5):
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.15, 0.18, 0.35, alpha)
	style.corner_radius_top_left = 16
	style.corner_radius_top_right = 16
	style.corner_radius_bottom_left = 16
	style.corner_radius_bottom_right = 16
	style.border_width_top = 1
	style.border_width_bottom = 1
	style.border_width_left = 1
	style.border_width_right = 1
	style.border_color = Color(0.4, 0.5, 0.9, 0.4)
	style.content_margin_left = 14
	style.content_margin_right = 14
	style.content_margin_top = 12
	style.content_margin_bottom = 12
	panel.add_theme_stylebox_override("panel", style)

static func apply_module_button_style(btn: Button, color: Color):
	var style_normal = StyleBoxFlat.new()
	style_normal.bg_color = Color(color.r, color.g, color.b, 0.25)
	style_normal.corner_radius_top_left = 18
	style_normal.corner_radius_top_right = 18
	style_normal.corner_radius_bottom_left = 18
	style_normal.corner_radius_bottom_right = 18
	style_normal.border_width_top = 2
	style_normal.border_width_bottom = 2
	style_normal.border_width_left = 2
	style_normal.border_width_right = 2
	style_normal.border_color = color
	style_normal.content_margin_left = 12
	style_normal.content_margin_right = 12
	style_normal.content_margin_top = 14
	style_normal.content_margin_bottom = 14

	var style_hover = StyleBoxFlat.new()
	style_hover.bg_color = Color(color.r, color.g, color.b, 0.45)
	style_hover.corner_radius_top_left = 18
	style_hover.corner_radius_top_right = 18
	style_hover.corner_radius_bottom_left = 18
	style_hover.corner_radius_bottom_right = 18
	style_hover.border_width_top = 2
	style_hover.border_width_bottom = 2
	style_hover.border_width_left = 2
	style_hover.border_width_right = 2
	style_hover.border_color = color.lightened(0.2)
	style_hover.content_margin_left = 12
	style_hover.content_margin_right = 12
	style_hover.content_margin_top = 14
	style_hover.content_margin_bottom = 14

	btn.add_theme_stylebox_override("normal", style_normal)
	btn.add_theme_stylebox_override("hover", style_hover)
	btn.add_theme_color_override("font_color", color.lightened(0.3))
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
