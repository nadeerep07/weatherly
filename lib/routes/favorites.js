const express = require('express');
const router = express.Router();
const Favorite = require('../models/Favorite');

// GET all favorites
router.get('/', async (req, res) => {
  try {
    const favorites = await Favorite.find().sort({ createdAt: -1 });
    res.json(favorites);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// POST a new favorite
router.post('/', async (req, res) => {
  const favorite = new Favorite({
    cityName: req.body.cityName,
    temperature: req.body.temperature,
    weatherIcon: req.body.weatherIcon,
    createdAt: req.body.createdAt || new Date()
  });

  try {
    const newFavorite = await favorite.save();
    res.status(201).json(newFavorite);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// DELETE a favorite
router.delete('/:id', async (req, res) => {
  try {
    const favorite = await Favorite.findById(req.params.id);
    if (!favorite) {
      return res.status(404).json({ message: 'Favorite not found' });
    }
    
    await Favorite.findByIdAndDelete(req.params.id);
    res.json({ message: 'Favorite deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;