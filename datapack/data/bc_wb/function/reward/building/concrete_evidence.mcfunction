execute in minecraft:overworld run worldborder add 2 1
execute in minecraft:the_nether run worldborder add 2 1
execute in minecraft:the_end run worldborder add 2 1
scoreboard players add blazeandcave:building/concrete_evidence wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 1s
tellraw @a {"text": " +1 Block", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Concrete Evidence", "color": "green"}, {"text": "\n"}, {"translate": "Create concrete from concrete powder by dropping it into water", "color": "#49DB49"}, {"text": "\n\n"}, {"translate": "Building", "color": "gray", "italic": true}]}}
