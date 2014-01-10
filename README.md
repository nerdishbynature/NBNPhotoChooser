NBNPhotoChooser
===============

An example implementation of the Tumblr Photo Chooser. 

### Installation using CocoaPods

`pod 'NBNPhotoChooser', '~> 0.0.3'`

### Usage

1. Allocate the NBNPhotoChooserViewController using `- (id)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate` 
1. Allocate a UINavigationController
2. Present it modally
3. Implement the delegate `- (void)didChooseImage:(UIImage *)image` 
4. Have fun!

Example Usage:


	#import <NBNPhotoChooser/NBNPhotoChooserViewController.h>
		
	- (void) choosePhoto:(id)sender {
	    NBNPhotoChooserViewController *photoChooserViewController = [[NBNPhotoChooserViewController alloc] initWithDelegate:self];
	    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoChooserViewController];
	    [self presentViewController:navController animated:YES completion:nil];
	}
		
	#pragma mark - NBNPhotoChooserViewControllerDelegate
		
	- (void)didChooseImage:(UIImage *)image {
	    self.commentToolbar.chosenImage = image;
	}
    
### Contributing

Contributions are highly appreciated, just open up an issue or a pull request.

### Known Issues

* No iOS 6 support
* Lack of landscape support
