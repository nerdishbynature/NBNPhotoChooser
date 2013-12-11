#import "NBNPhotoChooserViewController.h"
#import "NBNAssetCell.h"
#import "NBNPhotoMiner.h"
#import "NBNImageCaptureCell.h"

@interface NBNPhotoChooserViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *images;
@property (nonatomic) id<NBNPhotoChooserViewControllerDelegate> delegate;
@property (nonatomic) BOOL inCapturingMode;

@end

@implementation NBNPhotoChooserViewController

- (id)initWithDelegate:(id<NBNPhotoChooserViewControllerDelegate>)delegate {
    self = [super init];

    if (self) {
        _delegate = delegate;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectionView];
    [self registerCellTypes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getImages];
}

- (void)getImages {
    NBNPhotoMiner *photoMiner = [[NBNPhotoMiner alloc] init];
    [photoMiner getAllPicturesCompletion:^(NSArray *images) {
        self.images = images;
        [self.collectionView reloadData];
        [self scrollToBottom:NO];
    }];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                             collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

- (void)registerCellTypes {
    [NBNAssetCell registerIn:self.collectionView];
    [NBNImageCaptureCell registerIn:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc %@", self.class);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row < self.images.count) {
        return [self assetCellForCollectionView:collectionView atIndex:indexPath];
    } else {
        return [self imageCaptureCellForCollectionView:collectionView atIndex:indexPath];
    }
}

- (UICollectionViewCell *)assetCellForCollectionView:(UICollectionView *)collectionView
                                             atIndex:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NBNAssetCell reuserIdentifier];
    NBNAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                   forIndexPath:indexPath];
    UIImage *asset = [self.images objectAtIndex:indexPath.row];
    [cell configureWithAsset:asset];

    return cell;
}

- (UICollectionViewCell *)imageCaptureCellForCollectionView:(UICollectionView *)collectionView
                                                    atIndex:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NBNImageCaptureCell reuserIdentifier];
    NBNImageCaptureCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                        forIndexPath:indexPath];
    cell.imagePickerController.delegate = self;
    [cell isInCapturingMode:self.inCapturingMode frame:self.collectionView.frame];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.inCapturingMode) {
        return self.collectionView.frame.size;
    } else {
        return [NBNAssetCell size];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.images.count) {
        [self didChooseImage:self.images[indexPath.row]];
    } else {
        [self didChooseImagePicker];
    }
}

- (void)didChooseImage:(UIImage *)image {
    if ([self.delegate respondsToSelector:@selector(didChooseImage:)]) {
        [self.delegate didChooseImage:image];
    } else {
         NSAssert(NO, @"Delegate didChooseImage: has to be implemented");
    }
}

#pragma mark - Image Preview choosing

- (void)didChooseImagePicker {
    [self prepareForFullScreen];
    [self toggleCapturingMode];
}

- (void)prepareForFullScreen {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)prepareForImagePreviews {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)toggleCapturingMode {
    self.inCapturingMode = !self.inCapturingMode;
    [self.collectionView reloadData];
    [self scrollToBottom:NO];
    [self.collectionView setScrollEnabled:!self.collectionView.isScrollEnabled];
}

- (void)scrollToBottom:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.images.count inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionBottom
                                        animated:animated];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self didChooseImage:image];
    [self prepareForImagePreviews];
    [self toggleCapturingMode];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self prepareForImagePreviews];
    [self toggleCapturingMode];
}

@end
