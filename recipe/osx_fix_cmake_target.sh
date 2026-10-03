python - <<'PY'
import os
from pathlib import Path
paths = [
    Path(os.environ["CONDA_PREFIX"]) / "lib/cmake/bdsim/BDSIMTargets.cmake",
    Path(os.environ["CONDA_PREFIX"]) / "lib/cmake/cfitsio/cfitsioTargets.cmake"
]

osversion = os.environ["MACOSX_SDK_VERSION"]

for p in paths:
  text = p.read_text()
  replacements = {
      "/opt/conda-sdks/MacOSX"+osversion+".sdk/usr/lib/libpthread.tbd": "pthread",
      "/opt/conda-sdks/MacOSX"+osversion+".sdk/usr/lib/libdl.tbd":      "dl",
      "/opt/conda-sdks/MacOSX"+osversion+".sdk/usr/lib/libm.tbd":       "m",
  }
  print(p)
  for old, new in replacements.items():
      print(f"{old} -> {new}: {text.count(old)} occurrence(s)")
      text = text.replace(old, new)
  p.write_text(text)
PY