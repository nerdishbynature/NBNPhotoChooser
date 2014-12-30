#import "NBNCollectionViewCell.h"

@interface NBNImageCaptureCell : NBNCollectionViewCell

@property (nonatomic, readonly) UIImagePickerController *imagePickerController;

- (void)configureCell;
- (void)removeSubviews;

@end
