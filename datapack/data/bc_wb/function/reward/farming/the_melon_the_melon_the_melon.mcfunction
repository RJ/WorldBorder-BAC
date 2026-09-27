execute in minecraft:overworld run worldborder add 2 1
execute in minecraft:the_nether run worldborder add 2 1
execute in minecraft:the_end run worldborder add 2 1
scoreboard players add blazeandcave:farming/the_melon_the_melon_the_melon wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 1s
tellraw @a {"text": " +1 Block", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "The Melon! The Melon! The Melon!", "color": "green"}, {"text": "\n"}, {"translate": "Eat a melon. Be careful not to drop it over a cliff", "color": "#49DB49"}, {"text": "\n\n"}, {"translate": "Farming", "color": "gray", "italic": true}]}}
