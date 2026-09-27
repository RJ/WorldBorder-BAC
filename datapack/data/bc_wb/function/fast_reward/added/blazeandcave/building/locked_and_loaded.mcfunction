execute in minecraft:overworld run worldborder add 10
execute in minecraft:the_nether run worldborder add 10
execute in minecraft:the_end run worldborder add 10
scoreboard players set blazeandcave:building/locked_and_loaded wb 1
tellraw @a {"text": " +5 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Locked and Loaded"}}}
