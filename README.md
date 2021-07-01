# Imagenie

## Table of Contents  
[Introduction](#introduction)

[The Goal](#the-goal) 

[Demo](#demo)

[Architecture](#architecture)

[User Features](#user-features)

[Technical Features](#technical-features)

[Libraries Used](#libraries-used)

[Requirements](#requirements)

[Special Thanks](#special-thanks)




## Introduction <a name="introduction"></a>
Imagenie (Image Genie) is an app that let's you browse photos of different categories, You can also search for photos.

## The Goal <a name="the-goal"></a>
The ultimate goal of Imagenie is to show you relevant photos based on you previous interactions with the app. 

## Demo <a name="demo"></a>
![ezgif com-gif-maker (2)](https://user-images.githubusercontent.com/34739938/124156332-f2f25880-dab0-11eb-9bef-328376127644.gif)
![ezgif com-gif-maker (3)](https://user-images.githubusercontent.com/34739938/124156337-f4bc1c00-dab0-11eb-872a-beb0d10b15f8.gif)
![ezgif com-gif-maker (4)](https://user-images.githubusercontent.com/34739938/124156342-f685df80-dab0-11eb-87bd-c9443e06f73d.gif)

## Architecture <a name="architecture"></a>
I'm using [Clean Swift](https://clean-swift.com/) design pattern. Also known as VIP. It is based on Uncle's Bob clean architecture.
Keeping scalability in mind I went with the clean swift. Classes have clearly defined roles and responsibilities. App structure revolves around scenes and each scene follows the VIP cycle. It has a unidirectional flow of data.

Another reason to go with clean swift architecture is Unit testing. As mentioned earlier due to clear defination of roles and responsibilities, the business logic will be separate from view and will be much more testable compared to tightly coupled code.
 


## User Features <a name="user-features"></a>
| Feature  | Status |
| ------------- | ------------- |
| Categorise Photos  | ✅ |
| Search Photos  | ✅ |
| Photo Gallery  | ✅ |
| Editor's Choice  | ✅ |
| Favorite Photos  | ⌛️ |
| Download Photos  | ⌛️ |
| Like Photos  | ⌛️ |
| Comment on Photos  | ⌛️ |
| Upload Photos  | ⌛️ |
| Create an Account  | ⌛️ |
| Photo of the Day  | ⌛️ |

## Technical Features <a name="technical-features"></a>
| Feature  | Status |
| ------------- | ------------- |
| Architecture   | ✅ |
| Network Layer  | ✅ |
| Image Caching  | ✅ |
| Local Data Storage  | ⌛️ |
| Concurrent Downloading/Uploading  | ⌛️ |

## Libraries Used <a name="libraries-used"></a>
[Kingfisher](https://github.com/onevcat/Kingfisher)

[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)


## Requirements <a name="requirements"></a>
You need to install pods by running the following command 
```ruby
pod install
```

## Special Thanks <a name="special-thanks"></a>
[Pixabay](https://pixabay.com/) for providing the API.


