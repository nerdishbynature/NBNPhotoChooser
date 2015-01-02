#import "NBNImageCaptureCell.h"

static UIImagePickerController *imagePickerController;

@interface NBNImageCaptureCell ()
@property (nonatomic) UIImageView *maskImageView;
@property (nonatomic) CGSize cellSize;
@end

@implementation NBNImageCaptureCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cellSize = frame.size;
        [self setupMaskImageView];
        [self setupImagePicker];
    }
    return self;
}

- (void)setupImagePicker {
    [self.contentView insertSubview:NBNImageCaptureCell.sharedImagePicker.view
                       belowSubview:self.maskImageView];
}

- (void)setupMaskImageView {
    _maskImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_maskImageView];
}

- (void)configureCell {
    NBNImageCaptureCell.sharedImagePicker.view.frame = CGRectMake(0, 0, self.cellSize.width, self.cellSize.height);
    self.maskImageView.image = [UIImage imageNamed:@"NBNPhotoChooser.bundle/camera_cell"];
    self.maskImageView.frame = CGRectMake(0, 0, self.cellSize.width, self.cellSize.height);
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

+ (UIImagePickerController *)sharedImagePicker {
    if (!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
    }
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.showsCameraControls = NO;
    return imagePickerController;
}

@end
