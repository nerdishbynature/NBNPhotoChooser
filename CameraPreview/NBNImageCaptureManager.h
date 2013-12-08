#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@interface NBNImageCaptureManager : NSObject

@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic) AVCaptureSession *captureSession;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;

@end
