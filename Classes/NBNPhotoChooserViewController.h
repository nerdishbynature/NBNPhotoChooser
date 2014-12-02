#import <UIKit/UIKit.h>

@protocol NBNPhotoChooserViewControllerDelegate;

@interface NBNPhotoChooserViewController : UIViewController

- (id)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate;

@property (nonatomic) NSString *navigationBarTitle;
@property (nonatomic) NSString *cancelButtonTitle;

@end

@protocol NBNPhotoChooserViewControllerDelegate <NSObject>

- (void)photoChooserController:(NBNPhotoChooserViewController *)photoChooser didChooseImage:(UIImage *)image;
- (void)photoChooserDidCancel:(NBNPhotoChooserViewController *)photoChooser;

@end
