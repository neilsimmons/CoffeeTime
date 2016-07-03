function OnButtonPush()
    gpio.trig(6, "down", DoNothing)
    CoffeeTime()
    if not tmr.alarm(6, 600000, tmr.ALARM_SINGLE, function()
                                        gpio.trig(6, "down", OnButtonPush)
                                        print("Button Armed")
                                      end
                    )
    then print("re-arm timer failed")
    end
end

function DoNothing()
    --print("Button not armed")
end

gpio.mode(6, gpio.INT, gpio.PULLUP)
gpio.trig(6, "down", OnButtonPush)
gpio.mode(0,gpio.OUTPUT)
gpio.write(0,gpio.HIGH)
gpio.mode(1,gpio.OUTPUT)
gpio.write(1,gpio.HIGH)
gpio.mode(2,gpio.OUTPUT)
gpio.write(2,gpio.HIGH)
gpio.mode(3,gpio.OUTPUT)
gpio.write(3,gpio.HIGH)
gpio.mode(4,gpio.OUTPUT)
gpio.write(4,gpio.HIGH)

