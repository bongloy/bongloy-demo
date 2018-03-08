import React from "react"
import PropTypes from "prop-types"
import Cards from "react-credit-cards";

class CreditCard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      number: '', name: '', expiry: '', cvc: '', focused: 'number', inputs: null
    };
    this.state.inputs = ["number", "name", "expiry", "cvc"].map(
      (input_name) =>{
        return(
          <div className="form-group">
            <input
              key={input_name}
              type="text"
              name={input_name}
              onChange={ this.handleChange.bind(this) }
              onFocus ={ this.handleFocus.bind(this) }
              placeholder={input_name}
              className = "form-control"
            />
          </div>
        );
      }
    )
  }

  handleFocus(e){
    this.setState({focused: e.target.name});
  }
  handleChange(e) {
    this.setState({focused: e.target.name});
    this.setState({ [e.target.name]: e.target.value });
  }

  render () {
    return (
      <React.Fragment>
      <div className="col-md-4">
        <Cards
          number={this.state.number}
          name={this.state.name}
          expiry={this.state.expiry}
          cvc={this.state.cvc}
          focused={this.state.focused}
          />
      </div>
      <div className="col-md-6">
        {this.state.inputs}
        <hr />
        <div className="form-group">
          <input
            type="text"
            name="currency"
            disabled={true}
            value="USD"
            className = "form-control"
          />
        </div>
        <div className="form-group">
          <input
            type="text"
            name="amount"
            placeholder="amount"
            className = "form-control"
          />
        </div>
      </div>
      </React.Fragment>
    );
  }
}

export default CreditCard
