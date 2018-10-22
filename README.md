# smbt (Save MacOS Browser Tabs) 

A script written in Applescript to save links and titles of all the tabs open in your browser.  
Currently, only Google Chrome and Safari are supported in this script.

### Requirements
* Requires `osascript` in your MacOS to run the script  

## Usage
* First clone this repo and after entering into it.  
* Open the script by double clcking on the file, provide the path to save your links in line where it's written    
    * ` property safariPath : [PROVIDE_THE_PATH_HERE_FOR_SAFARI_TABS] `  
    * ` property chromePath : [PROVIDE_THE_PATH_HERE_FOR_CHROME_TABS] `  
* Run 
```
  osascript smbt.applescript [Name_of_browser]
```
* For example to save your tabs of "Safari", run  
` osascript smbt.applescript "Safari" ` 

* Similarly for "Google Chrome", run  
` osascript smbt.applescript "Google Chrome" ` 

## Features left to implement
* Add support for Firefox.  
* Feature to support dynamic path to store files, which the user can give as an argument.  

## Contributing
* Feel free to fix any bug, or implement any new feature.  
* Steps for contributing
  * Clone this repo
  * Edit and test the script in "Script Editor" Application, preinstalled in MacOS.  
  * Run the script as given in the running instructions above.  
  * Send a PR :tada: .  

