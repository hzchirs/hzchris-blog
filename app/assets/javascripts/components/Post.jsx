class Post extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      post: props.post,
      title: {
        inEdit: false
      },
      content: {
        inEdit: false
      }
    }

    this.onTitleClick = this.onTitleClick.bind(this)
    this.onContentClick = this.onContentClick.bind(this)
  }

  componentDidMount() {
    this.simplemde = new SimpleMDE({
      autofocus: false,
      spellChecker: false,
      renderingConfig: {
        codeSyntaxHighlighting: true
      },
      element: document.getElementById(`post-content-${this.state.post.id}`)
    });
  }

  componentDidUpdate(prevProps, prevState) {
    const { title, content } = this.state

    $('html').unbind('click')
    $('html').click( () => {
      $('.post-content').css('min-height', 'initial')
      if(title.inEdit || content.inEdit) {
        this.handleUpdate()
      }
    })

    if(title.inEdit) {
      $('.post-title').focus()
    }

    if(content.inEdit) {
      this.simplemde = new SimpleMDE({
        autofocus: false,
        spellChecker: false,
        renderingConfig: {
          codeSyntaxHighlighting: true
        },
        element: document.getElementById(`post-content-${this.state.post.id}`)
      });
    }

    if(prevState.content.inEdit && !content.inEdit) {
      MathJax.Hub.Queue(["Typeset",MathJax.Hub])
    }

    $('input').unbind('click')
    $('input').click( e => {
      e.stopPropagation()
    })
    $('.content-text').unbind('click')
    $('.content-text').click( e => {
      e.stopPropagation()
    })
  }

  handleUpdate() {
    const { post } = this.state
    const newPostData = { post: {} },
      $postTitle = $('.post-title').val(),
      $postContent = this.simplemde ? this.simplemde.value() : undefined

    if($postTitle !== undefined && $postTitle !== post.title) {
      newPostData.post.title = $postTitle
    } else {
      this.setState({
        title: {
          inEdit: false
        }
      })
    }
    if($postContent !== undefined && $postContent !== post.content) {
      newPostData.post.content = $postContent
    } else {
      this.setState({
        content: {
          inEdit: false
        }
      })
    }

    if(!$.isEmptyObject(newPostData.post)) {
      $.ajax({
        url: Api.posts(post.id),
        method: 'PATCH',
        data: newPostData
      })
      .done( (data, textStatus) => {
        console.log(textStatus)
        this.simplemde = undefined
        this.setState({
          post: data.post,
          title: {
            inEdit: false
          },
          content: {
            inEdit: false
          }
        })
      })
      .fail( err => alert('err'))
    }
  }

  onTitleClick(e) {
    if(user.role === 'admin') {
      this.setState({
        title: {
          inEdit: true
        }
      })
    }
  }

  onContentClick(e) {
    if(user.role === 'admin') {
      $('.post-content').css('min-height', $('.post-content').height())
      this.setState({
        content: {
          inEdit: true
        }
      })
    }
  }

  renderTitle() {
    const { post, title } = this.state
    if(title.inEdit || post.title === null) {
      return (
        <Input ref="title"
          className="post-title"
          value={this.state.post.title}
        />
      )
    } else {
      return (
        <span>
          {this.state.post.title}
        </span>
      )
    }
  }

  renderContent() {
    const { post, content } = this.state
    if(content.inEdit || post.content === null) {
      return (
        <div className="content-text">
          <Textarea ref="content"
            id={`post-content-${this.state.post.id}`}
            className="post-content"
            style={{height: '1000px'}}
            value={this.state.post.content}
          />
        </div>
      )
    } else {
      return (
        <span>
          <p dangerouslySetInnerHTML={this.processContent()}>
          </p>
        </span>
      )
    }
  }

  processContent() {
    return {
      __html: marked(this.state.post.content)
    }
  }

  render() {
    const { post } = this.props
    return (
    <article ref="article">
      <h1 onClick={this.onTitleClick}>
        {this.renderTitle()}
      </h1>
      <div className="post-content" onClick={this.onContentClick}>
        {this.renderContent()}
      </div>
      <hr />
    </article>
    )
  }
}

Post.propTypes = {
  post: React.PropTypes.object.isRequired
}
