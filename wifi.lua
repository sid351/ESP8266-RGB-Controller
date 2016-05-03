--ESP as Wifi CLIENT settings
wifi.setmode(wifi.STATION);
dofile(wifi-credentials.lua);
  --wifi-credentials.lua populates the ssid and password variables, example contents below:
  --ssid = "Network Name";
  --password = "Network Password";
wifi.sta.config(ssid, password);
wifi.sta.connect();

function startWiFiAP()
  --ESP as WifiAP settings
  wifi.setmode(wifi.SOFTAP);
  cfg={};
  cfg.ssid="RGB-Controller";
  cfg.pwd="LetThereBeLight";
  wifi.ap.config(cfg);
  end

function wifiFallback()
  --Method to determine if connected to a network, if not fall back to AP mode - More stable than STATIONAP method
  if wifi.sta.status() ~= 5 then startWiFiAP() end
  end

tmr.alarm(0,10000,0,wifiFallback());