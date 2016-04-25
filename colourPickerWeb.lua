--Web page setup
web=net.createServer(net.TCP)
web:listen(80,function(conn)
    conn:on("receive", function(client,request)
        body = "<h1>Colour Controller</h1>";
        
        --Determine if a changeColours has been sent to us
        colourChange = {string.match(request,"GET.*changeColours.Picker.*23(%x%x%x%x%x%x).*HTTP.*")};

        if colourChange ~= nil and #colourChange > 0 then 
          --Postback need to use new colours
          pickerHex = "#" .. colourChange[1];  --The input control expects a prefixed #
          
          --Split and convert pickerHex to RGB decimal values for determining the PWM duty values
          red = tonumber(string.sub(pickerHex,2,3),16);
          green = tonumber(string.sub(pickerHex,4,5),16);
          blue = tonumber(string.sub(pickerHex,6,7),16);
          
          --Update the RGB LED's using the pwmConversionFactor
          setRGB(redPin, red * pwmConversionFactor, greenPin, green * pwmConversionFactor, bluePin, blue * pwmConversionFactor);
        else
          --Get the PWM Colour code
          pwmValues = readRGBValue(redPin, greenPin, bluePin);
          
          --Reverse pwmConversionFactor (to get true RGB values) and convert to Hex for pickerHex
          pickerHex = "#" .. valueToHexRgb(pwmValues.red, pwmConversionFactor) .. valueToHexRgb(pwmValues.green, pwmConversionFactor) .. valueToHexRgb(pwmValues.blue, pwmConversionFactor);
        end

        body = body.."<form action='changeColours'>"
        body = body.."<input type='color' name='Picker' id='html5colorpicker' onchange='clickColor(0, -1, -1, 5)' value='" .. pickerHex .. "' style='width:500;height:500;'><br/><br/>";
        body = body.."<input type='submit' value='Submit' style='width:500;height:250;'>"
        body = body.."</form>"
        
        client:send(body);
        client:close();
        collectgarbage();
    end)
end)    
