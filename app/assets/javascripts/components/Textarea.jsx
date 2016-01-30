class Textarea extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: props.value
    }

    this.handleChange = this.handleChange.bind(this)
  }

  componentDidMount() {
    $('textarea').autosize()
  }

  handleChange(e) {
    this.setState({
      value: e.target.value
    })
  }

  render() {
    const { name, id, className } = this.props
    return (
      <textarea name={name}
        id={id}
        value={this.state.value}
        className={`form-control ${className}`}
        onChange={this.handleChange}
      />
    )
  }
}
