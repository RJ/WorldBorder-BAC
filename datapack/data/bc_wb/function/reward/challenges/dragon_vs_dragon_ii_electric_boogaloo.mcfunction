execute in minecraft:overworld run worldborder add 250 125
execute in minecraft:the_nether run worldborder add 250 125
execute in minecraft:the_end run worldborder add 250 125
scoreboard players add blazeandcave:challenges/dragon_vs_dragon_ii_electric_boogaloo wb 1
scoreboard players set is_wb_run wb 0
schedule function bc_wb:untask 125s
tellraw @a {"text": " +125 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": ["", {"translate": "Dragon vs Dragon II", "color": "#FF2A2A"}, {"text": "\n"}, {"translate": "Defeat the Ender Dragon while wearing a dragon head... without touching the ground", "color": "#DC2727"}, {"text": "\n\n"}, {"translate": "Challenges", "color": "gray", "italic": true}]}}
