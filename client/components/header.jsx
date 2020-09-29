import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.handleCartClick = this.handleCartClick.bind(this);
  }

  handleCartClick() {
    this.props.setView('cart', {});
  }

  render() {
    return (
      <div className="row bg-dark text-light px-5 py-3 justify-content-between align-items-center">
        <span className="h5 m-0">
          <i className="fas fa-dollar-sign mr-1"></i>
          Wicked Sales
        </span>
        <span className="cart-btn" onClick={this.handleCartClick}>
          <span>{this.props.cartItemCount} items </span>
          <i className="fas fa-shopping-cart"></i>
        </span>
      </div>
    );
  }
}

export default Header;
