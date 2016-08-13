--dofile("compileAll.lc")
dofile("config.lc")
dofile("initWifi.lc")
dofile("gmail.lc")
dofile("Coffee.lc")
SetLights("55555")
OnInit = function()
            print("wifi started")
            dofile("initGpio.lc")
            SetLights("12345")
            wifi.sleeptype(wifi.LIGHT_SLEEP)
        end

initWifi(OnInit)
