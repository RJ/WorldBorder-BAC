execute in minecraft:overworld run worldborder add 10
execute in minecraft:the_nether run worldborder add 10
execute in minecraft:the_end run worldborder add 10
scoreboard players set blazeandcave:monsters/unwanted_passenger wb 1
tellraw @a {"text": " +5 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Unwanted Passenger"}}}
