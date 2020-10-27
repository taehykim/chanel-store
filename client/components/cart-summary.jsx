import React from 'react';
import CartSummaryItem from './cart-summary-item';

class CartSummary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { grouped: {} };
    this.onBackToCatalogClick = this.onBackToCatalogClick.bind(this);
    this.getTotalPrice = this.getTotalPrice.bind(this);
    this.onCheckoutClick = this.onCheckoutClick.bind(this);
    this.groupProducts = this.groupProducts.bind(this);
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

  groupProducts() {
    const productIds = [];
    const groupedCartItems = {};
    for (let i = 0; i < this.props.cartItems.length; i++) {
      productIds.push(this.props.cartItems[i].productId);
    }

    const uniqueProductIds = [...new Set(productIds)];

    for (let k = 0; k < uniqueProductIds.length; k++) {
      groupedCartItems[uniqueProductIds[k]] = { count: 0, item: null };
    }

    for (let m = 0; m < this.props.cartItems.length; m++) {
      groupedCartItems[this.props.cartItems[m].productId].count++;
      groupedCartItems[this.props.cartItems[m].productId].item = this.props.cartItems[m];
    }

    this.setState({ grouped: groupedCartItems });
  }

  componentDidMount() {
    this.groupProducts();
  }

  componentDidUpdate(prevProps) {
    if (this.props.cartItems.length !== prevProps.cartItems.length) {
      this.groupProducts();
    }
  }

  render() {
    return (
      <div className="row body-custom" style={{ minHeight: '100vh' }}>
        <div
          className="d-flex flex-column p-5 mx-auto cart-mobile"
          style={{ width: '90%' }}
        >
          <div className="h1 text-center text-uppercase">Shopping Bag</div>
          <div>
            {Object.keys(this.state.grouped).length !== 0 ? (
              Object.keys(this.state.grouped).map(productId => (
                <CartSummaryItem key={productId} formatPrice={this.props.formatPrice} updateCart={this.props.updateCart} groupedItem={this.state.grouped[productId]} />
              ))
            ) : <></>}
          </div>
          {this.props.cartItems.length !== 0 ? (
            <div className="d-flex justify-content-between align-items-center checkout-total p-5 mobile-col">
              <div className="h3 text-uppercase">Total: ${this.props.formatPrice(this.getTotalPrice() / 100)}</div>
              <div className="d-flex flex-column">
                <button
                  type="button"
                  className="btn btn-dark text-uppercase py-3 px-5 summary-btn-black mobile-btn"
                  onClick={this.onCheckoutClick}
                >
                  <p className="m-0">Continue to Checkout</p>
                </button>
                <button
                  type="button"
                  className="btn text-uppercase py-3 px-5 my-2 bold-border summary-btn-white mobile-btn"
                  onClick={this.onBackToCatalogClick}
                >
                  <p className="m-0">Continue Shopping</p>
                </button>
              </div>
            </div>
          )
            : <>
              <div className="h5 text-center font-weight-light">Your bag is empty</div>
              <div className="d-flex justify-content-center">
                <div
                  className="btn btn-dark text-uppercase py-3 px-5 m-4 summary-btn-white"
                  onClick={this.onBackToCatalogClick}
                >
                  <p className="m-0">Continue Shopping</p>
                </div>
              </div>
            </>
          }
        </div>
      </div>

    );
  }
}

export default CartSummary;
