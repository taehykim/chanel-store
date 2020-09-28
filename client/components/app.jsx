import React from 'react';
import Header from './header';
import ProductList from './product-list';
import ProductDetails from './product-details';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { view: { name: 'catalog', params: {} } };
    this.setView = this.setView.bind(this);
  }

  setView(name, params) {
    this.setState({ view: { name: name, params: params } });
  }

  render() {
    return this.state.view.name === 'catalog' ? (
      <div className="container-fluid">
        <Header />
        <ProductList setView={this.setView} />
      </div>
    ) : (
      <div className="container-fluid">
        <Header />
        <ProductDetails
          productId={this.state.view.params}
          setView={this.setView}
        />
      </div>
    );
  }
}

export default App;
