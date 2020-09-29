import React from 'react';
import Header from './header';
import ProductList from './product-list';
import ProductDetails from './product-details';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { view: { name: 'catalog', params: {} }, cart: [] };
    this.setView = this.setView.bind(this);
    this.getCartItems = this.getCartItems.bind(this);
    this.addToCart = this.addToCart.bind(this);
  }

  setView(name, params) {
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

  componentDidMount() {
    this.getCartItems();
  }

  render() {
    return this.state.view.name === 'catalog' ? (
      <div className="container-fluid">
        <Header cartItemCount={this.state.cart.length} />
        <ProductList setView={this.setView} />
      </div>
    ) : (
      <div className="container-fluid">
        <Header cartItemCount={this.state.cart.length} />
        <ProductDetails
          productId={this.state.view.params}
          setView={this.setView}
          addToCart={this.addToCart}
        />
      </div>
    );
  }
}

export default App;
