execute in minecraft:overworld run worldborder add 250 125
execute in minecraft:the_nether run worldborder add 250 125
execute in minecraft:the_end run worldborder add 250 125
scoreboard players add blazeandcave:challenges/all_the_blocks wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 125s
tellraw @a {"text": " +125 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "All the Blocks!", "color": "#FF2A2A"}, {"text": "\n"}, {"translate": "Obtain all the blocks!", "color": "#DC2727"}, {"text": "\n\n"}, {"translate": "Challenges", "color": "gray", "italic": true}]}}
