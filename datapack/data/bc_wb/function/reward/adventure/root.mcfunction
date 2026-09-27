execute in minecraft:overworld run worldborder add 2 1
execute in minecraft:the_nether run worldborder add 2 1
execute in minecraft:the_end run worldborder add 2 1
scoreboard players add minecraft:adventure/root wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 1s
tellraw @a {"text": " +1 Block", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Adventure", "color": "#CCCCCC"}, {"text": "\n"}, {"translate": "Village, pillage and exploration", "color": "#CCCCCC"}, {"text": "\n\n"}, {"translate": "Adventure", "color": "gray", "italic": true}]}}
