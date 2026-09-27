scoreboard objectives add wb dummy
scoreboard objectives add wb_config dummy
scoreboard objectives add wb_world_size trigger
execute unless score fast_wb wb_config matches 1 unless score fast_wb wb_config matches 0 run scoreboard players set fast_wb wb_config 0
execute unless score bossbar wb_config matches 1 unless score bossbar wb_config matches 0 run scoreboard players set bossbar wb_config 0
scoreboard players add first_time wb 0
execute if score first_time wb matches 0 run schedule function bc_wb:install 8s

# Resume polling without resetting the border or completion ledger.
execute if score first_time wb matches 1 run schedule function bc_wb:1_second_timer 1s replace

# BACAP records Benchmarking under this ID even though the advancement is story/root.
execute if score minecraft:story/root wb matches 1 unless score blazeandcave:bacap/benchmarking wb matches 1 run scoreboard players set blazeandcave:bacap/benchmarking wb 1
