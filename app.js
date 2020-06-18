const request = require("request");
const chalk = require("chalk");
const yargs = require("yargs");

const getWeatherInformation = (location = yargs.argv.location) => {

  if (!location) {
    throw Error(chalk.white.bgRed("A location must be provided"));
  }

  const mapbox_url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${location}.json?access_token=pk.eyJ1IjoiYWZhdGh5IiwiYSI6ImNrYmY1dGxjaTA4eXcycmtjejJuZXIyMzAifQ.loj4GzrMf-O55iWpJTLQog`

  request({ url: mapbox_url, json: true }, (error, response) => {
    if (response) {
      if (response.message) {
        console.log(chalk.red("Not Authorized - Invalid Tokenss"));
      } else if (response.body.features && response.body.features.length === 0) {
        console.log(chalk.red("Seems you are not putting a correct location!"));
      } else {
        const coordinates = response.body.features[0].center;
        const lat = coordinates[0];
        const long = coordinates[1];
        const weather_url = `http://api.weatherstack.com/current?access_key=3962b3a9814486822870d171ea6d5f13&query=${lat},${long}`;

        request({ url: weather_url, json: true }, (error, response) => {
          if (error) {
            console.log(chalk.red(`There is an error: ${error}`))
          } else {
            const weatherInfo = response.body;
            const location = weatherInfo.location;
            const current = weatherInfo.current;

            let information =
              `Weather data for ${chalk.green(location.name)} - ${chalk.green(location.country)}\n` +
              `Timezone: ${location.timezone_id}\n` +
              `Current Time: ${location.localtime}\n` +
              `Temperature: ${current.temperature} and weather is ${current.weather_descriptions[0]}`;

            console.log(information);
          }

        });
      }
    }
  });
}

getWeatherInformation();
yargs.parse();
