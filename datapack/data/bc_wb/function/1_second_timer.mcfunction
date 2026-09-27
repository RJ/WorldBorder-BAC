execute if score is_wb_run wb matches 1 if score fast_wb wb_config matches 0 run function bc_wb:main
execute if score is_wb_run wb matches 1 if score fast_wb wb_config matches 1 run function bc_wb:fast_main

execute store result storage bc_wb:world_size world.size int 1 run execute in minecraft:overworld run worldborder get
bossbar set bc_wb:world_size name {"translate":"Border diameter: %1$s blocks (rounded)","with":[{"nbt":"world.size","storage":"bc_wb:world_size"}]}

bossbar set bc_wb:world_size players @a
scoreboard players enable @a wb_world_size
execute as @a if score @s wb_world_size matches 1.. run function bc_wb:world_size_trigger

schedule function bc_wb:1_second_timer 1s
