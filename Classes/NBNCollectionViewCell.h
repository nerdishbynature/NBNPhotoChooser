#import <UIKit/UIKit.h>

@interface NBNCollectionViewCell : UICollectionViewCell

+ (void)registerIn:(UICollectionView *)collectionView;

+ (NSString *)reuserIdentifier;

@end
