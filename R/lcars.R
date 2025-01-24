#' Play audio samples of LCARS sounds from Star Trek
#' @description
#' Plays a handful of named sound effects from Star Trek The Next Generation and Star Trek Voyager.
#' @param sound Character string. The name of a sound effect to play. Valid options are: \code{"alert"}, \code{"alert_long"}, \code{"attention"}, \code{"attention_alt"}, \code{"error"}, and \code{"warning"}. Defaults to \code{"attention"}.
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
#' @param success  Character string. The name of the sound to play if the expression executes without warnings or errors. Valid options are: \code{"alert"}, \code{"alert_long"}, \code{"attention"}, \code{"attention_alt"}, \code{"error"}, and \code{"warning"}. Defaults to \code{"attention"}.
#' @param warning Character string. The name of the sound to play if a warning is produced by the expression. Valid options are: \code{"alert"}, \code{"alert_long"}, \code{"attention"}, \code{"attention_alt"}, \code{"error"}, and \code{"warning"}. Defaults to \code{"warning"}.
#' @param error Character string. The name of the sound to play if an error is produced by the expression. Valid options are: \code{"alert"}, \code{"alert_long"}, \code{"attention"}, \code{"attention_alt"}, \code{"error"}, and \code{"warning"}. Defaults to \code{"error"}.
#' @examples
#' \dontrun{
#' # This will produce the result without warnings/errors and play a sound effect
#' lcars::lcars_trycatch(expr = c("NCC-1701",
#'                                paste("NCC-1701",
#'                                      c("A", "B", "C", "D", "E", "F", "G", "J"),
#'                                      sep = "-")))
#'
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
                           success = "attention",
                           warning = "warning",
                           error = "error") {
  successful <- TRUE
  output <- tryCatch(expr = withCallingHandlers(expr = expr,
                                                warning = function(warning_returned) {
                                                  lcars(warning)
                                                  # This bit lets us prevent the
                                                  # success sound effect from
                                                  # playing if we got a warning
                                                  parent_environment <- parent.env(environment())
                                                  parent_environment$successful <- FALSE
                                                },
                                                error = function(error_returned) {
                                                  lcars(error)
                                                  stop(error_returned)
                                                }))
  if (successful) {
    lcars(success)
  }
  return(output)
}
