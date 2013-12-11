#import "NBNAssetCell.h"

@interface NBNAssetCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation NBNAssetCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, NBNAssetCell.size.width, NBNAssetCell.size.height);
}

- (void)configureWithAsset:(UIImage *)image {
    self.imageView.image = image;
}

+ (CGSize)size {
    return CGSizeMake(95, 95);
}

- (void)dealloc {
    NSLog(@"dealloc %@", self.class);
}

@end
