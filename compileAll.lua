for f,s in pairs(file.list()) do
    if (string.match(f, "lua") and not string.match(f, "init.lua")) then
        node.compile(f)
        file.remove(f)
    end
end

--file.remove("compileAll.lc")
