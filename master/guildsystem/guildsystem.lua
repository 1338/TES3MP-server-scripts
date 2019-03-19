jsonInterface = require("jsonInterface")
guildsystem = {
	config={
		file = "guilds.json",
		options = {
			customOverhead = false, --enables `[guildname] usename` overhead
			guildnameInNormalChat = false, --enables `[guildname] username` in normal chat
			guildrankInGuildChat = false, -- enables `[guildrankname] username` in guild chat
			shorthand = false -- enables `/g` with same usage as `/guild`
		}
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

function guildsystem.load()
	guildsystem.guilds = jsonInterface.load(guildsystem.config.file)
	if guildsystem.guilds ~= nil then
		return true
	end
	return false
end

function guildsystem.save()
	return jsonInterface.save(guildsystem.config.file, guildsystem.guilds)
end

function guildsystem.base(guildName)
	local baseguild = {}

	return baseguild
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

function guildsystem.init()
	-- Need file for for jsonInterface and path for fileCheck
	guildsystem.config.path = tes3mp.GetModDir() .. "/" .. guildsystem.config.file
	-- attempt to load guilds into guildsystem.guilds (or create file if can not)
	guildsystem.getGuildsFile()

	-- register command hooks
	customCommandHooks.registerCommand("guild", guildsystem.commandHandler)
	if guildsystem.config.options.shorthand then
		customCommandHooks.registerCommand('gc', guildsystem.commandHandler)
	end

	-- register login handler for custom overheads
	if guildsystem.config.options.customOverhead then
		-- customEventHooks.registerHandler('On')
	end

	if guildsystem.config.options.guildnameInNormalChat then
		-- customEventHooks.registerHandler('On')
	end

	if guildsystem.config.options.guildrankInGuildChat then
		-- customEventHooks.registerHandler('On')
	end

end

function guildsystem.switchDisplayName(pid)
	tes3mp.SetName(pid, "[" .. color.Yellow .."guild" .. color.White .. "] " ..  Players[pid].name)
	tes3mp.SendBaseInfo(pid)
end


function guildsystem.commandHandler(pid, cmd)
	local command = cmd[1]

end

customEventHooks.registerHandler("OnServerPostInit", guildsystem.init())

return guildsystem
