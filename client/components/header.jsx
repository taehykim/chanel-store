import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
    this.state = { categories: [], show: true };
    this.getAllCategories = this.getAllCategories.bind(this);
    this.getCategoryId = this.getCategoryId.bind(this);
    this.handleCartClick = this.handleCartClick.bind(this);
    this.onCategoryClick = this.onCategoryClick.bind(this);
    this.onAllClick = this.onAllClick.bind(this);
    this.onStoreClick = this.onStoreClick.bind(this);
  }

  handleCartClick() {
    this.setState({ show: false });
    this.props.setView('cart', {});
  }

  getCategoryId(categoryName) {
    for (let i = 0; i < this.state.categories.length; i++) {
      if (this.state.categories[i].name === categoryName) {
        return this.state.categories[i].categoryId;
      }
    }
    return null;
  }

  onCategoryClick(event) {
    this.setState({ show: false });
    const categoryId = this.getCategoryId(event.target.text);
    this.props.setView('category', { name: event.target.text, categoryId: categoryId });
  }

  onAllClick() {
    this.setState({ show: false });
    this.props.setView('catalog', {});
  }

  onStoreClick() {
    this.setState({ show: false });
  }

  getAllCategories() {
    fetch('/api/categories')
      .then(res => res.json())
      .then(data => {
        this.setState({ categories: data });
      })
      .catch(err => console.error(err));
  }

  componentDidMount() {
    this.getAllCategories();
  }

  componentDidUpdate(prevProps, prevState) {
    if (prevState.show !== this.state.show) {
      this.setState({ show: true });
    }
  }

  render() {

    let navbarClassName = 'collapse navbar-collapse justify-content-center';
    if (!this.state.show) {
      navbarClassName = 'collapse navbar-collapse d-none justify-content-center';
    }

    return (
      <>
        <div className="row justify-content-center mt-3">
          <h1 className="text-uppercase">chanel</h1>
        </div>
        <nav
          className="row navbar navbar-expand-lg navbar-light"
        >
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
            <ul className="navbar-nav navbar">
              <li className="nav-item active">
                <a className="nav-link nav-link-grow-up" href="#" onClick={this.onAllClick}>
                  HOME <span className="sr-only">(current)</span>
                </a>
              </li>
              {this.state.categories.map(category => (
                <li className="nav-item" key={category.categoryId}>
                  <a className="nav-link nav-link-grow-up text-uppercase" href="#" value={category.name}
                    onClick={this.onCategoryClick}>{category.name}</a>
                </li>))}
            </ul>

            <span className="cart-btn mr-4" onClick={this.handleCartClick}>
              <span>{this.props.cartItemCount} ITEMS </span>
              <i className="fas fa-shopping-bag fa-lg"></i>
            </span>
          </div>
        </nav>
      </>
    );
  }
}

export default Header;
