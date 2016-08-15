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
         end
ApNotFound = function()
                print("Can't find AP")
                dofile("initGpio.lc")
                SetLights("33333")
             end

initWifi(OnInit,ApNotFound)
