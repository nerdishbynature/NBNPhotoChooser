# NBNPhotoChooser

[![Cocoapods Version](http://img.shields.io/cocoapods/v/NBNPhotoChooser.svg?style=flat)](https://github.com/nerdishbynature/NBNPhotoChooser/blob/master/NBNPhotoChooser.podspec)
[![](http://img.shields.io/cocoapods/l/NBNPhotoChooser.svg?style=flat)](https://github.com/xing/NBNPhotoChooser/blob/master/LICENSE)
[![CocoaPods Platform](http://img.shields.io/cocoapods/p/NBNPhotoChooser.svg?style=flat)]()

An example implementation of the Tumblr Photo Chooser.

### Install using CocoaPods

```ruby
# Podfile
pod 'NBNPhotoChooser'
```

### Usage

Example Usage:

```objc
#import <NBNPhotoChooser/NBNPhotoChooserViewController.h>

- (void)choosePhoto:(id)sender {
    NBNPhotoChooserViewController *photoChooserViewController = [[NBNPhotoChooserViewController alloc] initWithDelegate:self];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoChooserViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - NBNPhotoChooserViewControllerDelegate

- (void)didChooseImage:(UIImage *)image {
    self.commentToolbar.chosenImage = image;
}
```

### Contributing

Contributions are highly appreciated, just open up an issue or a pull request.
