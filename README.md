# macOS Ambient Lighting
 
This project lets you create your own Ambient Lighting (just like Ambilight) for your Mac, using an Arduino microcontroller (e.g. Arduino, ESP8266) and LED-Strips supported by FastLED (e.g. WS2812B)

I have searched a lot for solutions like this, but I couldn't find any for macOS that weren't outdated. I think there are plenty of alternatives for Windows.

# Setup

The possibilities to configurate the Ambient Lighting are currently limited and have to be hard coded.

In the Arduino sketch you only have to cconfigure your LED-Strip. All necessay data is at the top of the file in defines, just enter you configuration there.

Setting up the App might be a little bit more complicated, I'm still working on a GUI for the setup.

So far this projects only supports splitting the screen in equally distributed lines an columns and choosing the right image to process for each LED by hardcoding it's coordinate (where x is the column number and y the row number).

To get this running, two changes have to be done in `AmbientLightingPreview` :
1. Replace the 'serialPortPath' with your serial port path
2. Create your own configuration (or adjust the one in the examples) to match your LEDs.

# Color Correction

Color correction is very important to get the Ambient Light to match your screen.

So far two ways to correct the colors are implemented:
1. SaturationCorrection: The color is transformed to HSV, then the saturation is adjusted using gamma correction. The color is (as required) return as CGColor.
2. ChannelScaleCorrection: Here you can set max values for r,g and b (as RGB), the colors will then be (linear) scaled down to fit in the range.

Color correction can also be chained behind each other, what I highly recommend. I personally use a saturation correction with `gamma = 0.3` and ChannelScaleCorrection with `maxValues = RGB(red: 1, green: 0.7, blue: 0.3` 

ColorCorrection can optionally be added to the AmbientLightingCreator

# TODO

I'm currently working on:
1. GUI to select serial port
2. Manually removing black bars
3. Black Bar detection
4. Storing /Retrieving configartions
5. Custom image splitting
6. Improved ImageReducer

Future features I think about:
- USB Video Grabber as ImageSource
- HTTP Output to control ESP-based lights
