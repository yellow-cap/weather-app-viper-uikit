# weather-app-viper-uikit
##### App structure
1. Api layer
  * Generic fetcher
  * OpenWeather fetcher (uses Generic fetcher)
2. Service layer
  * Location service (internal application service, based on Location, MapKit)
  * Weather service (uses OpenWeather fetcher. Interaction with OpenWeather API)
3. Modules (separate parts of the application)
  * Weather
    * WeatherModule (setup of the module, entry point of the application)
    * WeatherView (view controller with only view logic)
    * WeatherInteraction (communication between service layer and presenter)
    * WeatherPresenter (takes data from interraction and prepare it for the view)
4. Utils
  * Viper (viper interface)
  * Extensions (basic extensions, mostly for the presentation layer)
5. AppResources (application string resources)
6. Tests
  * WeatherModule_Tests (unit tests example)
  * WeatherPage_Test (ui test example)


##### Usage

If application runs on Simulator be sure, that it has chosen location (Features -> Location) diffrent from 'None', otherwise error will be shown.
