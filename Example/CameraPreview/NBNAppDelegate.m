#import "NBNAppDelegate.h"
#import "NBNImageViewController.h"

@implementation NBNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    NBNImageViewController *imageViewController = [[NBNImageViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:imageViewController];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
