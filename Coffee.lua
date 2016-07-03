function AllLights()
    tmr.unregister(5)
    gpio.write(0,gpio.LOW)
    gpio.write(1,gpio.LOW)
    gpio.write(2,gpio.LOW)
    gpio.write(3,gpio.LOW)
    gpio.write(4,gpio.LOW)
end

function FourLights()
    tmr.unregister(5)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.LOW)
    gpio.write(2,gpio.LOW)
    gpio.write(3,gpio.LOW)
    gpio.write(4,gpio.LOW)
end

function ThreeLights()
    tmr.unregister(5)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.HIGH)
    gpio.write(2,gpio.LOW)
    gpio.write(3,gpio.LOW)
    gpio.write(4,gpio.LOW)
end

function TwoLights()
    tmr.unregister(5)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.HIGH)
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.LOW)
    gpio.write(4,gpio.LOW)
end

function OneLights()
    tmr.unregister(5)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.HIGH)
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    gpio.write(4,gpio.LOW)
end

function OneLightFlashing(FlashDelay)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.HIGH)
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    gpio.write(4,gpio.LOW)
    lightOn = true
    if not tmr.alarm(5, FlashDelay, tmr.ALARM_AUTO, function()
                                                if lightOn then
                                                    gpio.write(4,gpio.HIGH)
                                                    lightOn = false
                                                else
                                                    gpio.write(4,gpio.LOW)
                                                    lightOn = true
                                                end                                                   
                                                    
                                              end
                    )
    then
        print("Flash Timer Failed")
    end

end

function NoLights()
    tmr.unregister(5)
    gpio.write(0,gpio.HIGH)
    gpio.write(1,gpio.HIGH)
    gpio.write(2,gpio.HIGH)
    gpio.write(3,gpio.HIGH)
    gpio.write(4,gpio.HIGH)
end
            
function CoffeeTime()
    StartMinutes = 60
    Minutes = StartMinutes
    LightTime = StartMinutes / 6
    
    print ("Coffee Timer Started")
    send_email("Coffee was brewed","Someone just pressed the brewed coffee button")
    AllLights()
    if not tmr.alarm(1, 60000, tmr.ALARM_AUTO, function()
                                                    if Minutes > (LightTime * 5) then
                                                        AllLights()
                                                        Minutes = Minutes - 1
                                                    elseif Minutes > (LightTime * 4) then
                                                        FourLights()
                                                        Minutes = Minutes - 1
                                                    elseif Minutes > (LightTime * 3) then
                                                        ThreeLights()
                                                        Minutes = Minutes - 1
                                                    elseif Minutes > (LightTime * 2) then
                                                        TwoLights()
                                                        Minutes = Minutes - 1
                                                    elseif Minutes > (LightTime) then
                                                        OneLights()
                                                        Minutes = Minutes - 1
                                                    elseif Minutes <= (LightTime) then
                                                        OneLightFlashing(200)
                                                        Minutes = Minutes - 1
                                                    elseif Minutes == 0 then
                                                        OneLightFlashing(3000)
                                                        tmr.unregister(1)
                                                    end
                                               end
                                              ) 
    then
        print("Coffee Timer failed")
    end

end

