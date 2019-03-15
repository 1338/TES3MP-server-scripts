# guildsystem [WIP]
This script adds an guild system to tes3mp without touching the factions.
#### version 0.0.1
## Current status

This server script is still in the early stages as such much of the functionality is still missing. You could check in every one in a while to see this change.

I won't consider this script production ready before 1.0.0. But you are free to go ahead and try it if you have some lua knowledge.

### Current functionality
- Loading of guilds file (will attempt to create the guild file if there doesn't seem to be one)
- Saving of guilds file

### Dependencies
- jsonInterface - comes default with tes3mp but if you have modified it make sure to check if it still takes the normal path

## How to install
1. Move guildsystem.lua to the same `home` as defined in your tes3mp-server(-default).cfg Example: `home = /mnt/storage/tes3mp/clients/0.7.0/keepers/CoreScripts`)

2. Edit `customScripts.lua` and add:
`require('guildsystem')` to the end

## How to configure
### Change guild file name/path
#### file name
- By default the file gets saved to `data/guilds.json`
to change this you an edit `guildsystem.lua` and change `guildsystem.config.file` to something else.

#### file path
- To change the path you can either change `guildsystem.load` and `guildsystem.save` methods or change how `jsonInterface` works.

### Edit guilds
#### Edit the guild file
The guilds file is saved in JSON format

- An example of an guild in the guilds file(incomplete):
```json
[
{
	"name": "guildname",
	"motd": "login message",
	"members": {
		"member 1": 0,
		"member 2": 1
	},
	"ranks": [
		"guildmaster",
		"Lt."
	],
	"permissions": [
		["talk", "changerank", "changeranknames"],
		["talk"]
	]
}
]
```

- Members are in the format:
```json
{
 "members": {
   "member name": rankNumber
 }
}
```

- Ranks are an array:
```json
{
 "ranks": [
    "rankname0",
    "rankname1"
 ]
}
```
So in this example `rankname0` corresponds to the `rankNumber` `0` and `rankname1` corresponds to the `rankNumber` `1`

- Permissions are an array of arrays:
```json
{
  "permissions": [
    ["talk", "changerank", "changeranknames"],
    ["talk"]
  ]
}
```
In this example `rankNumber` `0` is allowed to `talk`, `changerank`, `changeranknames` while `rankNumber` `1` is allowed to `talk`
