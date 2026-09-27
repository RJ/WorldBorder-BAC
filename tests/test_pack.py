import importlib.util
import json
import re
import tempfile
import unittest
from pathlib import Path
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
FUNCTIONS = ROOT / "datapack/data/bc_wb/function"
LOOP = re.compile(
    r"execute if score (\S+) bac_obtained matches 1\.\. "
    r"unless score (\S+) wb matches 1 if score is_wb_run wb matches 1 "
    r"run function bc_wb:(\S+)")


class PackTests(unittest.TestCase):
    def test_all_rewards_use_shared_persistent_ledger(self):
        modes = []
        for name in ("main", "fast_main"):
            ids = set()
            for line in (FUNCTIONS / f"{name}.mcfunction").read_text().splitlines():
                match = LOOP.fullmatch(line)
                self.assertIsNotNone(match, line)
                advancement, ledger, reward = match.groups()
                self.assertEqual(advancement, ledger)
                self.assertNotIn(advancement, ids)
                ids.add(advancement)
                body = (FUNCTIONS / f"{reward}.mcfunction").read_text()
                self.assertRegex(body, r"scoreboard players (?:set|add) "
                                 + re.escape(advancement) + r" wb 1\b")
                self.assertNotIn("@s", body)
            modes.append(ids)
        self.assertEqual(*modes)
        self.assertGreater(len(modes[0]), 1200)

    def test_border_rewards_update_all_three_dimensions_equally(self):
        for folder in ("reward", "fast_reward"):
            for path in (FUNCTIONS / folder).rglob("*.mcfunction"):
                operations = re.findall(
                    r"^execute in minecraft:(\w+) run worldborder (.+)$",
                    path.read_text(), re.MULTILINE)
                if operations:
                    self.assertEqual({d for d, _ in operations},
                                     {"overworld", "the_nether", "the_end"}, str(path))
                    self.assertEqual(len({op for _, op in operations}), 1, str(path))
                self.assertNotRegex(path.read_text(), r"(?m)^(?:execute run )?worldborder ")

    def test_local_references_resolve_and_old_text_events_are_gone(self):
        for path in FUNCTIONS.rglob("*.mcfunction"):
            content = path.read_text()
            self.assertNotIn('"hoverEvent"', content)
            self.assertNotIn('"clickEvent"', content)
            for ref in re.findall(r"(?:function|schedule clear) bc_wb:([a-z0-9_/]+)", content):
                self.assertTrue((FUNCTIONS / f"{ref}.mcfunction").is_file(), f"{path}: {ref}")
        for path in (ROOT / "datapack").rglob("*.json"):
            json.loads(path.read_text())

    def test_reload_preserves_ledger_and_resumes_timer(self):
        load = (FUNCTIONS / "load.mcfunction").read_text()
        self.assertNotIn("scoreboard objectives remove", load)
        self.assertNotIn("worldborder set", load)
        self.assertIn("if score first_time wb matches 1 run schedule function bc_wb:1_second_timer 1s replace", load)
        self.assertIn("unless score", load)

    def test_update_is_idempotent_and_excludes_technical_advancements(self):
        spec = importlib.util.spec_from_file_location("update", ROOT / "tools/update_advancements.py")
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            for name in ("main", "fast_main"):
                (root / f"{name}.mcfunction").write_text("")
            archive = root / "fixture.zip"
            with ZipFile(archive, "w") as pack:
                for name, function in (("test", 'function bacap_rewards:advancement_made_macro {adv_id:"blazeandcave:recorded_alias",tier:"goal"}'),
                                       ("technical", "")):
                    pack.writestr(f"data/blazeandcave/advancement/{name}.json", json.dumps({
                        "display": {"title": {"text": name}},
                        "rewards": {"function": f"bacap_rewards:{name}"}}))
                    pack.writestr(f"data/bacap_rewards/function/{name}.mcfunction", function)
            self.assertEqual(module.update(archive, root), 1)
            self.assertEqual(module.update(archive, root), 0)
            self.assertNotIn("technical", (root / "main.mcfunction").read_text())
            self.assertIn("blazeandcave:recorded_alias bac_obtained", (root / "main.mcfunction").read_text())
            reward = (root / "reward/added/blazeandcave/test.mcfunction").read_text()
            self.assertEqual(reward.count("worldborder add 10 5"), 3)


if __name__ == "__main__":
    unittest.main()
