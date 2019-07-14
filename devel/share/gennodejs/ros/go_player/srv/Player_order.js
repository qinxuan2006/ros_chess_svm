// Auto-generated. Do not edit!

// (in-package go_player.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class Player_orderRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.state = null;
      this.kind = null;
      this.level = null;
    }
    else {
      if (initObj.hasOwnProperty('state')) {
        this.state = initObj.state
      }
      else {
        this.state = '';
      }
      if (initObj.hasOwnProperty('kind')) {
        this.kind = initObj.kind
      }
      else {
        this.kind = '';
      }
      if (initObj.hasOwnProperty('level')) {
        this.level = initObj.level
      }
      else {
        this.level = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Player_orderRequest
    // Serialize message field [state]
    bufferOffset = _serializer.string(obj.state, buffer, bufferOffset);
    // Serialize message field [kind]
    bufferOffset = _serializer.string(obj.kind, buffer, bufferOffset);
    // Serialize message field [level]
    bufferOffset = _serializer.string(obj.level, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Player_orderRequest
    let len;
    let data = new Player_orderRequest(null);
    // Deserialize message field [state]
    data.state = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [kind]
    data.kind = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [level]
    data.level = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.state.length;
    length += object.kind.length;
    length += object.level.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'go_player/Player_orderRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a3c58b4f1576da4268c38a742885e2c3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string state
    string kind
    string level
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Player_orderRequest(null);
    if (msg.state !== undefined) {
      resolved.state = msg.state;
    }
    else {
      resolved.state = ''
    }

    if (msg.kind !== undefined) {
      resolved.kind = msg.kind;
    }
    else {
      resolved.kind = ''
    }

    if (msg.level !== undefined) {
      resolved.level = msg.level;
    }
    else {
      resolved.level = ''
    }

    return resolved;
    }
};

class Player_orderResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.do_step = null;
      this.remove_step = null;
      this.win_side = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('do_step')) {
        this.do_step = initObj.do_step
      }
      else {
        this.do_step = [];
      }
      if (initObj.hasOwnProperty('remove_step')) {
        this.remove_step = initObj.remove_step
      }
      else {
        this.remove_step = [];
      }
      if (initObj.hasOwnProperty('win_side')) {
        this.win_side = initObj.win_side
      }
      else {
        this.win_side = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Player_orderResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [do_step]
    bufferOffset = _arraySerializer.int8(obj.do_step, buffer, bufferOffset, null);
    // Serialize message field [remove_step]
    bufferOffset = _arraySerializer.int8(obj.remove_step, buffer, bufferOffset, null);
    // Serialize message field [win_side]
    bufferOffset = _serializer.string(obj.win_side, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Player_orderResponse
    let len;
    let data = new Player_orderResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [do_step]
    data.do_step = _arrayDeserializer.int8(buffer, bufferOffset, null)
    // Deserialize message field [remove_step]
    data.remove_step = _arrayDeserializer.int8(buffer, bufferOffset, null)
    // Deserialize message field [win_side]
    data.win_side = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.do_step.length;
    length += object.remove_step.length;
    length += object.win_side.length;
    return length + 13;
  }

  static datatype() {
    // Returns string type for a service object
    return 'go_player/Player_orderResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '32759e1a82e311157548dde213cf81e2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool success
    int8[] do_step
    int8[] remove_step
    string win_side
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Player_orderResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.do_step !== undefined) {
      resolved.do_step = msg.do_step;
    }
    else {
      resolved.do_step = []
    }

    if (msg.remove_step !== undefined) {
      resolved.remove_step = msg.remove_step;
    }
    else {
      resolved.remove_step = []
    }

    if (msg.win_side !== undefined) {
      resolved.win_side = msg.win_side;
    }
    else {
      resolved.win_side = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: Player_orderRequest,
  Response: Player_orderResponse,
  md5sum() { return '8b5ce4bcaa3e0d90fdecb196f6925e60'; },
  datatype() { return 'go_player/Player_order'; }
};
