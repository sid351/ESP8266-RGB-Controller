-- Wifi functions
wifi.setmode(wifi.STATIONAP)

--ESP as Wifi CLIENT settings
ssid = "SSID"
password = "PASSWORD"
wifi.sta.config(ssid, password)
wifi.sta.connect()

--ESP as WifiAP settings
cfg={}
cfg.ssid="RGB-Controller"
cfg.pwd="LetThereBeLight"
wifi.ap.config(cfg)
