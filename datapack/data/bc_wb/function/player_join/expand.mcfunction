# A one-block increase on each edge means two blocks of diameter.
execute in minecraft:overworld run worldborder add 2
execute in minecraft:the_nether run worldborder add 2
execute in minecraft:the_end run worldborder add 2
scoreboard players remove join_pending wb 1
tellraw @a {"text":" +1 Block (new player bonus)","color":"#B2FFEE"}
