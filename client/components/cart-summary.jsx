import React from 'react';
import CartSummaryItem from './cart-summary-item';

class CartSummary extends React.Component {
  constructor(props) {
    super(props);
    this.onBackToCatalogClick = this.onBackToCatalogClick.bind(this);
    this.getTotalPrice = this.getTotalPrice.bind(this);
    this.onCheckoutClick = this.onCheckoutClick.bind(this);
  }

  onBackToCatalogClick() {
    this.props.setView('catalog', {});
  }

  onCheckoutClick() {
    this.props.setView('checkout', {});
  }

  getTotalPrice() {
    let total = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      total += this.props.cartItems[i].price;
    }
    return total;
  }

  render() {
    return (
      <div className="row body-custom" style={{ minHeight: '100vh' }}>
        <div
          className="d-flex flex-column p-5 mx-auto cart-mobile"
          style={{ width: '90%' }}
        >
          <div
            className="back my-3"
            onClick={this.onBackToCatalogClick}
          >
            &lt; Back to catalog
          </div>
          <div className="h1 text-center text-uppercase">Shopping Bag</div>
          <div>
            {this.props.cartItems.map(item => (
              <CartSummaryItem item={item} key={item.cartItemId} formatPrice={this.props.formatPrice} updateCart={this.props.updateCart}/>
            ))}
          </div>
          {this.props.cartItems.length !== 0 ? (
            <div className="d-flex justify-content-between align-items-center checkout-total p-5">
              <div className="h3 text-uppercase">Total: ${this.props.formatPrice(this.getTotalPrice() / 100)}</div>
              <div>
                <button
                  type="button"
                  className="btn btn-dark text-uppercase py-3 px-5"
                  onClick={this.onCheckoutClick}
                >
                  Continue to Checkout
                </button>
              </div>
            </div>
          ) : <div className="h5 text-center font-weight-light">Your bag is empty</div>}
        </div>
      </div>

    );
  }
}

export default CartSummary;
