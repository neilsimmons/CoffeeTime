function OnButtonPush()
    gpio.trig(2, "down", DoNothing)
    CoffeeTime()
    if not tmr.alarm(timers.ButtonDebounce, 60000, tmr.ALARM_SINGLE, function()
                                        gpio.trig(2, "down", OnButtonPush)
                                        print("Button Armed")
                                      end
                    )
    then print("re-arm timer failed")
    end
end

function DoNothing()
    --print("Button not armed")
end


gpio.mode(2, gpio.INT, gpio.PULLUP)
gpio.trig(2, "down", OnButtonPush)


