import React from 'react';
import Header from './header';
import ProductList from './product-list';
import ProductDetails from './product-details';
import CartSummary from './cart-summary';
import CheckoutForm from './checkout-form';
import DisclaimerModal from './disclaimer-modal';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      view: { name: 'catalog', params: {} },
      cart: [],
      disclaimerAgreed: false,
      previousView: {}
    };
    this.setView = this.setView.bind(this);
    this.getCartItems = this.getCartItems.bind(this);
    this.addToCart = this.addToCart.bind(this);
    this.placeOrder = this.placeOrder.bind(this);
    this.onAgreeClick = this.onAgreeClick.bind(this);
    this.formatPriceNumber = this.formatPriceNumber.bind(this);
  }

  onAgreeClick() {
    this.setState({ disclaimerAgreed: true });
  }

  setView(name, params, prevName, prevParams) {
    this.setState({ view: { name: name, params: params } });
  }

  getCartItems() {
    fetch('/api/cart')
      .then(res => res.json())
      .then(data => {
        this.setState({ cart: data });
      })
      .catch(err => console.error('Error:', err));
  }

  addToCart(product) {
    const init = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' }
    };
    fetch(`/api/cart/${product.productId}`, init)
      .then(res => res.json())
      .then(data => {
        const newCart = [...this.state.cart];
        newCart.push(data);
        this.setState({ cart: newCart });
      })
      .catch(err => console.error(err));
  }

  placeOrder(orderInfo) {
    const init = {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(orderInfo)
    };
    fetch('/api/orders', init).then(res => {
      this.setState({ cart: [], view: { name: 'catalog', params: {} } });
    });
  }

  formatPriceNumber(price) {
    const priceStr = price.toString().split('');
    const len = priceStr.length;
    const adder = len % 3;
    if (len > 3) {
      for (let i = adder; i < len; i += 3) {
        priceStr.splice(i, 0, ',');
      }
    }
    return priceStr.join('');
  }

  componentDidMount() {
    this.getCartItems();
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    if (
      this.state.view.params !== prevState.view.params &&
      prevState.view.name !== 'details'
    ) {
      this.setState({ previousView: prevState.view });
    }
  }

  render() {
    if (this.state.view.name === 'category') {
      return (
        <div className="container-fluid">
          <Header
            cartItemCount={this.state.cart.length}
            setView={this.setView}
          />
          <ProductList
            setView={this.setView}
            categoryInfo={this.state.view.params}
            formatPrice={this.formatPriceNumber}
          />
        </div>
      );
    } else if (this.state.view.name === 'catalog') {
      return (
        <div className="container-fluid">
          <Header
            cartItemCount={this.state.cart.length}
            setView={this.setView}
          />
          <ProductList
            setView={this.setView}
            store={this.state.view.params}
            prevView={this.state.previousView}
            formatPrice={this.formatPriceNumber}
          />
          <DisclaimerModal
            onAgreeClick={this.onAgreeClick}
            agreeStatus={this.state.disclaimerAgreed}
          />
        </div>
      );
    } else if (this.state.view.name === 'details') {
      return (
        <div className="container-fluid">
          <Header
            cartItemCount={this.state.cart.length}
            setView={this.setView}
          />
          <ProductDetails
            productId={this.state.view.params}
            setView={this.setView}
            addToCart={this.addToCart}
            prevView={this.state.previousView}
            formatPrice={this.formatPriceNumber}
          />
        </div>
      );
    } else if (this.state.view.name === 'cart') {
      return (
        <div className="container-fluid">
          <Header
            cartItemCount={this.state.cart.length}
            setView={this.setView}
          />
          <CartSummary setView={this.setView} cartItems={this.state.cart} formatPrice={this.formatPriceNumber} />
        </div>
      );
    } else if (this.state.view.name === 'checkout') {
      return (
        <div className="container-fluid">
          <Header
            cartItemCount={this.state.cart.length}
            setView={this.setView}
          />
          <CheckoutForm
            placeOrder={this.placeOrder}
            orderItems={this.state.cart}
            setView={this.setView}
            formatPrice={this.formatPriceNumber}
          />
        </div>
      );
    }
  }
}

export default App;
