execute in minecraft:overworld run worldborder add 2
execute in minecraft:the_nether run worldborder add 2
execute in minecraft:the_end run worldborder add 2
scoreboard players set blazeandcave:biomes/a_scute_off_the_old_shell wb 1
tellraw @a {"text": " +1 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "A Scute Off the Old Shell"}}}
