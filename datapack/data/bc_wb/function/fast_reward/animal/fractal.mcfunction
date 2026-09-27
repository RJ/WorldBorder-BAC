execute in minecraft:overworld run worldborder add 0.0
execute in minecraft:the_nether run worldborder add 0.0
execute in minecraft:the_end run worldborder add 0.0
scoreboard players set blazeandcave:animal/fractal wb 1
tellraw @a {"text": " +0.0 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Fractal", "color": "light_purple"}, {"text": "\n"}, {"translate": "Put a Bundle in a Bundle in a Bundle in a Bundle in a Bundle… 16 layers deep", "color": "#DE4ADC"}, {"text": "\n\n"}, {"translate": "Animal", "color": "gray", "italic": true}]}}
