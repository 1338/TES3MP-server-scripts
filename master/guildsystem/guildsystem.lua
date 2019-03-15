jsonInterface = require("jsonInterface")
guildsystem = {
	config={
		file = "guilds.json"
	}
}

function guildsystem.fileCheck(path)
	local fh = io.open( path, "r" )
	if fh then
		io.close(fh)
		return true
	end
	return false
end

-- loads guild file
function guildsystem.load()
	guildsystem.guilds = jsonInterface.load(guildsystem.config.file)
	if guildsystem.guilds ~= nil then
		return true
	end
	return false
end

-- saves guild file
function guildsystem.save()
	return jsonInterface.save(guildsystem.config.file, guildsystem.guilds)
end


function guildsystem.getGuildsFile()
	tes3mp.LogMessage(enumerations.log.INFO, "[guilds] using file path: " .. guildsystem.config.path)
	if guildsystem.fileCheck(guildsystem.config.path) then
		tes3mp.LogMessage(enumerations.log.INFO, "[guilds] guild file exists.")
		if guildsystem.load() then
			tes3mp.LogMessage(enumerations.log.INFO, "[guilds] was able to load guild file.")
		else
			tes3mp.LogMessage(enumerations.log.WARN, "[guilds] wasn't able to load guild file!")
		end
	else
		tes3mp.LogMessage(enumerations.log.INFO, "[guilds] guild file doesn't exists. Trying to create file.")
		guildsystem.guilds = {}
		if guildsystem.save() then
			tes3mp.LogMessage(enumerations.log.WARN, "[guilds] was able to create guild file!")
		else
			tes3mp.LogMessage(enumerations.log.WARN, "[guilds] wasn't able to create guild file!")
		end
	end
end

function guildsystem.getGuildByName(guildname)
	for k, v in pairs(guildsystem.guilds) do
		if(guildsystem.guilds[k].name == guildname) then
			return guildsystem.guilds[k]
		end
	end
	return false
end

-- makes sure that the guild system Initializes correctly
function guildsystem.init()
	-- Need file for for jsonInterface and path for fileCheck
	guildsystem.config.path = tes3mp.GetModDir() .. "/" .. guildsystem.config.file
	-- attempt to load guilds into guildsystem.guilds (or create file if can not)
	guildsystem.getGuildsFile()
	-- /guild for guild commands
	customCommandHooks.registerCommand('guild', guildsystem.commandHandle)
	-- /gc for sending guild members a message (stands for guild chat)
	customCommandHooks.registerCommand('gc', guildsystem.sendGuildMessae)
end

-- handles commands for guild
function guildsystem.commandHandle(pid, cmd)

end

-- Only sends message to people in the same guild
function guildsystem.sendGuildMessage(pid, cmd)

end

-- makes the guild system functional after the server start
customEventHooks.registerHandler("OnServerPostInit", guildsystem.init())

return guildsystem
