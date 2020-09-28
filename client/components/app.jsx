import React from 'react';
import Header from './header';
import ProductList from './product-list';

class App extends React.Component {
  render() {
    return (
      <div className="container-fluid">
        <Header />
        <ProductList />
      </div>
    );
  }
}

export default App;
