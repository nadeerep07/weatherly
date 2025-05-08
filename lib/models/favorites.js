const mongoose = require('mongoose');

const favoriteSchema = new mongoose.Schema({
  cityName: {
    type: String,
    required: true,
    trim: true
  },
  temperature: {
    type: Number,
    required: true
  },
  weatherIcon: {
    type: String,
    default: '01d'
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('Favorite', favoriteSchema);