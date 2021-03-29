const
    MODULE*  = "neam"
    TITLE*   = "Erlang BEAM rework in Nim lang"
    AUTHOR*  = "Dmitry Ponyatov"
    EMAIL*   = "dponyatov@gmail.com"
    YEAR*    = 2020
    LICENSE* = "MIT"
    GITHUB*  = "https://github.com/ponyatov/neam"

import strformat

proc README*(): string = fmt"""
#  `{MODULE}`
## {TITLE}

(c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}

github: {GITHUB}
"""
