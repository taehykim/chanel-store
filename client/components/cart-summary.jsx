import React from 'react';
import CardSummaryItem from './cart-summary-item';

class CartSummary extends React.Component {
  constructor(props) {
    super(props);
    this.onBackToCatalogClick = this.onBackToCatalogClick.bind(this);
    this.getTotalPrice = this.getTotalPrice.bind(this);
  }

  onBackToCatalogClick() {
    this.props.setView('catalog', {});
  }

  getTotalPrice() {
    let total = 0;
    for (let i = 0; i < this.props.cartItems.length; i++) {
      total += this.props.cartItems[i].price;
    }
    return total / 100;
  }

  render() {
    return (
      <div className="d-flex flex-column p-5 mx-auto" style={{ width: '90%' }}>
        <div className="back my-3" onClick={this.onBackToCatalogClick}>
          &lt; Back to catalog
        </div>
        <div className="h1">My Cart</div>
        <div>
          {this.props.cartItems.map(item => (
            <CardSummaryItem item={item} key={item.cartItemId} />
          ))}
        </div>
        <div className="h2">Item Total: ${this.getTotalPrice()}</div>
      </div>
    );
  }
}

export default CartSummary;
