execute in minecraft:overworld run worldborder add 250
execute in minecraft:the_nether run worldborder add 250
execute in minecraft:the_end run worldborder add 250
scoreboard players set blazeandcave:challenges/lets_take_it_up_a_notch wb 1
tellraw @a {"text": " +125 Blocks", "color": "#B2FFEE", "hover_event": {"action": "show_text", "value": {"translate": "Let's take it up a notch"}}}
