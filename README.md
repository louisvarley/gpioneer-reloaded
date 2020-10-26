## GPIOneer Reloaded

GPIOneed Reloaded is a continuation of the GPIO Controller [GPIOneer](https://github.com/mholgatem/gpioneer) created by mholgatem. 

[GPIOnext](https://github.com/mholgatem/GPIOnext) was created as a sucessor to [GPIOneer](https://github.com/mholgatem/gpioneer) however. Personally i found [GPIOnext](https://github.com/mholgatem/GPIOnext) much harder to install, to configure and less reliable. Going back to [GPIOneer](https://github.com/mholgatem/gpioneer) again and again for it's simplicity and useful web interface. 

GPIOneer-Reloaded is my attempt at further developing the GPIOneer code base to add new features and provide updates for better longevity. 

### Whats New?
- [x] Original Project Renamed
- [x] Add Blocking Pin feature to web and code
- [x] Remove piplay intergration (why)
- [ ] All code to Python3
- [ ] Updated Installation process
- [ ] New web interface look and feel
- [ ] Web interface configuration manager
- [ ] Move all saved settings to database
- [ ] Remove terminal configuration
- [ ] Choose alternative web interface port during install
- [ ] Add various system commands to available pin commands

### Installation

    cd ~
    git clone https://github.com/louisvarley/gpioneer-reloaded.git
    bash gpioneer-reloaded/install.sh

Follow the onscreen instructions. 

### Configuration 

Once installed, the installation will confirm the URL for your web interface. The Web interface is your goto place to configure your pins. 

GPIOneer-reloaded as foregone any terminal based configuration for a single, easy to use, web interface. 

### Web Interface
The web interface runs on port 8080. 
Within the Web Interface there are a number of configurations you can make including. 

###### [](https://github.com/louisvarley/gpioneer-reloaded#global-options)Global Options
-   combo_time 'Time in milliseconds to wait for combo buttons'
-   key_repeat 'Delay in milliseconds before key repeat'
-   key_delay 'Delay in milliseconds between key presses'
-   debounce 'Time in milliseconds for button debounce'
-   pulldown 'Use PullDown resistors instead of PullUp'
-   poll_rate 'Rate to poll pins after IRQ detect'

###### [](https://github.com/louisvarley/gpioneer-reloaded#global-options)Pin Options
-   pins 'Comma delimited pin numbers to watch'
-   command 'Key or Command do you wish to assign to this key'
-   blocking '[see blocking pins](https://github.com/louisvarley/gpioneer-reloaded#blocking-pins)'


#### [](https://github.com/louisvarley/gpioneer-reloaded#blocking-pins)Blocking Pins
Blocking pins is a useful feature to address what may be a hardware issue with a software solution. 


Blocking allows for the blocking of some button inputs while others are being held down. 

**Example** using 4 buttons instead of a traditional D PAD, you wish to not allow, when pressing **DOWN** the **LEFT**, **RIGHT** and **DOWN** buttons to be registered. 

To do this, each pin used for direction would have every other direction pin added to its Blocked Pins list. 

