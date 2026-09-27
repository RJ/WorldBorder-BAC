execute in minecraft:overworld run worldborder add 2 1
execute in minecraft:the_nether run worldborder add 2 1
execute in minecraft:the_end run worldborder add 2 1
scoreboard players add blazeandcave:statistics/luxury_cruise wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 1s
tellraw @a {"text": " +1 Block", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Luxury Cruise", "color": "green"}, {"text": "\n"}, {"translate": "Sail 1km in a boat", "color": "#49DB49"}, {"text": "\n\n"}, {"translate": "Statistics", "color": "gray", "italic": true}]}}
