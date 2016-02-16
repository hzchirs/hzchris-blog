class PostApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      posts: [props.post],
      categories: props.categories
    }

    this.updatePost = this.updatePost.bind(this)
  }

  updatePost(targetPost, newPostData) {
    const { posts } = this.state
    let index = posts.map( post => post.id).indexOf(targetPost.id)

    if(!$.isEmptyObject(newPostData.post)) {
      return Rest.posts('PATCH', targetPost, newPostData)
      .done( (data, textStatus) => {
        this.simplemde = undefined
        this.setState({
          posts: [...posts.slice(0, index),
          data.post, ...posts.slice(index + 1)]
        })
      })
      .fail( err => alert('err'))
    }
  }

  render() {
    const { posts, categories } = this.state
    return (
      <div className="content">
        {posts.map(post =>
          <Post key={post.id}
            post={post}
            categories={categories}
            updatePost={this.updatePost}
          />
         )}
      </div>
    )
  }
}

PostApp.propTypes = {
  post: React.PropTypes.object.isRequired,
  categories: React.PropTypes.array.isRequired
}
