import React from 'react';
import ProductListItem from './product-list-item';

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
    return total;
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
      <div
        className="row body-custom"
        style={{ minHeight: '100vh' }}
      >
        <div
          className="d-flex flex-column p-5 mx-auto mobile-padding-1"
          style={{ width: '90%' }}
        >
          <div className="h1 text-uppercase text-center">Checkout</div>
          <div className="row d-flex justify-content-around align-items-center">
            <div className="checkout-div">
              <div className="h4 text-uppercase text-center checkout-title-border py-3">Order Summary</div>
              <div className="row">
                {this.props.orderItems.map(item => <ProductListItem
                  key={item.cartItemId}
                  product={item}
                  formatPrice={this.props.formatPrice}
                />)}
              </div>
              <hr />
              <div className="h4 text-uppercase text-right"> Total: ${this.props.formatPrice(this.getTotalPrice() / 100)}</div>
            </div>
            <div className="checkout-div">
              <div className="h4 text-uppercase text-center checkout-title-border py-3">Billing Information</div>
              <form onSubmit={this.handleSubmit}>
                <div className="form-group">
                  {/* <label>Name</label> */}
                  <input
                    type="text"
                    className="form-control border-top-0 border-right-0 border-left-0"
                    value={this.state.name}
                    onChange={this.handleNameChange}
                    placeholder="Name on card"
                    required
                  />
                </div>
                <div className="form-group">
                  {/* <label>Credit Card</label> */}
                  <input
                    type="text"
                    className="form-control border-top-0 border-right-0 border-left-0"
                    value={this.state.creditCard}
                    onChange={this.handleCreditCardChange}
                    placeholder="Card number"
                    required
                  />
                </div>
                <div className="form-group">
                  {/* <label>Shipping Address</label> */}
                  <textarea
                    className="form-control border-top-0 border-right-0 border-left-0"
                    rows="4"
                    value={this.state.shippingAddress}
                    onChange={this.handleShippingAddressChange}
                    placeholder="Shipping Address"
                    required
                  ></textarea>
                </div>
                <div className="d-flex flex-column justify-content-center align-items-center">
                  <button type="submit" className="btn btn-dark text-uppercase p-3 checkout-div place-order-btn d-flex justify-content-center mobile-btn">
                    <p className="m-0">Place Order</p>
                  </button>
                  <div className="back my-3 checkout-div text-center p-3 bold-border text-uppercase custom-btn d-flex justify-content-center mobile-btn" onClick={this.onBackClick}>
                    <p className="m-0">Continue Shopping</p>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div >
    );
  }
}

export default CheckoutForm;
