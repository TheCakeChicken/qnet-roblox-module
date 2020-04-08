
--[[
	QNET ROBLOX BAN MODULE
	~By EramsorGR, part of the NSE Network group.
   
	Protect by an MIT License
	Copyright (c) 2020 Nicholas S.
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	  
	For bug reports, features requests and more, please check the GitHub page @ github.com/EramsorGR/qnet-roblox-module/
]]--

--[[ MODULE CONFIGURATION ]]--

--PLEASE FILL IN THIS WITH THE KEY YOU HAVE RECEIVED!
local ACCOUNT_KEY = ""  

--THE BAN MESSAGE YOU WANT TO SHOW
-- "\n" means a new line
local banMessage = "\n\n[QNET]\nYou are banned from QNET powered games.\n\nReason:\n"


--[[ MODULE ]]--

--Calling out the HttpService
local HttpService = game:GetService("HttpService")

--On Payer Join event
game.Players.PlayerAdded:Connect(function(plr)
	--Initating a function
	local function getBan() 
		--Sending a GET request to the API
		local response = HttpService:GetAsync("https://qnet.quantos.xyz/api/robloxBanned?key=" .. ACCOUNT_KEY .. "&id=" .. plr.UserId)
		--Decoding the response from the API
		local data = HttpService:JSONDecode(response)
		--Checking if the returned data are success and the user is banned
		if data.success == true and data.banned == true then
			--Kicing the player from the game
			plr:Kick(banMessage .. data.reason .. "\n") --Adding  a new line so the error code doesn't get stuck with the reason
		--Check if the module is not authenticated (Usually no key or key has expired)
		elseif data.success == true and data.authenticated == false then
			warn('[QNET]: Module not authenticated!')
		end
	end	
	
	--Running a pcall to check for errors
	local success, Error = pcall(getBan)
	if not success then
		print('[QNET]: Error:\n'..Error)
	end	
end)
