#import "NBNCollectionViewCell.h"

@interface NBNImageCaptureCell : NBNCollectionViewCell

@property (nonatomic, readonly) UIImagePickerController *imagePickerController;

- (void)startCapture;
- (void)stopCapture;

@end
