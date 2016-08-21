function initWifi(OnInit,ApNotFound)
    wifi.sta.eventMonReg(wifi.STA_GOTIP,OnInit)
    wifi.sta.eventMonReg(wifi.STA_APNOTFOUND,ApNotFound)
    wifi.sta.eventMonStart()
    wifi.setphymode(wifi.PHYMODE_G)
    wifi.setmode(wifi.STATION)
    wifi.sta.config(GlobalConfig.WifiSsid,GlobalConfig.WifiPassword)
    --wifi.sleeptype(wifi.LIGHT_SLEEP)
end
