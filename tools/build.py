"""Build the installable ZIP with pack.mcmeta at the archive root."""
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile

root = Path(__file__).resolve().parents[1]
target = root / "dist/WorldBorder-BAC-26.3.zip"
target.parent.mkdir(exist_ok=True)
with ZipFile(target, "w", ZIP_DEFLATED) as output:
    for path in sorted((root / "datapack").rglob("*")):
        if path.is_file():
            output.write(path, path.relative_to(root / "datapack"))
    for name in ("LICENSE", "README.md"):
        output.write(root / name, name)
print(target)
