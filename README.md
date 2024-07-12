# lcars
An R package for playing computer sound effects from Star Trek, inspired by [beepr](https://github.com/rasmusab/beepr). Audio samples sourced from [TrekCore](https://trekcore.com/audio).

## Installation
``` r
remotes::install_github(repo = 'nstauffer/lcars')
```

## Use
Personally, I just wanted a quick and easy way to insert [LCARS](https://memory-alpha.fandom.com/wiki/Library_Computer_Access_and_Retrieval_System) sound effects from Star Trek into my code because it sounded more fun to have completion and errors announced with those. There are a handful of sounds in the package which can all be called by name although the function defaults to a sound made by the computer when it requires a character's attention.
``` r
# This will simply play the default attention-grabbing sound
lcars()

# This will play an alert klaxon suitable for catastrophic situations
lcars("alert_long")

# These will play an appropriate sound for warnings or errors when executing the expressions and return any output from the expressions
lcars_trycatch(expr = "Kirk" / "Spock")
lcars_trycatch(expr = as.numeric(c("7", "of", "9"))
lcars_trycatch(expr = eval(parse(text = "Is Data a person with all the associated rights?")),
               error = "alert")
```
