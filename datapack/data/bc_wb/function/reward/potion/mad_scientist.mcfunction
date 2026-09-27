execute in minecraft:overworld run worldborder add 50 25
execute in minecraft:the_nether run worldborder add 50 25
execute in minecraft:the_end run worldborder add 50 25
scoreboard players add blazeandcave:potion/mad_scientist wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 25s
tellraw @a {"text": " +25 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Mad Scientist", "color": "dark_purple"}, {"text": "\n"}, {"translate": "Cure a zombie villager of every profession", "color": "#C900C7"}, {"text": "\n\n"}, {"translate": "Potion", "color": "gray", "italic": true}]}}
