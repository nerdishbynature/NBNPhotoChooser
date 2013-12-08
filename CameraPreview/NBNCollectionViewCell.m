#import "NBNCollectionViewCell.h"

@implementation NBNCollectionViewCell

+ (void)registerIn:(UICollectionView *)collectionView {
    [collectionView registerClass:self.class
       forCellWithReuseIdentifier:NSStringFromClass(self.class)];
}

+ (NSString *)reuserIdentifier {
    return NSStringFromClass(self.class);
}

@end
