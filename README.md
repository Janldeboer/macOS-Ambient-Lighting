# macOS Ambient Lighting
 
This project lets you create your own Ambient Lighting (just like Ambilight) for your Mac, using an Arduino microcontroller (e.g. Arduino, ESP8266) and LED-Strips supported by FastLED (e.g. WS2812B)

I have searched a lot for solutions like this, but I couldn't find any for macOS that weren't outdated. I think there are plenty of alternatives for Windows.

# Setup

The setup can be done using the GUI:
1. Setup the Image Source: So far only ScreenCapture is supported, you can select witch display should be used. HDMI Grabber Support to be added soon).
2. Setup the Splitter: So far only Grid Splitter is supported. More customizble variations to be added soon.
3. Setup the Light Outpur: So far only Serial Output is supoorted. Port and Baud Rate can be selected an the port needs to be opened in order to start the communication. Controlling devices via URL-Request to be added soon.

# Color Correction

Color correction is currently not available, but will soon be added again with GUI support.
