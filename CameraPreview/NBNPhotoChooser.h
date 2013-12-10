#import <UIKit/UIKit.h>

@protocol NBNPhotoChooserDelegate;

@interface NBNPhotoChooser : UINavigationController

@property (nonatomic) id<NBNPhotoChooserDelegate> photoChooserDelegate;

@end

@protocol NBNPhotoChooserDelegate <NSObject>

@required
- (void)photoChooser:(NBNPhotoChooser *)photoChooser didChooseImage:(UIImage *)image;

@end
