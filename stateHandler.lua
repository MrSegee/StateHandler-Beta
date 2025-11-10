local module = {}

local states={}
local stuntimers={}

function module.SetState(plr,stateKey,value,duration)
	if not states[plr] then
		states[plr]={}
	end
	
	states[plr][stateKey]=value
	
	if duration and type(duration)=="number" then
		delay(duration, function()
			if states[plr] then
				states[plr][stateKey]=nil
				
				if next(states[plr]) == nil then
					states[plr]=nil
				end
			end
		end)
	end
end

function module.ReturnStates(plr)
	return states[plr]
end

function module.GetState(plr, stateKey)
	if states[plr] then
		return states[plr][stateKey]
	end
	return nil
end

function module.RemoveState(plr,stateKey)
	if not states[plr] then return end
	
	if stateKey then
		states[plr][stateKey]=nil
		if next(states[plr])==nil then
			states[plr]=nil
		end
	end
end

function module.ClearAllStates(plr)
	if plr then
		states[plr]=nil
		stuntimers[plr]=nil
	else
		table.clear(states)
		table.clear(stuntimers)
	end
end

game:GetService("Players").PlayerRemoving:Connect(function(plr)
	states[plr]=nil
	stuntimers[plr]=nil
end)

function module.SetStun(plr,value,duration,stunSpeed)
	if not plr or not plr.Character or not plr.Character:FindFirstChild("Humanoid") then return end
	
	local humanoid=plr.Character:FindFirstChild("Humanoid")
	
	if not states[plr] then
		states[plr]={}
	end
	
	if value then
		states[plr]["Stunned"]=true
		
		if not states[plr].OriginalWalkSpeed then
			states[plr].OriginalWalkSpeed=humanoid.WalkSpeed
		end
		
		humanoid.WalkSpeed=stunSpeed or 0
		
		local endtime = time() + duration
		if stuntimers[plr] then
			stuntimers[plr].EndTime=math.max(stuntimers[plr].EndTime, endtime)
		else
			stuntimers[plr]={Endtime=endtime}
			coroutine.wrap(function()
				while stuntimers[plr] and time() < stuntimers[plr]["Endtime"] do
					task.wait(0.1)
				end
				
				if states[plr] then
					states[plr]["Stunned"]=nil
					
					if plr.Character and plr.Character:FindFirstChild("Humanoid") then
						local currentHumanoid = plr.Character:FindFirstChild("Humanoid")
						currentHumanoid.WalkSpeed=states[plr].OriginalWalkSpeed or 16
					end
					
					states[plr].OriginalWalkSpeed=nil
					
					if next(states[plr])==nil then
						states[plr]=nil
					end
				end
				
				stuntimers[plr]=nil
			end)()
		end
	else
		states[plr]["Stunned"]=nil
		
		if plr.Character and plr.Character:FindFirstChild("Humanoid") then
			local currentHumanoid = plr.Character:FindFirstChild("Humanoid")
			currentHumanoid.WalkSpeed=states[plr].OriginalWalkSpeed or 16
		end
		states[plr].OriginalWalkSpeed=nil
		stuntimers[plr]=nil
		
		if next(states[plr])==nil then
			states[plr]=nil
		end
	end
end

return module