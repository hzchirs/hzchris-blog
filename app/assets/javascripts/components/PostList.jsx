class PostList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      posts: [...props.posts]
    }

    this.onDeleteClick = this.onDeleteClick.bind(this)
  }

  onDeleteClick(post) {
    const { posts } = this.state
    
    $.ajax({
      url: Api.posts(post.id),
      method: 'DELETE'
    })
    .done( data => {
      this.setState({
        posts: posts.filter( post => post.id !== data.post.id)
      })
    })
    .fail( error => alert('Delete failed'))
  }

  render() {
    const { posts } = this.state
    return (
      <div id="post-list">
        {posts.map( post =>
          <div className="post-item" key={post.id}>
            <a href={`posts/${post.id}`}>
              <div id="posts" className="blog-post">
                <h2>{post.title}</h2>
                <p>
                  {post.content}
                </p>
              </div>
            </a>
            <a href="#"
              className="alert button"
              onClick={ e => {
                e.preventDefault()
                this.onDeleteClick(post)
              }}>
              刪除
            </a>
            <hr/>
          </div>
        )}
      </div>
    )
  }
}
