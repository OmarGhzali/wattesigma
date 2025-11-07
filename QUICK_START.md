# TaxDebts Cloud Browser - Quick Start Guide

## Overview

This browser is specifically built for taxdebts.cloud and provides seamless integration with your CRM platform.

## Features at a Glance

✅ Opens fullscreen to taxdebts.cloud automatically  
✅ Custom JavaScript API for browser control  
✅ Open external links without leaving your CRM  
✅ Automatic link interception (window.open, target="_blank")  
✅ TaxDebts Cloud color theme applied to browser UI  
✅ Tab management  
✅ Keyboard shortcuts  

## Building the Application

### Prerequisites

1. **Godot Engine 4.x**
   - Download from: https://godotengine.org/

2. **CEF Artifacts** (Chromium Embedded Framework)
   - Download from: https://github.com/Lecrapouille/gdcef/releases/tag/v0.12.1-godot4
   - Get the appropriate version for your OS:
     - Windows: `gdcef-artifacts-godot_4-windows_x86_64.zip`
     - Linux: `gdcef-artifacts-godot_4-linux_x86_64.tar.gz`

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-repo/wattesigma.git
   cd wattesigma
   ```

2. **Extract CEF artifacts**
   - Extract the downloaded CEF artifacts to the project root
   - You should have a `cef_artifacts` folder in the root directory
   - Your folder structure should look like:
     ```
     wattesigma/
     ├── cef_artifacts/
     ├── Assets/
     ├── Scripts/
     ├── Scenes/
     ├── Shaders/
     └── ...
     ```

3. **Open in Godot**
   - Launch Godot Engine
   - Click "Import"
   - Navigate to the wattesigma folder
   - Select `project.godot`
   - Click "Import & Edit"

4. **Test Run**
   - Press F5 or click the Play button
   - The browser should open fullscreen to taxdebts.cloud

### Export for Distribution

#### Windows

1. In Godot, go to `Project > Export...`
2. Click `Add...` and select `Windows Desktop`
3. If prompted to download export templates, click `Download and Install`
4. Configure export settings:
   - Name: `TaxDebtsCloudBrowser.exe`
   - Export Path: Choose your desired location
5. Click `Export Project`
6. **Important**: The exported `.exe` must stay in the project folder with all assets and `cef_artifacts`

#### Linux

1. In Godot, go to `Project > Export...`
2. Click `Add...` and select `Linux/X11`
3. Download export templates if needed
4. Configure and export
5. The binary will be in the root folder (e.g., `CEFgd.x86_64`)

## Using the API from TaxDebts.cloud

### Quick Test

Save this HTML file and open it in the browser to test the API:

```html
<!DOCTYPE html>
<html>
<head>
    <title>API Test</title>
</head>
<body>
    <h1>TaxDebts Browser API Test</h1>
    <button onclick="testAPI()">Test API</button>
    
    <script>
        function testAPI() {
            if (window.TaxDebtsBrowser) {
                alert('TaxDebts Browser API is available!');
                window.TaxDebtsBrowser.openExternal('https://irs.gov');
            } else {
                alert('Not running in TaxDebts Browser');
            }
        }
    </script>
</body>
</html>
```

### Common Use Cases

#### 1. Open IRS Portal for Client

```javascript
function openIRSForClient(clientSSN) {
    if (window.TaxDebtsBrowser) {
        const url = `https://www.irs.gov/account/${clientSSN}`;
        window.TaxDebtsBrowser.openExternal(url);
    }
}
```

#### 2. View External Documents

```javascript
function viewDocument(documentUrl) {
    if (window.TaxDebtsBrowser) {
        // Opens in new tab within the browser
        window.TaxDebtsBrowser.openUrl(documentUrl);
    } else {
        // Fallback for regular browsers
        window.open(documentUrl, '_blank');
    }
}
```

#### 3. Navigate Between CRM Sections

```javascript
function navigateToDashboard() {
    if (window.TaxDebtsBrowser) {
        window.TaxDebtsBrowser.navigateTo('https://taxdebts.cloud/dashboard');
    } else {
        window.location.href = 'https://taxdebts.cloud/dashboard';
    }
}
```

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl + L` | Open address bar / search |
| `Ctrl + T` | Show tabs overlay |
| `Ctrl + W` | Close current tab |
| `Ctrl + N` | New tab |
| `Ctrl + H` | Go to home (taxdebts.cloud) |
| `Ctrl + R` | Reload page |
| `Ctrl + Alt + A` | Go back |
| `Ctrl + Alt + D` | Go forward |
| `Ctrl + S` | Open settings |
| `Ctrl + I` | Show info/shortcuts |

## Configuration

The browser is pre-configured for taxdebts.cloud with:

- **Home Page**: https://taxdebts.cloud
- **Primary Color**: rgb(42, 51, 65) - TaxDebts Cloud brand color
- **Fullscreen Mode**: Enabled by default
- **Window Size**: 1920x1080 (when not fullscreen)

To change these settings, edit `project.godot` and `Scripts/CEF.gd`.

## Troubleshooting

### Browser won't start

1. **Check CEF artifacts**
   - Ensure `cef_artifacts` folder exists in project root
   - Verify all DLLs are present

2. **Check Godot version**
   - Use Godot 4.x (tested with 4.3)
   - GDCef requires Godot 4.x

3. **Check console output**
   - Run from Godot Editor to see error messages
   - Look for CEF initialization errors

### API not working

1. **Check browser detection**
   ```javascript
   console.log('TaxDebtsBrowser available:', 
               typeof window.TaxDebtsBrowser !== 'undefined');
   ```

2. **Check console for injection errors**
   - Open browser DevTools
   - Look for JavaScript errors

3. **Verify page has loaded**
   - API is injected after page load
   - Use DOMContentLoaded event

### Links not opening in browser

1. **Check if using target="_blank"**
   - Links with target="_blank" are automatically intercepted
   - Use `window.TaxDebtsBrowser.openUrl()` explicitly

2. **Check window.open() override**
   - window.open() should be intercepted automatically
   - If not working, use API directly

## Support Files

- **Full API Documentation**: `TAXDEBTS_API_DOCUMENTATION.md`
- **Interactive Test Page**: `TAXDEBTS_API_EXAMPLE.html`
- **Main README**: `README.md`

## Next Steps

1. Build the application following the steps above
2. Test with the example HTML file (`TAXDEBTS_API_EXAMPLE.html`)
3. Integrate the API into your taxdebts.cloud website
4. Deploy to your team

## Contact

For technical support or questions, contact your development team.

---

**Built with ❤️ for TaxDebts Cloud CRM**

