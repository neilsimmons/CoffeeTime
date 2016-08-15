function Base6Lights()
    count = 0
    function toBase(input,base)
r = ""
input = tonumber(input)
if input == 0 then return 0
else
while input > 0 do
    r = "" ..  (input % base ) .. r
    input = math.floor(input / base)
end
return tonumber(r)
end
end
    if not tmr.alarm(5, 1000, tmr.ALARM_AUTO, function()
                                              lightcode = string.format("%05d",toBase(count,6))
                                              print(lightcode)
                                              SetLights(lightcode)
                                              count = count +1
                                              end
                    )
    then
        print("Flash Timer Failed")
    end
end



