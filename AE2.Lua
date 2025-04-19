local component = require("component")
local serialization = require("serialization")
local sides = require("sides")
local term = require("term")
 
local me = component.me_controller
local cell = 16777216
local count = 80
local storagesize = cell*count
local freespace = cell*count
local timer = 60
local lines = 0
 
term.clear()
os.execute("resolution 60 90")
 
local function byteCount(n)
 
    if n >= 10^6 then
        return string.format("%.2fMB", n/1024^2)
    elseif n>= 10^3 then
        return string.format("%.2fKB", n/1024)
    else
        return string.format("%.0fB", n)
    end
end
 
local function amount(n)
 
    if n >= 10^6 then
        return string.format("%.2fm", n/10^6)
    elseif n>= 10^3 then
        return string.format("%.2fk", n/10^3)
    else
        return tostring(n)
    end
end
 
while true do
 
local space = freespace
 
for key,item in ipairs(me.getItemsInNetwork()) do
    print("--------------------")
    print(item.label.." :: "..amount(item.size).." Unit(s), Bytes: "..byteCount((512+item.size)))
    space = space - (512+item.size)
    lines = lines + 2
    os.sleep(0.5)
end
 
local x = (1-(space/storagesize))*100
x = math.floor(x*100)/100
print("\n")
print("Total bytes: "..byteCount(storagesize).." Free Bytes "..byteCount(space))
print("Percent used: "..x.."%")
print("\n")
 
lines = lines + 7
os.sleep(0.5)
 
while timer > 0 do
    timer = timer - 1
term.setCursor(1,lines)
term.clearLine()
print("Time until refresh: "..timer)
os.sleep(1)
end
 
timer = 60
lines = 0
 
term.clear()
end