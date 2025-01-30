# Weather Dashboard System

A modern, retro-styled weather monitoring system built with Ruby on Rails 8. This application provides real-time weather tracking with a unique CRT-style interface inspired by classic monitoring systems.

![image](https://github.com/user-attachments/assets/5c3f8fa9-5622-49bc-b782-b6a8a5a7aa37)
![image](https://github.com/user-attachments/assets/c26145ba-0174-413e-92ed-ad98522ff111)
![image](https://github.com/user-attachments/assets/4956cfd4-ae50-44c8-8eaa-a9de3605a878)
![image](https://github.com/user-attachments/assets/fc3175b1-8bda-4405-99ee-50dbf524bfb3)


## Features

- 🌍 Real-time weather monitoring
- 🔍 Location-based weather searching
- 📊 Historical weather data tracking
- 🗺️ Geocoding integration
- 💾 Weather data caching system
- 🖥️ Retro CRT-style interface
- 🌐 OpenWeatherMap API integration

## Tech Stack

- **Backend:** Ruby on Rails 8
- **Database:** PostgreSQL
- **Frontend:** 
  - Tailwind CSS
  - Hotwire/Turbo
  - Stimulus.js
- **APIs:**
  - OpenWeatherMap API
  - Geocoding services
- **Caching:** Rails cache with rate limiting
- **Deployment:** Docker & Kamal

## Prerequisites
- Ruby 3.x
- PostgreSQL
- Node.js & Yarn
- Docker (for deployment)

## Installation

1. Clone the repository:

```bash
git clone https://github.com/PL3SH/weather_dashboard.git
```

2. Install dependencies:

```bash
bundle install
yarn install
```
3. Setup database:

```bash
rails db:create db:migrate
```

4. Set up environment variables:

```bash
cp .env.example .env
```
Add your OpenWeatherMap API key to .env file
get you api key in https://openweathermap.org/api

```bash
rails credentials:edit
```
    Inside the credentials file, add your API key under a namespace. For example:

```yaml
api_keys:
  my_service: "your-secret-api-key"
```

    Never commit master.key to Git!. It should be in .gitignore by default.

5. Start the server:
```bash
bin/dev
```

## Environment Variables

The following environment variables are required:

- `OPENWEATHER_API_KEY`: Your OpenWeatherMap API key
- `PGPASSWORD`: PostgreSQL database password
- `RAILS_MASTER_KEY`: Rails master key for credentials

### Core Features

#### Weather Data Retrieval
- Real-time weather data fetching from OpenWeatherMap API
- Rate limiting protection (60 requests per minute)
- Automatic caching of recent weather records
- Temperature, humidity, and detailed weather descriptions
- Raw weather data storage for analysis

#### Location Management
- Location search with city and country code
- Automatic geocoding of locations
- Location search history tracking
- Most searched locations ranking
- Detailed location weather history

#### Smart Caching
- Recent weather records caching
- Efficient API usage with rate limiting
- Automatic weather data updates
- Search count tracking for locations

#### API Integration
- HTTParty for API requests
- Geocoder integration for coordinates
- IP-based geolocation support
- Robust error handling
- Secure API key management

### Location Tracking
- Search and save locations
- Track search history
- View detailed weather information

### Weather Monitoring
- Current temperature and conditions
- Humidity and pressure data
- Historical weather records
- Weather status visualization

### User Interface
- Retro-inspired CRT display
- Dynamic weather icons
- Real-time updates
- Responsive design for all devices

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- OpenWeatherMap API for weather data
- Rails community for the amazing framework
- Contributors and maintainers

## Contact

Your Name - [@yourtwitter](https://twitter.com/yourtwitter)
Project Link: [https://github.com/yourusername/weather-dashboard](https://github.com/yourusername/weather-dashboard)

