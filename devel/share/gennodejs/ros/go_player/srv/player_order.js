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

class player_orderRequest {
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
    // Serializes a message object of type player_orderRequest
    // Serialize message field [state]
    bufferOffset = _serializer.string(obj.state, buffer, bufferOffset);
    // Serialize message field [kind]
    bufferOffset = _serializer.string(obj.kind, buffer, bufferOffset);
    // Serialize message field [level]
    bufferOffset = _serializer.string(obj.level, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type player_orderRequest
    let len;
    let data = new player_orderRequest(null);
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
    return 'go_player/player_orderRequest';
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
    const resolved = new player_orderRequest(null);
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

class player_orderResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.step = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('step')) {
        this.step = initObj.step
      }
      else {
        this.step = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type player_orderResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [step]
    bufferOffset = _arraySerializer.int8(obj.step, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type player_orderResponse
    let len;
    let data = new player_orderResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [step]
    data.step = _arrayDeserializer.int8(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.step.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'go_player/player_orderResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4386e1c0ee0164cbde602d58249d27dc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    bool success
    int8[] step
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new player_orderResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.step !== undefined) {
      resolved.step = msg.step;
    }
    else {
      resolved.step = []
    }

    return resolved;
    }
};

module.exports = {
  Request: player_orderRequest,
  Response: player_orderResponse,
  md5sum() { return '1e0b8396f26d47b0b616e36d5b4d6a67'; },
  datatype() { return 'go_player/player_order'; }
};
