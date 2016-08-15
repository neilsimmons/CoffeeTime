function OneLightFlashing(FlashDelay)
    tmr.unregister(5)
    lightOn = true
    if not tmr.alarm(5, FlashDelay, tmr.ALARM_AUTO, function()
                                                if lightOn then
                                                    
                                                    lightOn = false
                                                else
                                                    
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
end

function SetLights(code)
    colours = {
           [0] = string.char(5,0,255,0), --green
           [1] = string.char(5,0,255,255), --yellow
           [2] = string.char(5,0,125,255), --orange
           [3] = string.char(5,0,0,255), --red
           [4] = string.char(5,120,0,120), --violet
           [5] = string.char(5,255,0,0), --blue
           [6] = string.char(0,0,0,0), --black
           }
    local payload = (colours[tonumber(string.sub(code,1,1))]..
          colours[tonumber(string.sub(code,2,2))]..
          colours[tonumber(string.sub(code,3,3))]..
          colours[tonumber(string.sub(code,4,4))]..
          colours[tonumber(string.sub(code,5,5))])
    apa102.write(3,4,payload)
end
--SetLights("66666")
function CoffeeTime()
    StartMinutes = 90
    Minutes = 0
    Current = 0
    Step = 1
    Sequence = {10000, 01000, 00100, 00010, 00001, 10001, 01001, 00101, 00011, 10011, 01011, 00111, 10111, 01111, 11111}

    print ("Coffee Timer Started")
    send_email("Coffee was brewed","Someone just pressed the brewed coffee button")
    SetLights("00000")
    
    if not tmr.alarm(timers.Coffee, 60000, tmr.ALARM_AUTO, function()
                                                    CurrentString = string.format("%05d", (Current + Sequence[Step]))
                                                    Step = Step + 1
                                                    if Step > 15 then
                                                        Current = Current + Sequence[Step-1];
                                                        Step = 1
                                                    end
                                                    print(Current)
                                                    print(Step)
                                                    print(CurrentString)
                                                    SetLights(CurrentString)
                                                    Minutes = Minutes + 1
                                                    if Minutes == StartMinutes then
                                                        tmr.stop(timers.Coffee)
                                                    end
                                               end
                                              ) 
    then
        print("Coffee Timer failed")
    end

end

