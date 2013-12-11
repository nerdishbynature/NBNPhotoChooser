#import "NBNPhotoMiner.h"
#include <AssetsLibrary/AssetsLibrary.h>

NS_ENUM(NSInteger, NBNAssetsGroupType) {
    NBNAssetsGroupTypeCameraRoll = 259
};

@interface NBNPhotoMiner ()

@property (nonatomic) ALAssetsLibrary *library;
@property (nonatomic) NSArray *imageArray;
@property (nonatomic) NSMutableArray *mutableArray;

@end

@implementation NBNPhotoMiner

- (id)init {
    self = [super init];

    if (self) {
        _imageArray = [[NSArray alloc] init];
        _mutableArray = [[NSMutableArray alloc] init];
        _library = [[ALAssetsLibrary alloc] init];
    }

    return self;
}

-(void)getAllPicturesCompletion:(void (^)(NSArray *images))block {
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];

    [al enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsGroupType type = (ALAssetsGroupType)[group valueForProperty:ALAssetsGroupPropertyType];

        if ((int)type == NBNAssetsGroupTypeCameraRoll) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *secondStop) {
                if (result) {
                    if ([[result valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {
                        UIImage *image = [UIImage imageWithCGImage:result.thumbnail
                                                             scale:1.0
                                                       orientation:0];
                        [self.mutableArray addObject:image];
                    }
                }
                if (stop || secondStop) {
                    self.imageArray = [NSArray arrayWithArray:self.mutableArray];
                    block(self.imageArray);
                }
            }];
        }

    } failureBlock:^(NSError *error) {
        NSLog(@"access not permitted");
    }];
}

- (void)dealloc {
    NSLog(@"dealloc %@", self.class);
}

@end
