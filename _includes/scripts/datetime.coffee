dateTime = (e) ->
  minute = 1000 * 60
  hour = minute * 60
  day = hour * 24
  week = day * 7
  month = day * 30
  year = month * 12
  decimals = $(e).data("decimals") || 0
  diff = new Date().getTime() - new Date(Date.parse $(e).attr "datetime").getTime()
  absolute = Math.abs diff
  # Check range
  if absolute < hour
    moment = "#{(absolute / minute).toFixed decimals} minutes"
  else if absolute < day
    moment = "#{(absolute / hour).toFixed decimals} hours"
  else if absolute < week
    moment = "#{(absolute / day).toFixed decimals} days"
  else if absolute < month
    moment = "#{(absolute / week).toFixed decimals} weeks"
  else if absolute < year
    moment = "#{(absolute / month).toFixed decimals} months"
  else moment = "#{(absolute / year).toFixed decimals} years"
  # Past or Future
  if diff > 0
    out = "#{moment} ago"
  else
    out = "in #{moment}"
  # Embed or add title attribute
  if $(e).data "embed"
    $(e).text "#{$(e).attr "datetime"} (#{out})"
  else if $(e).data "replace"
    $(e).text out
  else
    $(e).attr "title", out
  # Set every minute
  setTimeout ->
    dateTime e
  , 60 * 1000

$("[datetime]").each -> dateTime @