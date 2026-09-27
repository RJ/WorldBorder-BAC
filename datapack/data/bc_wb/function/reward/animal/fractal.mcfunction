execute in minecraft:overworld run worldborder add 0 0
execute in minecraft:the_nether run worldborder add 0 0
execute in minecraft:the_end run worldborder add 0 0
scoreboard players add blazeandcave:animal/fractal wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 0s
tellraw @a {"text": " +0 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Fractal", "color": "light_purple"}, {"text": "\n"}, {"translate": "Put a Bundle in a Bundle in a Bundle in a Bundle in a Bundleâ€¦ 16 layers deep", "color": "#DE4ADC"}, {"text": "\n\n"}, {"translate": "Animal", "color": "gray", "italic": true}]}}
