# Player tags persist across logouts, restarts, name changes and challenge resets.
tag @s add bc_wb_join_bonus
scoreboard players add join_pending wb 1
tellraw @a [{"selector":"@s","color":"yellow"},{"text":" joined for the first time! +1 Block border bonus queued.","color":"#B2FFEE"}]
