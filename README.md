![alt text](https://www.evernote.com/shard/s689/sh/159e6315-3d65-4374-a309-bebe7787f0d2/ae66a31a436f945e/res/96657d6a-7b87-4ad0-bf2a-c863e85d35ed/skitch.png?resizeSmall&width=832)

[![Build Status: Linux](https://travis-ci.org/showdownjs/showdown.svg?branch=master)](https://travis-ci.org/showdownjs/showdown)
[![Build Status: Windows](https://ci.appveyor.com/api/projects/status/github/showdownjs/showdown?branch=master&svg=true)](https://ci.appveyor.com/project/tivie/showdown/branch/master)
[![Agora](https://badge.fury.io/js/showdown.svg)](http://badge.fury.io/js/showdown)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/tiviesantos)

------

This is Physical Therapy App I built at a hackathon.  Basic tutorial included but happy to add more if there are enough requested!

## Live DEMO

![alt text](https://media.giphy.com/media/xULW8JAhnstlDue5Uc/giphy.gif)


## These are the SDK's in the project.

 - [Agora](https://github.com/agoraIO)
 - [AppsFlyer](https://github.com/AppsFlyerSDK/)
 - [Urban Airship](https://github.com/urbanairship)

## Donate [![Click here to lend your support to: ShowdownJS website and testing platform and make a donation at pledgie.com](https://pledgie.com/campaigns/35166.png?skin_name=chrome)](https://pledgie.com/campaigns/35166)

As you know, ShowdownJS is a free library and it will remain free forever. However, maintaining and improving the library costs time and money.

If you like our work and find our library useful, please donate [through Pledgie](https://pledgie.com/campaigns/35166) or directly [through paypal](https://www.paypal.me/tiviesantos)!! Your contribution will be greatly appreciated and help us continue to develop this awesome library.

## Installation

### Install the SDK's by opening terminal to root directory of your project.

    pod install

### Open the Xcode Workspace (not the project)

    Recovery.xcworkspace



## Treatment Table View

![alt text](https://www.evernote.com/shard/s689/sh/9ab12a82-2210-4c7a-992f-4f71499a0596/644a60765f62f2e9/res/779b2d62-74e7-4f31-9aa3-d10c51290e01/skitch.png?resizeSmall&width=832)

### Swift

```swift
   func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return self.contentArray.count
    }
```
This function sets the number of cells in the Table View.   It is typically set to the ```.count``` of the number of items in the array that holds the data for each cell.


```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    { return cell
    }
    
```
This function displays the data in each cell.  You must have a separate class to contain the cell data, which in this project is ```TableViewCell.swift```.

Lastly, we have the function that plays the video:

```swift
 private  func playVideo(video: String) {
        guard let path = Bundle.main.path(forResource: video, ofType:"m4v") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
```
The videos in the array are then called with this function: ```playVideo(video: movArray[indexPath.row])```, where movArray is the array holding all of the videos.  Typically, you would get all of the video data from the server but this is simply an example app.

This is has been a brief tutorial on how to setup a table View in iOS Swift.  Please feel free to ask questions on how the app is build and I will add tutorial points later if needed.


