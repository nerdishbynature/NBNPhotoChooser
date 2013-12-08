#import "NBNImageCaptureCell.h"
#import "NBNImageCaptureManager.h"
#import <QuartzCore/QuartzCore.h>

@interface NBNImageCaptureCell ()

@property (nonatomic, strong) NBNImageCaptureManager *captureManager;
@property (nonatomic, strong) NSOperationQueue *startEndQueue;

@end

@implementation NBNImageCaptureCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCaptureManager];
        [self setupQueue];
    }
    return self;
}

- (void)startCapturing {
    if (![self.captureManager.captureSession isRunning]) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"starting");
            [self.captureManager.captureSession startRunning];
        }];
        [self.startEndQueue addOperation:op];
    }
}

- (void)endCapturing {
    if ([self.captureManager.captureSession isRunning]) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"ending");
             [self.captureManager.captureSession stopRunning];
        }];
        [self.startEndQueue addOperation:op];
    }
}

- (void)setupCaptureManager {
    if (!self.captureManager) {
        self.captureManager = [[NBNImageCaptureManager alloc] init];

        [[self captureManager] addVideoInput];

        [[self captureManager] addVideoPreviewLayer];
        CGRect layerRect = self.contentView.layer.bounds;
        [self.captureManager.previewLayer setBounds:layerRect];
        [self.captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];

        if (!self.captureManager.previewLayer.superlayer) {
        	[self.contentView.layer addSublayer:self.captureManager.previewLayer];
        }
    }
}

- (void)setupQueue {
    _startEndQueue = [[NSOperationQueue alloc] init];
    _startEndQueue.name = @"startEndQueue";
    _startEndQueue.maxConcurrentOperationCount = 2;
}

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

@end
