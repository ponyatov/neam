# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import neampkg/submodule
import metainfo
# import config

when isMainModule:
  echo(getWelcomeMessage())
  echo README()
