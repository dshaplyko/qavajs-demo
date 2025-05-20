### Action Steps
I open {string} url  
I type {string} to {string}  
I type {string} chars to {string}  
I click {string}  
I clear {string}  
I click {string} text in {string} collection  
I switch to {int} window  
I switch to {string} window  
I open new tab  
I close current tab  
I refresh page  
I press {string} key  
I press {string} key {int} time(s)  
I hover over {string}  
I select {string} option from {string} dropdown  
I select {int}(st|nd|rd|th) option from {string} dropdown  
I will wait for alert/dialog  
I accept alert  
I dismiss alert  
I type {string} to alert  
I upload {string} file to {string}  
I scroll by {string}  
I scroll to {string}  
I scroll by {string} in {string}  
I drag and drop {string} in {string}  
I define {string} as {string} locator  
I press {playwrightMouseButton} mouse button  
I release {playwrightMouseButton} mouse button  
I move mouse to {string}  
I scroll mouse wheel by {string}  
I hold down {string} key  
I release {string} key  
I click {playwrightBrowserButton} button  
I upload {string} file by clicking {string} step by  
I set window size {string}  
I click {string} coordinates in {string}  
I grant {string} permission  
I revoke browser permissions  
I set {string} geolocation  
I save file to {string} by clicking {string}  
I force click {string}  

### Validation Steps
I expect {string} (to be visible|to be present|to be invisible|to be disabled|to be in viewport)  
I expect number of elements in {string} collection to be (equal|above|below) {string}  
I expect text of {string} to (be equal|contain|not match) {string}  
I expect value of {string} to (be equal|contain|not match) {string}  
I expect {string} property of {string} to (be equal|contain|not match) {string}  
I expect {string} attribute of {string} to (be equal|contain|not match) {string}  
I expect current url to (be equal|contain|not match) {string}  
I expect page title to (be equal|contain|not match) {string}  
I expect every element in {string} collection (to be visible|to be present|to be invisible|to be disabled|to be in viewport)  
I expect text of every element in {string} collection to (be equal|contain|not match) {string}  
I expect {string} attribute of every element in {string} collection to (be equal|contain|not match) {string}  
I expect {string} property of every element in {string} collection to (be equal|contain|not match) {string}  
I expect {string} css property of {string} to (be equal|contain|not match) {string}  
I expect text of alert to (be equal|contain|not match) {string}  

### Memory Steps
I save text of {string} as {string}  
I save {string} property of {string} as {string}  
I save {string} attribute of {string} as {string}  
I save number of elements in {string} collection as {string}  
I save text of every element of {string} collection as {string}  
I save {string} attribute of every element of {string} collection as {string}  
I save {string} property of every element of {string} collection as {string}  
I save current url as {string}  
I save page title as {string}  
I save {string} css property of {string} as {string}  
I save screenshot as {string}  
I save full page screenshot as {string}  
I save screenshot of {string} as {string}  
I save bounding rect of {string} as {string}  

### Wait Steps
I refresh page until {string} (to be visible|to be present|to be invisible|to be disabled|to be in viewport) (timeout: {number})  
I refresh page until text of {string} to (be equal|contain|not match) {string} (timeout: {number})  

### Execute Steps
I execute {string} function  
I execute {string} function and save result as {string}  
I execute {string} function on {string}  
I execute {string} function on {string} and save result as {string}  

### Cookie Steps
I set {string} cookie as {string}  
I save value of {string} cookie as {string}  

## Parameter Types
`{playwrightCondition}`: one of: to be visible, to be present, to be invisible, to be disabled, to be in viewport  
`{playwrightMouseButton}`: one of: left, right, middle  
`{playwrightBrowserButton}`: one of: back, forward  
`{playwrightTimeout}`: optional timeout, e.g. (timeout: 3000)  
`{validation}`: to be equal, to contain, not to match, etc.  