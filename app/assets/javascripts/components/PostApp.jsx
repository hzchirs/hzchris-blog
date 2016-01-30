class PostApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      posts: [props.post]
    }
  }

  render() {
    return (
      <div className="well bs-component content">
        {this.state.posts.map(post =>
          <Post key={post.id} post={post} />
         )}
      </div>
    )
  }
}

PostApp.propTypes = {
  post: React.PropTypes.object
}
