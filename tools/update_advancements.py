"""Add newly tracked BACAP advancements from an official pack ZIP.

Existing rewards and their balance are preserved. No BACAP files are overridden.
Usage: python3 tools/update_advancements.py /path/to/BACAP.zip
"""
import argparse
import json
import re
from pathlib import Path
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
FUNCTIONS = ROOT / "datapack/data/bc_wb/function"
# Diameter increments; each edge moves half this distance.
INCREMENTS = {"task": 2, "goal": 10, "challenge": 50,
              "super_challenge": 250, "milestone": 1250, "hidden": 0}
DIMENSIONS = ("overworld", "the_nether", "the_end")


def update(archive, functions=FUNCTIONS):
    main = functions / "main.mcfunction"
    known = set(re.findall(r"execute if score (\S+) bac_obtained", main.read_text()))
    added = 0
    with ZipFile(archive) as pack:
        for name in sorted(pack.namelist()):
            if "/advancement/" not in name or not name.endswith(".json"):
                continue
            data = json.loads(pack.read(name))
            if "display" not in data:
                continue
            namespace, path = name[5:].split("/advancement/", 1)
            advancement = namespace + ":" + path[:-5]
            reward = data.get("rewards", {}).get("function")
            if not isinstance(reward, str):
                continue
            reward_file = "data/" + reward.replace(":", "/function/") + ".mcfunction"
            if reward_file not in pack.namelist():
                continue
            source = pack.read(reward_file).decode("utf-8")
            tier = re.search(r'tier:\s*"([^"]+)"', source)
            # Technical displays with no tracked completion are not challenges.
            if not tier or "bacap_rewards:advancement_made_macro" not in source:
                continue
            recorded_id = re.search(r'adv_id:\s*"([^"]+)"', source)
            if recorded_id:
                advancement = recorded_id[1]
            if advancement in known:
                continue
            amount = INCREMENTS[tier[1]]
            key = "added/" + namespace + "/" + path[:-5]
            message = json.dumps({
                "text": f" +{amount / 2:g} Blocks", "color": "#B2FFEE",
                "hover_event": {"action": "show_text", "value": data["display"]["title"]},
            }, ensure_ascii=False)
            for mode, loop in (("reward", "main"), ("fast_reward", "fast_main")):
                duration = max(1, amount // 2)
                suffix = f" {duration}" if mode == "reward" else ""
                lines = [f"execute in minecraft:{d} run worldborder add {amount}{suffix}"
                         for d in DIMENSIONS] if amount else []
                lines.append(f"scoreboard players set {advancement} wb 1")
                if mode == "reward" and amount:
                    lines += ["scoreboard players set is_wb_run wb 0",
                              f"schedule function bc_wb:untask {duration}s"]
                if amount:
                    lines.append("tellraw @a " + message)
                target = functions / mode / (key + ".mcfunction")
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_text("\n".join(lines) + "\n")
                with (functions / (loop + ".mcfunction")).open("a") as output:
                    output.write(
                        f"execute if score {advancement} bac_obtained matches 1.. "
                        f"unless score {advancement} wb matches 1 "
                        f"if score is_wb_run wb matches 1 run function bc_wb:{mode}/{key}\n")
            known.add(advancement)
            added += 1
    return added


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("archive", type=Path)
    args = parser.parse_args()
    print(f"Added {update(args.archive)} advancements.")
