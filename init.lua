dofile("compileAll.lc")
dofile("config.lc")
dofile("initWifi.lc")
dofile("gmail.lc")
dofile("Coffee.lc")

OnInit = function()
            print("wifi started")
            dofile("initGpio.lc")
            OneLightFlashing(3000)
        end

initWifi(OnInit)
 
