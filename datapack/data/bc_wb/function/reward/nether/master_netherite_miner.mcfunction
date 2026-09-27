execute in minecraft:overworld run worldborder add 50 25
execute in minecraft:the_nether run worldborder add 50 25
execute in minecraft:the_end run worldborder add 50 25
scoreboard players add blazeandcave:nether/master_netherite_miner wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 25s
tellraw @a {"text": " +25 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Master Netherite Miner", "color": "dark_purple"}, {"text": "\n"}, {"translate": "Mine enough Ancient Debris to make a stack of Netherite Ingots (donâ€™t worry, mining a stack of Netherite Blocks is optional in this datapack, Iâ€™m not that evilâ€¦)", "color": "#C900C7"}, {"text": "\n\n"}, {"translate": "Nether", "color": "gray", "italic": true}]}}
