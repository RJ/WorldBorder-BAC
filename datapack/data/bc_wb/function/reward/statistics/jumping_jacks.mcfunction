execute in minecraft:overworld run worldborder add 50 25
execute in minecraft:the_nether run worldborder add 50 25
execute in minecraft:the_end run worldborder add 50 25
scoreboard players add blazeandcave:statistics/jumping_jacks wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 25s
tellraw @a {"text": " +25 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Jumping Jacks", "color": "dark_purple"}, {"text": "\n"}, {"translate": "Jump 100,000 times", "color": "#C900C7"}, {"text": "\n\n"}, {"translate": "Statistics", "color": "gray", "italic": true}]}}
