#import "UIImagePickerController+Orientation.h"

@implementation UIImagePickerController (Orientation)

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
