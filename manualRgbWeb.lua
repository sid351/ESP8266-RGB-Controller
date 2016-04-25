--Web page setup
web=net.createServer(net.TCP)
web:listen(80,function(conn)
    conn:on("receive", function(client,request)
        body = "<h1> ESP8266 Colour Controller</h1>";
        
        -- obtain current RGB values
        rgbValues = readRGBValue(redPin, greenPin, bluePin)

        --parse request values - signifies a change has come in
            --request looks like GET /changeColours?red=257&green=256&blue=276 HTTP/1.1
            --Overwrite rgbValues table as that is used in the body displayed to the user
        postback = false;
        colourChange = {string.match(request,"GET.*changeColours.*red=(%d+).*green=(%d+).*blue=(%d+).*HTTP.*")}
        if colourChange~=nill
            then if #colourChange > 0
                then
                --Need to add handler for numbers over 1023
                rgbValues.red = colourChange[1];
                rgbValues.green = colourChange[2];
                rgbValues.blue = colourChange[3];
                postback = true;
                end
            end

        if postback then setRGB(redPin, rgbValues.red, greenPin, rgbValues.green, bluePin, rgbValues.blue) end

        --print(request);
        
        body = body.."<form action='changeColours'>"
        body = body.."<p> Red = <input type='text' name='red' size=10 autofocus value='" .. rgbValues.red .. "'> </p>"
        body = body.."<p> Green = <input type='text' name='green' size=10 autofocus value='" .. rgbValues.green .. "'> </p>"
        body = body.."<p> Blue = <input type='text' name='blue' size=10 autofocus value='" .. rgbValues.blue .. "'> </p>"
        body = body.."<input type='submit' value='Submit'>"
        body = body.."</form>"
                   
        client:send(body);
        client:close();
        collectgarbage();
    end)
end)    