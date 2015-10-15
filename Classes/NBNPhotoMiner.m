#import "NBNPhotoMiner.h"
#include <AssetsLibrary/AssetsLibrary.h>

NS_ENUM(NSInteger, NBNAssetsGroupType) {
    NBNAssetsGroupTypeCameraRoll = 259
};

NSString *const NBNPhotoMinerKeyImage = @"NBNPhotoMinerKeyImage";
NSString *const NBNPhotoMinerKeyFullImageURL = @"NBNPhotoMinerKeyFullImageURL";

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

- (void)getAllPicturesCompletion:(void (^)(NSArray *images))block {
    NSParameterAssert(block);
    ALAssetsLibrary *al = [[ALAssetsLibrary alloc] init];

    [al enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *secondStop) {
            if (result) {
                if ([[result valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {

                    UIImage *image = [UIImage imageWithCGImage:result.thumbnail
                                                         scale:1.0
                                                   orientation:0];
                    NSURL *URL = [result valueForProperty:ALAssetPropertyAssetURL];

                    if (image && URL) {
                        [self.mutableArray addObject:@{NBNPhotoMinerKeyImage: image, NBNPhotoMinerKeyFullImageURL: URL}];
                    }
                }
            }
        }];

        self.imageArray = [NSArray arrayWithArray:self.mutableArray];
        block(self.imageArray);

    } failureBlock:^(NSError *error) {
#ifdef DEBUG
        NSLog(@"%@", error);
#endif
    }];
}

+ (void)imageFromDictionary:(NSDictionary *)dict block:(void (^)(UIImage *fullResolutionImage))block {
    NSParameterAssert(block);
    NSURL *mediaURL = [dict objectForKey:NBNPhotoMinerKeyFullImageURL];

    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset) {
        CGImageRef iref = myasset.defaultRepresentation.fullScreenImage;
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref
                                                      scale:1.0
                                                orientation:0];
            block(largeimage);
        }
    };

    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *error) {
#ifdef DEBUG
        NSLog(@"%@", error);
#endif
    };

    if(mediaURL) {
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:mediaURL
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }
}

+ (void)lastImageWithCompletion:(void (^)(NSDictionary *dict))block {
    NSParameterAssert(block);
    NBNPhotoMiner *photoMiner = [[NBNPhotoMiner alloc] init];
    [photoMiner getAllPicturesCompletion:^(NSArray *images) {
        block([images lastObject]);
    }];
}

@end
