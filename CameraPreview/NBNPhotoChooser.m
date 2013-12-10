#import "NBNPhotoChooser.h"
#import "NBNPhotoChooserViewController.h"

@interface NBNPhotoChooser () <NBNPhotoChooserViewControllerDelegate>

@end

@implementation NBNPhotoChooser

- (id)init {
    self = [super init];

    if (self) {
        [self setupPhotoChooserViewController];
    }

    return self;
}

- (void)setupPhotoChooserViewController {
    NBNPhotoChooserViewController *vc = [[NBNPhotoChooserViewController alloc] initWithDelegate:self];
    self.viewControllers = @[vc];
}

- (void)didChooseImage:(UIImage *)image {
    if ([self.photoChooserDelegate respondsToSelector:@selector(photoChooser:didChooseImage:)]) {
        [self.photoChooserDelegate photoChooser:self didChooseImage:image];
    } else {
        NSAssert(NO, @"Delegate photoChooser:didChooseImage: has to be implemented");
    }
}

@end
