const cors = require('cors');
const colors = require('colors');
const dotenv = require('dotenv');
const morgan = require('morgan');
const express = require('express');

// Load environment variables
dotenv.config({ path: './.env' });

// Instantiate app
const app = express();

// Body Parser
app.use(express.json());

//Dev loggin middleware
if (process.env.NODE_ENV == 'development') {
  app.use(morgan('dev'));
}

// To allow third party usage in production
app.use(cors());

// Get port number and mode from .env
const PORT = process.env.PORT || 5000;
const MODE = process.env.NODE_ENV || 'production';

// Start server
const server = app.listen(PORT, () => {
  console.log(
    `Server running on port ${PORT} in ${MODE} mode.`.bgBlue.bold.inverse
  );
});

// Handle unhandled promise rejections
process.on('unhandledRejection', err => {
  console.log(colors.red.underline(`Error: ${err.message}`));
  //Close server and exit process
  server.close(() => process.exit(1));
});
