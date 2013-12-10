#import "NBNImageCaptureCell.h"
#import <QuartzCore/QuartzCore.h>

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
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.showsCameraControls = NO;
    [_imagePickerController.view setFrame:CGRectMake(0, 0, 95, 95)];
    [self.contentView addSubview:_imagePickerController.view];
}

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

@end
