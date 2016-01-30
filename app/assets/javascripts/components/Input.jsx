class Input extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      value: props.value
    }

    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(e) {
    this.setState({
      value: e.target.value
    })
  }

  render() {
    const { name, className } = this.props
    return (
      <input name={name}
        value={this.state.value}
        className={`form-control ${className}`}
        onChange={this.handleChange}
      />
    )
  }
}
