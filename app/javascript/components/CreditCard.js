import React from "react"
import PropTypes from "prop-types"
import Cards from "react-credit-cards";

class CreditCard extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      number: '', name: '', expiry: '', cvc: '', focused: 'number', inputs: null, amount_value: Math.floor(Math.random() * Math.floor(999))
    };
  }

  handleFocus(e){
    this.setState({focused: e.target.name});
  }
  handleChange(e) {
    this.setState({focused: e.target.name});
    this.setState({ [e.target.name]: e.target.value });
  }
  handleClick(){
    var cardNumber = document.querySelector('[data-name="cardNumber"]');
    var cardName = document.querySelector('[data-name="cardName"]');
    var expMonth = document.querySelector('[data-name="expMonth"]');
    var expYear = document.querySelector('[data-name="expYear"]');

    var cvc = document.querySelector('[data-name="cvc"]');
    var focused = document.getElementById('focused');
    this.setState({focused: focused.value})
    switch (focused.value) {
      case "number":
        this.setState({number: cardNumber.value})
        break;
      case "name":
        this.setState({name: cardName.value})
        break;
      case "expiry":
        this.setState({expiry: expMonth.value+expYear.value})
        break;
      case "cvc":
        this.setState({cvc: cvc.value})
        break;
    }
  }

  render () {
    return (
      <React.Fragment>
      <div className="col-md-12" id="card" onClick={this.handleClick.bind(this)}>
        <Cards
          number={this.state.number}
          name={this.state.name}
          expiry={this.state.expiry}
          cvc={this.state.cvc}
          focused={this.state.focused}
          />
      </div>
      </React.Fragment>
    );
  }
}
export default CreditCard
