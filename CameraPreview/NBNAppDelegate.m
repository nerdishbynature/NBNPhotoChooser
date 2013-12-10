#import "NBNAppDelegate.h"
#import "NBNPhotoChooser.h"

@interface NBNAppDelegate () <NBNPhotoChooserDelegate>

@end

@implementation NBNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.photoChooser = [[NBNPhotoChooser alloc] init];
    self.photoChooser.photoChooserDelegate = self;
    self.window.rootViewController = self.photoChooser;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - NBNPhotoChooserDelegate

- (void)photoChooser:(NBNPhotoChooser *)photoChooser didChooseImage:(UIImage *)image {
    NSLog(@"%@", image);
}

@end
