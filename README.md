
# macOS Ambient Lighting
 
This project lets you create your own Ambient Lighting (just like Ambilight) for your Mac, using an Arduino microcontroller (e.g. Arduino, ESP8266) and LED-Strips supported by FastLED (e.g. WS2812B)

I have searched a lot for solutions like this, but I couldn't find any for macOS that weren't outdated. I think there are plenty of alternatives for Windows.

# Setup

The setup can be done using the GUI:
1. Setup the Image Source: So far only ScreenCapture is supported, you can select witch display should be used. HDMI Grabber Support to be added soon).
<img src="https://user-images.githubusercontent.com/44832123/132138923-82100a41-2b08-441d-83d1-391c2ec36093.png" alt="drawing" width="300"/>
2. Setup the Splitter: So far only Grid Splitter is supported. More customizble variations to be added soon.
<img src="https://user-images.githubusercontent.com/44832123/132138924-b7a62fb6-6a5c-47f7-9fd5-aa2bc2ffa6bf.png" alt="drawing" width="300"/>
3. Setup Color Correction:
<img src="https://user-images.githubusercontent.com/44832123/132138806-f5b8beca-3f5b-409c-b571-03a0999c7f26.png" alt="drawing" width="300"/>
Linear Correction and Saturation can freely be combined.
4. Setup the Light Output: So far only Serial Output is supoorted. Port and Baud Rate can be selected an the port needs to be opened in order to start the communication. Controlling devices via URL-Request to be added soon.
<img src="https://user-images.githubusercontent.com/44832123/132138800-97830f5e-4078-4697-b3c4-60ade24d16be.png" alt="drawing" width="300"/>
