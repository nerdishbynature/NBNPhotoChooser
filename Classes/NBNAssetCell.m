#import "NBNAssetCell.h"

@interface NBNAssetCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation NBNAssetCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageView];
    }

    return self;
}

- (void)configureWithAsset:(UIImage *)image {
    self.imageView.image = image;
}

@end
