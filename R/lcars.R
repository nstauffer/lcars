#' Play audio samples of LCARS sounds from Star Trek
#' @description
#' Plays a handful of named sound effects from Star Trek The Next Generation and Star Trek Voyager.
#' @param sound Character string. The name of a sound effect to play. Defaults to \code{"attention"}.
#' @export
lcars <- function(sound = "attention") {
  # Get the filepath to the package's sounds folder
  sound_filepath <- system.file("sounds", package = "lcars")
  # Figure out what WAV files are in there
  sounds <- list.files(sound_filepath,
                       pattern = "\\.wav$")
  # Name the filename vector with the filenames sans file extension
  names(sounds) <- stringr::str_extract(string = sounds,
                                        pattern = "^.+(?=\\.wav$)")

  # If the requested sound is in there, play it
  if (sound %in% names(sounds)) {
    sound_path <- paste0(sound_filepath, "/", sounds[sound])
    sfx <- audio::load.wave(sound_path)
    audio::play(sfx)
  } else {
    # Otherwise tell the user what they could ask for
    stop(paste("Valid sounds are:",
               paste(names(sounds),
                     collapse = ", ")))
  }
}

#' Evaluate an expressions, playing appropriate audio samples of LCARS sounds from Star Trek
#' @description
#' Evaluates and returns the output from an expression. If there expression produces an error or a warning, an appropriate sound effect from Star Trek The Next Generation will be played.
#' @param expr An expression to evaluate.
#' @param warning Character string. The name of the sound to play if a warning is produced by the expression. Defaults to \code{"attention"}.
#' @param errorCharacter string. The name of the sound to play if an error is produced by the expression. Defaults to \code{"error"}.
#' @examples
#' \dontrun{
#' # This will produce an error message and sound effect
#' lcars_trycatch(expr = "Kirk" / "Spock")
#'
#' # This will produce an error message and use a more dramatic sound effect
#' lcars_trycatch(expr = "Kirk" / "Spock",
#'                error = "alert")
#'
#' # This will produce an output, a warning message, and a sound effect
#' lcars_trycatch(expr = as.numeric(c("7", "of", "9")))
#' }
#'
#' @export
lcars_trycatch <- function(expr,
                           warning = "attention",
                           error = "error") {
  output <- tryCatch(expr = withCallingHandlers(expr = expr,
                                                warning = function(warning_returned) {
                                                  lcars(warning)
                                                },
                                                error = function(error_returned) {
                                                  lcars(error)
                                                  stop(error_returned)
                                                }))
  return(output)
}
