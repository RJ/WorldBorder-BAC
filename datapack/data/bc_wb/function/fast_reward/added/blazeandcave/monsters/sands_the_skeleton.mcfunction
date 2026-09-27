execute in minecraft:overworld run worldborder add 2
execute in minecraft:the_nether run worldborder add 2
execute in minecraft:the_end run worldborder add 2
scoreboard players set blazeandcave:monsters/sands_the_skeleton wb 1
tellraw @a {"text": " +1 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Sands the Skeleton"}}}
