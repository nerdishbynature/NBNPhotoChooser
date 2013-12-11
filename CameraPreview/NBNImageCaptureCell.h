#import "NBNCollectionViewCell.h"

@interface NBNImageCaptureCell : NBNCollectionViewCell

@property (nonatomic, readonly) UIImagePickerController *imagePickerController;

- (void)isInCapturingMode:(BOOL)inCapturingMode frame:(CGRect)frame;

+ (CGSize)size;

@end
