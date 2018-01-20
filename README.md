# Paul McGrath Etsy Coding Challenge
Etsy coding challenge solution by Paul McGrath

This is my solution to the coding challenge posed by Etsy. The goal was to write an app in Objective C that allowed the user to perform a search via the Etsy API and display the results of the search in an infinite-scrolling list.

## Features
I decided to implement the list as a UITableView rather than a UICollectionView since this would make the infiite scrolling functionality easier to implement. I adopted the repository design pattern in my architecture for retrieving the results from the API. This allows us to maintain a layer of abstraction between the View Controller and the data layer. This way the View Controller doesn't need to concern itself with the metadata of the search (such as the search offset, search limit and max items) but merely present the data that is made available to it. It allows a degree of openness in our design so that we can implement different data sources in the future if required (such as retrieving listings stored with Core Data for example).

The HTTPRequestController class handles the communication with the API, including constructing the URL and decoding the resultant JSON data into a dictionary. The EtsyListingRepository manages the listings themselves, which are encapsulated in the EtsyListing objects. The EtsyListingRepository handles making the calls to the HTTPRequestController, handling the pagination of the searches and determining if we need to perform a new search or append onto the previous one. It also constructs the EtsyListing objects from the dictionary it receives from the HTTPRequestController.

The technical aspects of the infinite scrolling proved tricky, especially when it came to displaying images. The way that UITableView recycles cells caused an issue whereby the wrong images were displaying for the wrong items. However I managed to streamline the asynchronous image download process and introduced a placeholder image and that seemed to alleviate the issue.

This is a universal iOS app. I have tested it on my iPhone 6 and iPad Air in both portrait and landscape modes. The autolayout constraints are relatively simple and did not require the use of any extra size class adjustments.

## Limitations
There are a number of limitations to my solution that I feel I could have resolved given enough time
1. The UI design isn't going to win any awards. I'm primarily a developer, design was never my strong suit :)
1. Some of the titles returned by the API had HTML-encoded characters in them, i.e. &quot. I couldn't find a neat solution to replace these.
1. I set up my own Etsy developer account and generated a new API key, since the key provided didn't seem to work. This means there is a limitation to the number of API requests that can be made per second but that doesn't seem to be an issue with a demo of this kind
1. There's no localization in the app. I only speak English (and enough Irish to sound exotic when I'm abroad)
1. Although I'm a fan of TDD and automated tests in general, I decided to forego them for this demo

