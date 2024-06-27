local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = 15502339080
local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=50"
function ListServers(cursor)
   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   return Http:JSONDecode(Raw)
end

local module = {}
function module:Teleport(placeId, min)
	while wait() do
		pcall(function()
            local Next; repeat
                local Servers = ListServers(Next)
                for i,v in next, Servers.data do
                    if v.playing > min and v.id then
                        local s = pcall(TPS.TeleportToPlaceInstance, TPS, _place, v.id, Player)
                        if s then break end
                    end
                end
            until not next
		end)
	end
end
