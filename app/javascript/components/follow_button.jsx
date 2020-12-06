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

  follow = () => {
    this.setState({
      loading: false
    })

    $.ajax({
      url: `/relationships`,
      dataType: 'json',
      contentType: 'application/json',
      type: 'POST',
      data: JSON.stringify({
        followed_id: this.props.user.id
      }),
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      cache: false
    }).then((response) => {
      this.setState({
        loading: false,
        relationship: response
      })
    })
  }

  unfollow = () => {
    this.setState({
      loading: true
    })

    $.ajax({
      url: `/relationships/${this.state.relationship.id}`,
      dataType: 'json',
      contentType: 'application/json',
      type: 'DELETE',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      },
      cache: false
    }).then((response) => {
      this.setState({
        loading: false,
        relationship: null
      })
    })
  }

  render() {
    const isFollowing = this.state.relationship !== null
    return (
      <>
        {isFollowing ? (
        <button onClick={this.unfollow} class = "unfollow_button">
        <span class="nomal">Following</span>
        <span class="hover">Unfollow</span>
        </button>
        ) : (
        <button onClick={this.follow} class = "follow_button">
          Follow
        </button>
        )}
      </>
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