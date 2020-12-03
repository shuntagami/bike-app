import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class FollowButton extends Component {
  constructor(props) {
    super(props)
    
    this.state = {
      loading: false,
      relationship: props.relationship
    }
  }

  render() {
    return (
      <div>
        <button>
          { this.state.relationship !== null ? 'Unfollow' : 'Follow' }
        </button>
      </div>
    )
  }
}

FollowButton.defaultProps = {
  relationship: null
}

FollowButton.propTypes = {
  relationship: PropTypes.object,
  user: PropTypes.object.isRequired
}