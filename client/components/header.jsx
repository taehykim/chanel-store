import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { stores: [], show: true };
    this.getAllStores = this.getAllStores.bind(this);
    this.getStoreId = this.getStoreId.bind(this);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.onCoffeeStoreClick = this.onCoffeeStoreClick.bind(this);
    this.onAllClick = this.onAllClick.bind(this);
    this.onStoreClick = this.onStoreClick.bind(this);
  }

  handleCartClick() {
    this.setState({ show: false });
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
    this.setState({ show: false });
    const storeId = this.getStoreId(event.target.text);
    this.props.setView('store', storeId);
  }

  onAllClick() {
    this.setState({ show: false });
    this.props.setView('catalog', {});
  }

  onStoreClick() {
    this.setState({ show: false });
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

  componentDidUpdate(prevProps, prevState) {
    if (prevState.show !== this.state.show) {
      this.setState({ show: true });
    }
  }

  render() {
    let navbarClassName = 'collapse navbar-collapse';
    if (!this.state.show) {
      navbarClassName = 'collapse navbar-collapse d-none';
    }

    return (
      <nav
        className="row navbar navbar-expand-lg navbar-light"
        style={{ backgroundColor: '#dfd7cb' }}
      >
        <a className="navbar-brand logo">Coffee Farm</a>
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

        <div className={navbarClassName} id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto">
            <li className="nav-item active">
              <a className="nav-link" href="#" onClick={this.onAllClick}>
                HOME <span className="sr-only">(current)</span>
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
                SHOP BY STORES
              </a>
              <div
                className="dropdown-menu"
                aria-labelledby="navbarDropdown"
                style={{ cursor: 'pointer' }}
              >
                <a className="dropdown-item" onClick={this.onAllClick}>
                  <b>View All</b>
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

          <span className="cart-btn mr-4" onClick={this.handleCartClick}>
            <span>{this.props.cartItemCount} ITEMS </span>
            <i className="fas fa-shopping-bag fa-lg"></i>
          </span>
        </div>
      </nav>
    );
  }
}

export default Header;
