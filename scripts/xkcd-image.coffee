# Description:
#   Replies with the comic image when an XKCD url is sent
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
# AdamEdgett

module.exports = (robot) ->
  robot.hear /https?:\/\/(www.)?xkcd.com(\/\d+)?/i, (msg) ->
    num = if msg.match[2] then "#{msg.match[2]}" else ""
    msg.http("http://xkcd.com#{num}/info.0.json")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Comic not found.'
        else
          object = JSON.parse(body)
          msg.send object.title, object.img, object.alt
