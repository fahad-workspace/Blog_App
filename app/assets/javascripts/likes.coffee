# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.calledIt = (ele) ->
  if document.getElementsByClassName('glyphicon-thumbs-down').length > 0
    document.getElementById('like_button').className = "glyphicon glyphicon-thumbs-up"
    document.getElementById('like_button').innerHTML = " Like"
    return
  if document.getElementsByClassName('glyphicon-thumbs-up').length > 0
    document.getElementById('like_button').className = "glyphicon glyphicon-thumbs-down"
    document.getElementById('like_button').innerHTML = " Dislike"
    return