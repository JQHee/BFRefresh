# BFRefresh
[![Version](https://img.shields.io/cocoapods/v/BFRefresh.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)
[![License](https://img.shields.io/cocoapods/l/BFRefresh.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)
[![Platform](https://img.shields.io/cocoapods/p/BFRefresh.svg?style=flat)](http://cocoapods.org/pods/JQProgressHUD)

## Screenshots

![result.gif](https://github.com/JQHee/BFRefresh/blob/master/result.gif)

## Requirements

`BFRefresh ` works on ` "Xcode 9.3.1 , Swift 4 and ios 8+ to build. `
You will need the latest developer tools in order to build `BFRefresh `. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## CocoaPods

CocoaPods is the recommended way to add BFRefresh to your project.

Add a pod entry for BFRefresh to your Podfile.
 
```
pod 'BFRefresh'
```
Second, install BFRefresh into your project:
 
```
pod install
```


## Manually

1. Download the latest code version .
2. Open your project in Xcode,drag the `JQProgressHUD ` folder into your project.  Make sure to select Copy items when asked if you extracted the code archive outside of your project.


## Usage

```
tableView.set(loadType: .normal)

tableView.refreshBlock = { [weak self] in
    print(self ?? "")
}
```


For more examples, including how to use BFRefresh , take a look at the bundled demo project. API documentation is provided in the header file (UIScrollView-BFRefresh.swift).

## License	

BFRefresh is released under the [MIT](LICENSE). See LICENSE for details.
