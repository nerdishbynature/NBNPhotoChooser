#import "NBNImageCaptureManager.h"

@implementation NBNImageCaptureManager

- (id)init {
    self = [super init];
	if (self) {
        _captureSession = [[AVCaptureSession alloc] init];
	}
	return self;
}

- (void)addVideoPreviewLayer {
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
}

- (void)addVideoInput {
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([self.captureSession canAddInput:videoIn]) {
				[self.captureSession addInput:videoIn];
            } else {
				NSLog(@"Couldn't add video input");
            }
		} else {
			NSLog(@"Couldn't create video input");
        }
	} else {
		NSLog(@"Couldn't create video capture device");
    }
}

- (void)dealloc {
	[self.captureSession stopRunning];
}

@end
