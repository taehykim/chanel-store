import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { stores: [] };
    this.getAllStores = this.getAllStores.bind(this);
    this.getStoreId = this.getStoreId.bind(this);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.onCoffeeStoreClick = this.onCoffeeStoreClick.bind(this);
    this.onAllClick = this.onAllClick.bind(this);
  }

  handleCartClick() {
    this.props.setView('cart', {});
  }

  getStoreId(storeName) {
    for (let i = 0; i < this.state.stores.length; i++) {
      if (this.state.stores[i].name === storeName) {
        return this.state.stores[i].storeId;
      }
    }
    return null;
  }

  onCoffeeStoreClick(event) {
    const storeId = this.getStoreId(event.target.text);
    this.props.setView('store', storeId);
  }

  onAllClick() {
    this.props.setView('catalog', {});
  }

  getAllStores() {
    fetch('/api/stores')
      .then(res => res.json())
      .then(data => {
        this.setState({ stores: data });
      })
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getAllStores();
  }

  render() {
    return (
      <nav className="row navbar navbar-expand-lg navbar-light bg-light">
        <a className="navbar-brand" href="#">
          Coffee Farm
        </a>
        <button
          className="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto">
            <li className="nav-item active">
              <a className="nav-link" href="#" onClick={this.onAllClick}>
                Home <span className="sr-only">(current)</span>
              </a>
            </li>
            <li className="nav-item dropdown">
              <a
                className="nav-link dropdown-toggle"
                href="#"
                id="navbarDropdown"
                role="button"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                Shop by Stores
              </a>
              <div className="dropdown-menu" aria-labelledby="navbarDropdown">
                <a className="dropdown-item" onClick={this.onAllClick}>
                  View All
                </a>
                {this.state.stores.map(store => (
                  <a
                    key={store.storeId}
                    className="dropdown-item"
                    value={store.name}
                    onClick={this.onCoffeeStoreClick}
                  >
                    {store.name}
                  </a>
                ))}
              </div>
            </li>
          </ul>

          <span className="cart-btn" onClick={this.handleCartClick}>
            <span>{this.props.cartItemCount} items </span>
            <i className="fas fa-shopping-cart"></i>
          </span>
        </div>
      </nav>
    );
  }
}

export default Header;
