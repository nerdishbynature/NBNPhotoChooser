#import "NBNImageCaptureCell.h"

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
    [self.contentView addSubview:NBNImageCaptureCell.sharedImagePicker.view];
}

- (void)configureCell {
    NBNImageCaptureCell.sharedImagePicker.view.frame = CGRectMake(0, 0, 95, 95);
}

- (void)removeSubviews {
    [NBNImageCaptureCell.sharedImagePicker.view removeFromSuperview];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (!NBNImageCaptureCell.sharedImagePicker.view.superview) {
        [self setupImagePicker];
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
    }
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.showsCameraControls = NO;
    return imagePickerController;
}

@end
