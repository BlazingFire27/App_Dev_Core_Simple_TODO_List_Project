const mongoose = require('mongoose');

const TaskSchema = new mongoose.Schema({
    userId: {
        type: String,
        ref: 'User',
        required: true
    },

    title: {
        type: String,
        required: true,
        trim: true
    },

    description: {
        type: String,
        default: ''
    },

    status: {
        type: String,
        enum: ['pending', 'completed'],
        default: 'pending'
    },

    createdAt: {
        type: Date,
        default: Date.now
    }
    
});

module.exports = mongoose.model('Task', TaskSchema);