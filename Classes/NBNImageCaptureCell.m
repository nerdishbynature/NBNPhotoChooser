#import "NBNImageCaptureCell.h"
#import <QuartzCore/QuartzCore.h>

static UIImagePickerController *imagePickerController;

@implementation NBNImageCaptureCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImagePicker];
    }
    return self;
}

- (void)setupImagePicker {
    NBNImageCaptureCell.sharedImagePicker.showsCameraControls = NO;
    [self.contentView addSubview:NBNImageCaptureCell.sharedImagePicker.view];
}

- (void)isInCapturingMode:(BOOL)inCapturingMode frame:(CGRect)frame {
    if (inCapturingMode) {
        NBNImageCaptureCell.sharedImagePicker.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        NBNImageCaptureCell.sharedImagePicker.showsCameraControls = YES;
    } else {
        [NBNImageCaptureCell.sharedImagePicker.view setFrame:CGRectMake(0, 0, 95, 95)];
        NBNImageCaptureCell.sharedImagePicker.showsCameraControls = NO;
    }
}

#pragma mark - Getter/Setter

- (UIImagePickerController *)imagePickerController {
    return NBNImageCaptureCell.sharedImagePicker;
}

#pragma mark - Class Methods

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

+ (UIImagePickerController *)sharedImagePicker {
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    return imagePickerController;
}

@end
