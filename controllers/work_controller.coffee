express = require('express')
router = express.Router();
resin = require('resin-sdk')
fs = require('fs')
config = require('../config')
multer = require('multer')

Device = require('../models/device');
Workload = require('../models/workload')
dispatcher = require '../models/dispatcher'
Image = require('../models/image')

router.use(multer({ dest: './uploads/'}))

router.all '/work', (req, res, next) ->

	image = new Image({personName: null, target: true })

	image.attach 'image', req.files.image, (err) ->
		if(err)
			return next(err)

		image.save (err) ->
			if(err)
				return next(err)

			dispatcher.start image, {
				totalSize: 13000,
				numAssigned: 0,
				assigned: []
			}
			res.send('OK')
	


module.exports = router