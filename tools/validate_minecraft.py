"""Run the real Minecraft command parser using a downloaded 26.3 server JAR.

Requires Java 25 (java and javac). Does not launch a server or create a world.
Usage: python3 tools/validate_minecraft.py /path/to/server.jar
"""
import os
import subprocess
import sys
import tempfile
from pathlib import Path
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory(prefix="wb-validate-") as temporary:
    directory = Path(temporary)
    jars = []
    with ZipFile(sys.argv[1]) as bundle:
        for name in bundle.namelist():
            if name.startswith("META-INF/") and name.endswith(".jar"):
                target = directory / f"dependency-{len(jars)}.jar"
                target.write_bytes(bundle.read(name))
                jars.append(str(target))
    classpath = os.pathsep.join(jars + [temporary])
    subprocess.run(["javac", "-cp", classpath, "-d", temporary,
                    str(ROOT / "tools/ValidateFunctions.java")], check=True)
    subprocess.run(["java", "-Xmx1G", "-cp", classpath, "ValidateFunctions",
                    str(ROOT / "datapack")], cwd=temporary, check=True)
