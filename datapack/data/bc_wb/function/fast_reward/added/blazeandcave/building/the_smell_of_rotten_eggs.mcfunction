execute in minecraft:overworld run worldborder add 2
execute in minecraft:the_nether run worldborder add 2
execute in minecraft:the_end run worldborder add 2
scoreboard players set blazeandcave:building/the_smell_of_rotten_eggs wb 1
tellraw @a {"text": " +1 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "The smell of rotten eggs"}}}
