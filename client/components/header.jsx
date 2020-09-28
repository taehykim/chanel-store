import React from 'react';

class Header extends React.Component {
  render() {
    return (
      <div className="row bg-dark text-light px-5 py-3 justify-center-start align-items-center">
        <span className="h5 m-0">
          <i className="fas fa-dollar-sign mr-1"></i>
          Wicked Sales
        </span>
      </div>
    );
  }
}

export default Header;
