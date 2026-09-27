execute in minecraft:overworld run worldborder add 50
execute in minecraft:the_nether run worldborder add 50
execute in minecraft:the_end run worldborder add 50
scoreboard players set blazeandcave:monsters/oh_no_guys_im_oozing wb 1
tellraw @a {"text": " +25 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Oh no guys I'm o o z i n g"}}}
