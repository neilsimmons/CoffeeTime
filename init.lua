--dofile("compileAll.lc")
dofile("config.lc")
dofile("initWifi.lc")
dofile("gmail.lc")
dofile("Coffee.lc")
SetLights("55555")
Booted = 0
OnInit = function()
            print("wifi started")
            dofile("initGpio.lc")
            SetLights("12345")
            if (Booted == 0) then
                code, reason = node.bootreason()
                message = "Boot code:" .. code .. "Boot reason:" .. reason
                send_email("CoffeeTimerBootReason",message, "nsimmons@genetec.com")
                Booted = 1
            end
         end
ApNotFound = function()
                print("Can't find AP")
                dofile("initGpio.lc")
                SetLights("33333")
             end

initWifi(OnInit,ApNotFound)

