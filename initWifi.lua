function initWifi(OnInit)
    wifi.sta.eventMonReg(wifi.STA_GOTIP,OnInit)
    wifi.sta.eventMonStart()
    wifi.setmode(wifi.STATION)
    wifi.sta.config(GlobalConfig.WifiSsid,GlobalConfig.WifiPassword)
    --cfg={
    --ssid=GlobalConfig.LocalWifiSsid,
    --pwd=GlobalConfig.LocalWifiPassword,
    --auth=AUTH_WPA2_PSK
    --}
    --wifi.ap.config(cfg)
end
