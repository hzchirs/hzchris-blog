const Rest = {
  posts(method, post, data) {
    return $.ajax({
      url: Api.posts(post ? post.id : undefined),
      method: method,
      data: data
    })
  }
}

function getSelectedText() {
  var text = ''

  if (window.getSelection) {
    text = window.getSelection()
  }
  else if (document.getSelection) {
    text = document.getSelection()
  }
  else if (document.selection) {
    text = document.selection.createRange().text
  }

  return text
}
