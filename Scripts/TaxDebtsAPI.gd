extends Node

# TaxDebts Cloud Browser API
# This provides JavaScript functions that taxdebts.cloud can call to control the browser

@onready var gui = $/root/GUI

# Called when the node enters the scene tree
func _ready():
	print("TaxDebts Cloud Browser API Initialized")

# Open a URL in a new tab
func open_url(url: String):
	print("TaxDebts API: Opening URL in new tab: ", url)
	var browser = await gui.create_browser(url)
	if browser:
		gui.current_browser = browser
		return {"success": true, "message": "URL opened successfully"}
	return {"success": false, "message": "Failed to open URL"}

# Open a URL in the current tab
func navigate_to(url: String):
	print("TaxDebts API: Navigating to URL: ", url)
	if gui.current_browser:
		gui.current_browser.load_url(url)
		return {"success": true, "message": "Navigated successfully"}
	return {"success": false, "message": "No active browser"}

# Go back in history
func go_back():
	print("TaxDebts API: Going back")
	if gui.current_browser:
		gui.current_browser.previous_page()
		return {"success": true}
	return {"success": false}

# Go forward in history
func go_forward():
	print("TaxDebts API: Going forward")
	if gui.current_browser:
		gui.current_browser.next_page()
		return {"success": true}
	return {"success": false}

# Reload current page
func reload_page():
	print("TaxDebts API: Reloading page")
	if gui.current_browser:
		gui.current_browser.reload()
		return {"success": true}
	return {"success": false}

# Close current tab
func close_tab():
	print("TaxDebts API: Closing current tab")
	var tabs_overlay = gui.tabs_overlay
	if tabs_overlay and tabs_overlay.has_method("close_current_tab"):
		tabs_overlay.close_current_tab()
		return {"success": true}
	return {"success": false}

# Get current URL
func get_current_url() -> String:
	if gui.current_browser:
		return gui.current_browser.get_url()
	return ""

# Execute JavaScript in current page
func execute_javascript(js_code: String):
	print("TaxDebts API: Executing JavaScript")
	if gui.current_browser:
		gui.current_browser.execute_javascript(js_code)
		return {"success": true}
	return {"success": false}

# Get all open tabs
func get_tabs():
	var tabs = []
	for browser_id in gui.browsers.keys():
		var browser = gui.browsers[browser_id]
		tabs.append({
			"id": browser_id,
			"url": browser.get_url(),
			"title": browser.get_title()
		})
	return tabs

# Switch to a specific tab by ID
func switch_to_tab(tab_id: String):
	print("TaxDebts API: Switching to tab: ", tab_id)
	var browser = gui.get_browser(tab_id)
	if browser:
		gui.current_browser = browser
		return {"success": true}
	return {"success": false}

# Open DevTools (for debugging)
func open_devtools():
	print("TaxDebts API: Opening DevTools")
	if gui.current_browser:
		gui.current_browser.open_devtools()
		return {"success": true}
	return {"success": false}

# Set fullscreen mode
func set_fullscreen(enabled: bool):
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	return {"success": true, "fullscreen": enabled}

# Get browser info
func get_browser_info():
	return {
		"name": "TaxDebts Cloud Browser",
		"version": "1.0.0",
		"cef_version": gui.$CEF.get_full_version() if gui.$CEF else "Unknown",
		"tabs_count": gui.browsers.size()
	}

