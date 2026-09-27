# Shared World Border for BlazeandCave's Advancements Pack

Minecraft **Java 26.3**, including Fabric servers. This remains a server-side
datapack: no Fabric mod, Fabric API, or client installation is needed.
Use **BlazeandCave's Advancements Pack (BACAP) 1.21.1**, whose Minecraft target
is 26.3. The BACAP version number is not the Minecraft version number.

## Install

1. Install [BACAP for Minecraft 26.3](https://modrinth.com/datapack/blazeandcaves-advancements-pack/version/YPEkY5bZ)
   in your server's world `datapacks` directory.
2. Put `dist/WorldBorder-BAC-26.3.zip` in the same directory. Replace an older
   copy of this addon; do not load two copies together.
3. Start the server, or run `/reload`. Use `/datapack list enabled` to check
   that both packs are enabled.

**First installation retains the original challenge setup:** after eight seconds,
all three vanilla dimension borders become 1 block wide, centered at 0.5, 0.5.
Online survival/adventure players are teleported to 0, 321, 0 in the Overworld
with temporary resistance. Use a fresh challenge world or back up an existing
world first. Existing BACAP completions will be counted and expand the border.
Normal reloads and restarts preserve the border and credited advancements.

## Multiplayer behavior

An advancement completed by **any player** expands the borders for everybody.
Each advancement contributes **once across the entire server**. If Alice earns
Stone Age and Bob earns it later, only Alice's first completion expands the
border. Two different advancements both contribute, even when earned together.
Players keep their individual advancement progress; this addon does not grant
advancements to other players or change BACAP's cooperative/reward settings.

The Overworld, Nether and End receive equal diameter increments. Modded
additional dimensions are not managed. Existing reward balancing is retained:
normal mode generally moves each edge out by 1 block for a task, 5 for a goal,
25 for a challenge, 125 for a super challenge and 625 for a milestone.
Hidden/technical entries may give no growth. The original fast mode uses its
own per-advancement amounts; newly added entries use the normal amounts instantly.

## Commands

- `/function bc_wb:config` — configuration menu (operator).
- `/trigger wb_world_size` — show the Overworld border diameter, rounded to a
  whole block (available to players).
- `/function bc_wb:config/switch/fast_mode` — immediate growth.
- `/function bc_wb:config/switch/normal_mode` — animated growth, one reward at a time.
- `/function bc_wb:config/switch/bossbar_on` — show the diameter to all online players.
- `/function bc_wb:config/switch/bossbar_off` — hide it.

The menu's restart actions reset the border and credited-advancement ledger.
“Start WorldBorder” re-counts existing BACAP completions; “Remove all advancements
and start” also revokes online players' advancements and clears BACAP's shared
completion counter. These are challenge resets, not ordinary server restarts.

Borders are dimension-specific in 26.3. To move their centers, run
`/execute in minecraft:overworld run worldborder center <x> <z>` and repeat for
`minecraft:the_nether` and `minecraft:the_end` if you want matching centers.

## How it works and what changed

BACAP updates the global `bac_obtained` scoreboard whenever a player completes
one of its tracked advancements (including the vanilla advancements it integrates).
Every second, this addon checks those scores against its persistent `wb` ledger.
An uncredited completion runs its border reward and marks that advancement as
credited. Normal mode waits for the animation before processing the next reward;
fast mode can process multiple rewards in one scan.

This adaptation updates metadata to 26.3's data format 121.0 and migrates chat
hover/click events. It adds 109 newly tracked BACAP advancements, repairs three
missing normal-mode reward functions, explicitly updates all three dimension
borders, resumes polling on reload, and includes joining players in the bossbar.
The display now reports diameter rather than truncating half the size to an
integer. BACAP's own files are not overridden.

The advancement list is generated, not discovered dynamically at runtime.
Future BACAP releases or unrelated advancement packs need a corresponding list
update. Old IDs are retained for save compatibility, but are inert when BACAP
no longer awards them.

## Build and validation

```sh
python3 -m unittest discover -s tests -v
python3 tools/validate_minecraft.py /path/to/minecraft-26.3-server.jar
python3 tools/build.py
```

The Minecraft validator requires Java 25 and uses the official server JAR's
command parser without launching a server or creating a world. The regression
checks cover shared ledger references, dimension parity, reload behavior, missing
functions, and idempotent generation. These checks do not replace a live
multiplayer test with your server's mods.

To add advancements from a newer official BACAP ZIP while preserving existing
reward balance:

```sh
python3 tools/update_advancements.py /path/to/BACAP.zip
```

Then recheck the Minecraft/pack versions, run validation, and rebuild. The updater
recognizes BACAP's current advancement reward macro and skips untracked technical
displays; it is not a general Minecraft version converter.

Suggested live smoke test in a disposable world: have one player earn a tracked
advancement, then a second player earn the same one. Check that only the first
completion grows all three borders. Earn a different advancement with the second
player, reload/restart, and verify that growth continues without crediting either
advancement again. In normal mode, allow the current animation to finish first.

Compatibility references: [Minecraft 26.3 release notes](https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3),
[Mojang's text component migration](https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-5).

Original addon created by _Fedor_F, ItzSkyReed, and Hogurt.
See [LICENSE](LICENSE) for the original license.
