# Currency Converter
This app converts the currency of 156 countries.

## About 
This app uses an API from CurrencyConverterApi.com, which converts the currency of 156 countries. The user selects the country's currency, that they would like to convert from & to, enter an amount, which will automatically get converted. 

## Development. 
Developing the I app, I used Xcode's storyboard for lay out of the design. I used MVVM design pattern, wrote a Rest API call function, used Codable to parse the retrieved JSON, and wrote unit tests. 

## MVVM
I decided to use MVVM design pattern, because I like how it separates the logic away from the view. Plus, I intended to add some additional features soon to the app. I feel that it would be easy to add extra classes and code, using this design pattern. 

## Unit Testing 
I have written Unit Tests for this app. I wrote a mock of the api request function, I done this to test 3 functions that parsed data, that is retrieved from the api request.

## Rest API Request
The App makes 2 rest API requests. The first request retrieves data about each country, such as the country’s identification, the currency, currency name and symbol. The second request retrieves converted currency. 

Rather than making serval functions, that make API request separately, I create one function, that has an enum parameter. When calling the function an enum case is selected, depending on which API url that is needed. 


```Swift
struct Endpoint {
    let path: Path
    let queryItems: [URLQueryItem]
}

enum Path: String {
    case convert = "/api/v6/convert"
    case country = "/api/v6/countries"
    case currencies = "/api/v6/currencies"
}

extension Endpoint {
    static func convert(currencies query: String) -> Endpoint {
        return Endpoint(
            path: .convert,
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "compact", value: "ultra"),
                URLQueryItem(name: "apiKey", value: "*******************"),
                
                ]
            )
    }
}

extension Endpoint {
    static func country() -> Endpoint {
        return Endpoint(
            path: .country,
            queryItems: [
                URLQueryItem(name: "apiKey", value: "*******************"),
            ]
        )
    }
}

extension Endpoint {
    static func currencies() -> Endpoint {
        return Endpoint(
            path: .currencies,
            queryItems: [
                URLQueryItem(name: "apiKey", value: "*******************"),
                ]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "free.currencyconverterapi.com"
        components.path = path.rawValue
        components.queryItems = queryItems
        return components.url
    }
}
```

