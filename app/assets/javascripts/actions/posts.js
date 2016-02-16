const Rest = {
  posts(method, post, data) {
    return $.ajax({
      url: Api.posts(post ? post.id : undefined),
      method: method,
      data: data
    })
  }
}
