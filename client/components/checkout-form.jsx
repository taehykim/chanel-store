import React from 'react';

class CheckoutForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { name: '', creditCard: '', shippingAddress: '' };
    this.getTotalPrice = this.getTotalPrice.bind(this);
    this.onBackClick = this.onBackClick.bind(this);
    this.handleNameChange = this.handleNameChange.bind(this);
    this.handleCreditCardChange = this.handleCreditCardChange.bind(this);
    this.handleShippingAddressChange = this.handleShippingAddressChange.bind(
      this
    );
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  getTotalPrice() {
    let total = 0;
    for (let i = 0; i < this.props.orderItems.length; i++) {
      total += this.props.orderItems[i].price;
    }
    return total / 100;
  }

  onBackClick() {
    this.props.setView('catalog', {});
  }

  handleNameChange(event) {
    this.setState({ name: event.target.value });
  }

  handleCreditCardChange(event) {
    this.setState({ creditCard: event.target.value });
  }

  handleShippingAddressChange(event) {
    this.setState({ shippingAddress: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.props.placeOrder(this.state);
    this.setState({ name: '', creditCard: '', shippingAddress: '' });
  }

  render() {
    return (
      <div className="row vh-100 body-custom white-font">
        <div
          className="d-flex flex-column p-5 mx-auto"
          style={{ width: '90%' }}
        >
          <div className="h1">My Cart</div>
          <div className="h4">Order Total: ${this.getTotalPrice()}</div>
          <form onSubmit={this.handleSubmit}>
            <div className="form-group">
              <label>Name</label>
              <input
                type="text"
                className="form-control"
                value={this.state.name}
                onChange={this.handleNameChange}
              />
            </div>
            <div className="form-group">
              <label>Credit Card</label>
              <input
                type="text"
                className="form-control"
                value={this.state.creditCard}
                onChange={this.handleCreditCardChange}
              />
            </div>
            <div className="form-group">
              <label>Shipping Address</label>
              <textarea
                className="form-control"
                rows="4"
                value={this.state.shippingAddress}
                onChange={this.handleShippingAddressChange}
              ></textarea>
            </div>
            <div className="d-flex justify-content-between">
              <div className="back" onClick={this.onBackClick}>
                &lt; Continue Shopping
              </div>
              <button type="submit" className="btn btn-primary">
                Place Order
              </button>
            </div>
          </form>
        </div>
      </div>
    );
  }
}

export default CheckoutForm;
