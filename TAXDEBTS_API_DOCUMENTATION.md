# TaxDebts Cloud Browser API Documentation

## Overview

This browser is specifically built for **taxdebts.cloud** and provides a JavaScript API that allows your website to control the browser without leaving the taxdebts.cloud environment.

## Features

- **Fullscreen by Default**: Browser opens in fullscreen mode to taxdebts.cloud
- **Custom Navigation**: Open external links in new tabs without leaving taxdebts.cloud
- **Tab Management**: Create, close, and switch between tabs programmatically
- **Seamless Integration**: All external links automatically open within the browser
- **TaxDebts Cloud Theme**: Browser UI uses your color scheme (rgb(42, 51, 65))

## JavaScript API

The browser injects a global `window.TaxDebtsBrowser` object that you can use from your taxdebts.cloud website.

### Check if Running in TaxDebts Browser

```javascript
if (window.TaxDebtsBrowser && window.TaxDebtsBrowser.isTaxDebtsBrowser()) {
    console.log("Running in TaxDebts Cloud Browser");
}
```

### API Methods

#### 1. Open URL in New Tab

Opens a URL in a new tab within the browser.

```javascript
// Open a URL in a new tab
window.TaxDebtsBrowser.openUrl('https://example.com');

// Example: Open a client's document
window.TaxDebtsBrowser.openUrl('https://docs.example.com/client-123');
```

#### 2. Navigate Current Tab

Navigate the current tab to a different URL.

```javascript
// Navigate current tab
window.TaxDebtsBrowser.navigateTo('https://example.com');

// Example: Navigate to a specific case
window.TaxDebtsBrowser.navigateTo('https://taxdebts.cloud/case/456');
```

#### 3. Browser Navigation

Control browser back/forward/reload actions.

```javascript
// Go back in history
window.TaxDebtsBrowser.goBack();

// Go forward in history
window.TaxDebtsBrowser.goForward();

// Reload current page
window.TaxDebtsBrowser.reload();
```

#### 4. Tab Management

```javascript
// Close current tab
window.TaxDebtsBrowser.closeTab();
```

#### 5. Get Current URL

```javascript
// Get the current URL
var currentUrl = window.TaxDebtsBrowser.getCurrentUrl();
console.log('Current URL:', currentUrl);
```

#### 6. Fullscreen Control

```javascript
// Enter fullscreen
window.TaxDebtsBrowser.setFullscreen(true);

// Exit fullscreen
window.TaxDebtsBrowser.setFullscreen(false);
```

#### 7. Open External Links

This is the most useful method for your CRM. It allows you to open external websites without the user leaving taxdebts.cloud.

```javascript
// Open in new tab (default)
window.TaxDebtsBrowser.openExternal('https://irs.gov/client-portal', true);

// Open in current tab
window.TaxDebtsBrowser.openExternal('https://irs.gov/client-portal', false);
```

#### 8. Get Browser Info

```javascript
var info = window.TaxDebtsBrowser.getBrowserInfo();
console.log('Browser:', info.name);
console.log('Version:', info.version);
```

## Automatic Link Interception

The browser automatically intercepts certain types of links:

### window.open() Interception

All `window.open()` calls are automatically redirected to open in a new tab within the browser:

```javascript
// This will automatically open in a new tab within the browser
window.open('https://example.com', '_blank');
```

### Links with target="_blank"

All links with `target="_blank"` are intercepted and opened within the browser:

```html
<!-- This will open in a new tab within the browser -->
<a href="https://example.com" target="_blank">External Link</a>
```

## Usage Examples

### Example 1: View Client Documents

```javascript
function viewClientDocuments(clientId) {
    var documentUrl = `https://documents.example.com/client/${clientId}`;
    
    if (window.TaxDebtsBrowser) {
        // Opens in new tab within the browser
        window.TaxDebtsBrowser.openExternal(documentUrl);
    } else {
        // Fallback for regular browsers
        window.open(documentUrl, '_blank');
    }
}
```

### Example 2: Open IRS Portal

```javascript
function openIRSPortal(accountNumber) {
    if (window.TaxDebtsBrowser) {
        var irsUrl = `https://www.irs.gov/account/${accountNumber}`;
        window.TaxDebtsBrowser.openUrl(irsUrl);
    }
}
```

### Example 3: Navigate Between CRM Sections

```javascript
function navigateToSection(section) {
    if (window.TaxDebtsBrowser) {
        window.TaxDebtsBrowser.navigateTo(`https://taxdebts.cloud/${section}`);
    } else {
        window.location.href = `https://taxdebts.cloud/${section}`;
    }
}
```

### Example 4: Handle External Links in Your UI

```javascript
document.addEventListener('DOMContentLoaded', function() {
    // Add click handler to all external links
    document.querySelectorAll('a[data-external]').forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            var url = this.getAttribute('href');
            
            if (window.TaxDebtsBrowser) {
                window.TaxDebtsBrowser.openExternal(url);
            } else {
                window.open(url, '_blank');
            }
        });
    });
});
```

HTML:
```html
<a href="https://irs.gov" data-external>IRS Website</a>
<a href="https://taxforms.com" data-external>Tax Forms</a>
```

### Example 5: Custom Toolbar Buttons

```javascript
// Add custom toolbar with browser controls
function createBrowserToolbar() {
    if (!window.TaxDebtsBrowser) return;
    
    var toolbar = document.createElement('div');
    toolbar.innerHTML = `
        <button onclick="window.TaxDebtsBrowser.goBack()">← Back</button>
        <button onclick="window.TaxDebtsBrowser.goForward()">Forward →</button>
        <button onclick="window.TaxDebtsBrowser.reload()">↻ Reload</button>
        <button onclick="window.TaxDebtsBrowser.closeTab()">✕ Close Tab</button>
    `;
    document.body.prepend(toolbar);
}
```

## Browser Keyboard Shortcuts

The browser also supports keyboard shortcuts (these work automatically):

- `Ctrl + L` - Open address bar / search
- `Ctrl + T` - Show tabs overlay
- `Ctrl + W` - Close current tab
- `Ctrl + N` - New tab
- `Ctrl + H` - Go to home (taxdebts.cloud)
- `Ctrl + R` - Reload page
- `Ctrl + Alt + A` - Go back
- `Ctrl + Alt + D` - Go forward
- `Ctrl + S` - Open settings
- `Ctrl + I` - Show info/shortcuts

## Color Scheme

The browser UI uses your TaxDebts Cloud color scheme:

**Light Mode:**
- Background: `rgb(245, 247, 255)`
- Primary: `rgb(42, 51, 65)`
- Accent: `rgb(194, 33, 105)`

**Dark Mode:**
- Background: `rgb(6, 5, 40)`
- Primary: `rgb(248, 248, 248)`
- Accent: `rgb(185, 129, 250)`

## Building the Application

### Requirements

- Godot Engine 4.x
- CEF (Chromium Embedded Framework) artifacts from [gdcef](https://github.com/Lecrapouille/gdcef/releases/tag/v0.12.1-godot4)

### Setup

1. Clone the repository
2. Download CEF artifacts and extract to project root
3. Open project in Godot Engine
4. Run or export the project

### Export for Windows

1. Open project in Godot
2. Go to `Project > Export...`
3. Select `Windows Desktop`
4. Click `Export Project`

The exported application will open fullscreen to taxdebts.cloud.

## Support

For technical support or questions about the browser API, please contact the development team.

## Changelog

### Version 1.0.0
- Initial release
- Fullscreen mode by default
- TaxDebts Cloud Browser API
- Automatic link interception
- Tab management
- TaxDebts Cloud color scheme integration

