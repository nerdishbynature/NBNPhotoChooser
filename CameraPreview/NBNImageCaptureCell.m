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

    [self.contentView addSubview:_imagePickerController.view];
}

- (void)isInCapturingMode:(BOOL)inCapturingMode frame:(CGRect)frame {
    if (inCapturingMode) {
        [_imagePickerController.view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _imagePickerController.showsCameraControls = YES;
    } else {
        [_imagePickerController.view setFrame:CGRectMake(0, 0, 95, 95)];
        _imagePickerController.showsCameraControls = NO;
    }
}

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

- (void)dealloc {
    NSLog(@"dealloc %@", self.class);
}

@end
