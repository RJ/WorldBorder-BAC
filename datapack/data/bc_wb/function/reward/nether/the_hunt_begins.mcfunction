execute in minecraft:overworld run worldborder add 2 1
execute in minecraft:the_nether run worldborder add 2 1
execute in minecraft:the_end run worldborder add 2 1
scoreboard players add blazeandcave:nether/the_hunt_begins wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 1s
tellraw @a {"text": " +1 Block", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "The Hunt Begins", "color": "green"}, {"text": "\n"}, {"translate": "Kill a wither skeleton", "color": "#49DB49"}, {"text": "\n\n"}, {"translate": "Nether", "color": "gray", "italic": true}]}}
