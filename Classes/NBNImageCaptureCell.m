#import "NBNImageCaptureCell.h"
#import <AVFoundation/AVFoundation.h>

@interface NBNImageCaptureCell ()

@property (nonatomic) UIImageView *maskImageView;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewCaptureLayer;

@end

@implementation NBNImageCaptureCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupImagePicker];
        [self setupMaskImageView];
        
        self.clipsToBounds = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeDeviceOrientation:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
}

#pragma mark - Setup SubViews

- (void)setupImagePicker {
    if (!self.previewCaptureLayer) {
        AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        [captureSession addInput:input];
        
        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.contentView.layer addSublayer:captureVideoPreviewLayer];
        self.previewCaptureLayer = captureVideoPreviewLayer;
        
        [self adjustCameraOrientation];
        [self startCapture];
    }
}

- (void)setupMaskImageView {
    _maskImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.maskImageView.image = [UIImage imageNamed:@"NBNPhotoChooser.bundle/camera_cell"];
    [self.contentView addSubview:_maskImageView];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.previewCaptureLayer.frame = self.bounds;
    self.maskImageView.frame = self.bounds;
}

- (void)adjustCameraOrientation {
    AVCaptureConnection *captureConnection = self.previewCaptureLayer.connection;
    if ([captureConnection isVideoOrientationSupported]) {
        AVCaptureVideoOrientation orientation = AVCaptureVideoOrientationPortrait;
        if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
            orientation = AVCaptureVideoOrientationPortraitUpsideDown;
        } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
            orientation = AVCaptureVideoOrientationLandscapeRight;
        } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
            orientation = AVCaptureVideoOrientationLandscapeLeft;
        }
        [captureConnection setVideoOrientation:orientation];
    }
}

#pragma mark - Notifications

- (void)didChangeDeviceOrientation:(NSNotification *)notification {
    [self adjustCameraOrientation];
}

#pragma mark - Control Capture

- (void)startCapture {
    if (!self.previewCaptureLayer.session.running) {
        [self.previewCaptureLayer.session startRunning];
    }
}

- (void)stopCapture {
    [self.previewCaptureLayer.session stopRunning];
}

@end