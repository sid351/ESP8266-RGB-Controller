--Using integer firmware multiplying RGB by 4 is as good as setting the PWM as a percentage of RGB -- EXAMPLE -- pwmValue = (rgbValue / 255) * 1023
pwmConversionFactor = 4;

--Set default colour to 
defaultRGB = {}
defaultRGB.red = 179;
defaultRGB.green = 0;
defaultRGB.blue = 179;

--Setup the Wifi
dofile("wifi.lua")

--pull in RGB functions
dofile("rgb.lua")
    --Initialise PWN with LED's off at 500hz
    initRGB(redPin, greenPin, bluePin, 500, 0)
    
    --Turn LEDs on to default colour
    setRGB(redPin, defaultRGB.red * pwmConversionFactor, greenPin, defaultRGB.green * pwmConversionFactor, bluePin, defaultRGB.blue * pwmConversionFactor)

--set up the webpage
dofile("colourPickerWeb.lua")
