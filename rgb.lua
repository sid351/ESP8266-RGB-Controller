--RGB Functions
redPin = 1
greenPin = 2
bluePin = 6

function initRGB(redPin, greenPin, bluePin, clock, duty)
    pwm.setup(redPin, clock, duty)
    pwm.setup(bluePin, clock, duty)
    pwm.setup(greenPin, clock, duty)
    pwm.start(redPin)
    pwm.start(bluePin)
    pwm.start(greenPin)
    end

function setRGB(redPin, redValue, greenPin, greenValue, bluePin, blueValue)
    pwm.setduty(redPin, redValue)
    pwm.setduty(greenPin, greenValue)
    pwm.setduty(bluePin, blueValue)
    end

function readRGBValue(redPin, greenPin, bluePin)
    rgbValue={}
    rgbValue.red = pwm.getduty(redPin)
    rgbValue.green = pwm.getduty(greenPin)
    rgbValue.blue = pwm.getduty(bluePin)
    return rgbValue
    end

function valueToHexRgb(value, pwmConversionFactor)
  output = value / pwmConversionFactor;
  
  if output == 0 
    then output = "00";
  else 
    output = string.format("%x",output);
  end
  
  return output;
  end
