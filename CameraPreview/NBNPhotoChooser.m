#import "NBNPhotoChooser.h"
#import "NBNPhotoChooserViewController.h"

@interface NBNPhotoChooser ()

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
    NBNPhotoChooserViewController *vc = [[NBNPhotoChooserViewController alloc] init];
    self.viewControllers = @[vc];
}

@end
