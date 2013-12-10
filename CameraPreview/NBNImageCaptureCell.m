#import "NBNImageCaptureCell.h"
#import <QuartzCore/QuartzCore.h>

@interface NBNImageCaptureCell ()

@property (nonatomic) UIImagePickerController *imagePickerController;

@end

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
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.showsCameraControls = NO;
    [self.imagePickerController.view setFrame:CGRectMake(0, 0, 95, 95)];
    [self.contentView addSubview:self.imagePickerController.view];

}

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

@end
