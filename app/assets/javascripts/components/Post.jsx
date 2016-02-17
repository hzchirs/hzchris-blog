class Post extends React.Component {
  constructor(props) {
    super(props)
    this.initialState = {
      title: {
        inEdit: false
      },
      content: {
        inEdit: false
      },
      category: {
        inEdit: false
      }
    }
    this.state = this.initialState

    this.onTitleClick = this.onTitleClick.bind(this)
    this.onContentClick = this.onContentClick.bind(this)
  }

  componentDidUpdate(prevProps, prevState) {
    const { post } = this.props
    const { title, content } = this.state

    $('html').unbind('click')
    $('html').click( () => {
      if(this.simplemde && this.simplemde.value() !== '') {
        $('.post-content').css('min-height', 'initial')
      }
      if(title.inEdit || content.inEdit) {
        this.handleUpdate()
      }
    })

    if(title.inEdit) {
      $('.post-title').focus()
    }

    if(content.inEdit) {
      this.simplemde = new SimpleMDE({
        toolbar: false,
        autofocus: false,
        spellChecker: false,
        renderingConfig: {
          codeSyntaxHighlighting: true
        },
        element: document.getElementById(`post-content-${post.id}`)
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
    const { post, updatePost } = this.props
    const { title, content } = this.state
    const newPostData = { post: {} },
      $postTitle = $('.post-title').val(),
      $postContent = this.simplemde ? this.simplemde.value() : undefined

    if($postTitle !== undefined && $postTitle !== post.title) {
      newPostData.post.title = $postTitle
    } else {
      if(title.inEdit) {
        this.setState({
          title: {
            inEdit: false
          }
        })
      }
    }
    if($postContent !== undefined && $postContent !== post.content) {
      newPostData.post.content = $postContent
    } else {
      if(content.inEdit) {
        this.setState({
          content: {
            inEdit: false
          }
        })
      }
    }
    if(!$.isEmptyObject(newPostData.post)) {
      updatePost(post, newPostData)
      .done( () => {
        this.setState(this.initialState)
      })
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
    const { post } = this.props
    const { title } = this.state
    if(title.inEdit || post.title === null) {
      return (
        <Input ref="title"
          className="post-title"
          value={post.title}
        />
      )
    } else {
      return (
        <span>
          {post.title}
        </span>
      )
    }
  }

  renderContent() {
    const { post } = this.props
    const { content } = this.state
    if(content.inEdit || post.content === null) {
      return (
        <div className="content-text">
          <Textarea ref="content"
            id={`post-content-${post.id}`}
            className="post-content"
            style={{height: '1000px'}}
            value={post.content}
          />
        </div>
      )
    } else {
      return (
        <span dangerouslySetInnerHTML={this.processContent()}>
        </span>
      )
    }
  }

  // renderCategory(postCategoty) {
  //   const { categories } = this.props
  //   const { category } = this.state
  //
  //   if(category.inEdit) {
  //     return (
  //       <select ref="select">
  //         {categories.map(c =>
  //           <option value={c.id}>
  //             {c.name}
  //           </option>
  //         )}
  //       </select>
  //     )
  //   } else {
  //     return postCategoty.name
  //   }
  // }

  processContent() {
    return {
      __html: marked(this.props.post.content)
    }
  }

  render() {
    const { post, categories } = this.props
    const postCategoty = categories.filter(c => c.id === post.category_id)[0]

    return (
    <article ref="article">
      <h1 onClick={this.onTitleClick}>
        {this.renderTitle()}
      </h1>
      <div className="post-content" onClick={this.onContentClick}>
        {this.renderContent()}
      </div>
      <div className="post-tags">
        <ul className="menu">
          <li className="category">
            <a href={`/categories/${postCategoty.name}`}>
              {postCategoty.name}
            </a>
          </li>
        </ul>
      </div>
      <hr />
    </article>
    )
  }
}

Post.propTypes = {
  post: React.PropTypes.object.isRequired,
  categories: React.PropTypes.array.isRequired,
  updatePost: React.PropTypes.func.isRequired
}
