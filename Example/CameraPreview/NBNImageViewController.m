#import "NBNImageViewController.h"
#import <NBNPhotoChooser/NBNPhotoChooserViewController.h>

@interface NBNImageViewController () <NBNPhotoChooserViewControllerDelegate>

@property (nonatomic) UIImageView *imageView;

@end

@implementation NBNImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];

	UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.frame = CGRectMake(self.view.frame.size.width / 2 - 100, self.view.frame.size.height - 200, 200, 100);
    [button addTarget:self action:@selector(showImageChooser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showImageChooser {
    NBNPhotoChooserViewController *photoChooser = [[NBNPhotoChooserViewController alloc] initWithDelegate:self];
    photoChooser.navigationBarTitle = @"Choose image";
    photoChooser.cancelButtonTitle = @"Cancel";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoChooser];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)photoChooserController:(NBNPhotoChooserViewController *)photoChooser didChooseImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)photoChooserDidCancel:(NBNPhotoChooserViewController *)photoChooser {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
