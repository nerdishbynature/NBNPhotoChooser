#import <Foundation/Foundation.h>

@interface NBNPhotoMiner : NSObject

-(void)getAllPicturesCompletion:(void (^)(NSArray *images))block;

@end
