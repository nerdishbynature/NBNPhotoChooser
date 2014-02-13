#import <UIKit/UIKit.h>

@protocol NBNPhotoChooserViewControllerDelegate;

@interface NBNPhotoChooserViewController : UIViewController

- (id)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate;

@end

@protocol NBNPhotoChooserViewControllerDelegate <NSObject>

- (void)didChooseImage:(UIImage *)image;
- (void)photoChooserDidCancel:(NBNPhotoChooserViewController *)photoChooser;

@end
