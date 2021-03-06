import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { receiveStep, removeStep } from '../actions/step_actions';
import { allSteps } from '../reducers/selectors';

class StepListItem extends Component {
  constructor(props){
    super(props);

    this.toggleDone = this.toggleDone.bind(this);
    this.deleteStep = this.deleteStep.bind(this);
  }

  toggleDone(e){
    let updatedStep = Object.assign(
      {},
      this.props.step,
      { done: !this.props.step.done }
    );
    this.props.receiveStep(updatedStep);
  }

  deleteStep(e){
    this.props.removeStep(this.props.step);
  }

  render(){
    let step = this.props.step;
    return (
      <li>

        <div
          className={`step-list-item-title${step.done ? ' done' : ''}`}
          onClick={ this.toggleDone }>
          {step.title}
        </div>

        <div
          className={`step-list-item-body${step.done ? ' done' : ''}`}>
          {step.body}
        </div>

        <button className='delete-btn' onClick={ this.deleteStep }>
          delete note
        </button>
      </li>
    );
  }
}

const mapDispatchToProps = dispatch => {
  return bindActionCreators( { receiveStep, removeStep }, dispatch);
};

export default connect(null, mapDispatchToProps)(StepListItem);
