#import <UIKit/UIKit.h>

@protocol NBNPhotoChooserViewControllerDelegate;

@interface NBNPhotoChooserViewController : UIViewController

- (instancetype)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate;
- (instancetype)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate
                    maxCellWidth:(CGFloat)maxCellWidth
                     cellSpacing:(CGFloat)cellSpacing;

@property (nonatomic) NSString *navigationBarTitle;
@property (nonatomic) NSString *cancelButtonTitle;
@property (nonatomic) BOOL shouldAnimateImagePickerTransition;
@property (nonatomic) BOOL shouldDismissAfterChoosingImage;

@end

@protocol NBNPhotoChooserViewControllerDelegate <NSObject>

- (void)photoChooserController:(NBNPhotoChooserViewController *)photoChooser didChooseImage:(UIImage *)image;

@optional
- (void)photoChooserDidCancel:(NBNPhotoChooserViewController *)photoChooser;

@end
