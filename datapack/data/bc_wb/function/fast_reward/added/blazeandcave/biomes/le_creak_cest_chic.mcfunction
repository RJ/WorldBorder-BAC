execute in minecraft:overworld run worldborder add 50
execute in minecraft:the_nether run worldborder add 50
execute in minecraft:the_end run worldborder add 50
scoreboard players set blazeandcave:biomes/le_creak_cest_chic wb 1
tellraw @a {"text": " +25 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Le creak, c'est chic"}}}
