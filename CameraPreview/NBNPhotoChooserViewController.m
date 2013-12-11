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
    [self setupNavigationBar];
    [self registerCellTypes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadDataSource];
}

- (void)reloadDataSource {
    NBNPhotoMiner *photoMiner = [[NBNPhotoMiner alloc] init];
    [photoMiner getAllPicturesCompletion:^(NSArray *images) {
        self.images = [[NSArray alloc] initWithArray:images];
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

- (void)setupNavigationBar {
    self.title = @"Choose an Image";
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelBarButton;
}

- (void)registerCellTypes {
    [NBNAssetCell registerIn:self.collectionView];
    [NBNImageCaptureCell registerIn:self.collectionView];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)isCaptureCellInIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.images.count) {
        return YES;
    }

    return NO;
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

    if ([self isCaptureCellInIndexPath:indexPath]) {
        return [self imageCaptureCellForCollectionView:collectionView atIndex:indexPath];
    } else {
        return [self assetCellForCollectionView:collectionView atIndex:indexPath];
    }
}

- (UICollectionViewCell *)assetCellForCollectionView:(UICollectionView *)collectionView
                                             atIndex:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NBNAssetCell reuserIdentifier];
    NBNAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                   forIndexPath:indexPath];
    NSDictionary *dict = [self.images objectAtIndex:indexPath.row];
    UIImage *asset = dict[NBNPhotoMinerKeyImage];
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
    if ([self isCaptureCellInIndexPath:indexPath]) {
        [self didChooseImagePicker];
    } else {
        [self didChooseImage:self.images[indexPath.row]];
    }
}

- (void)didChooseImage:(NSDictionary *)dictionary {
    if ([self.delegate respondsToSelector:@selector(didChooseImage:)]) {
        [NBNPhotoMiner imageFromDictionary:dictionary block:^(UIImage *fullResolutionImage) {
            [self.delegate didChooseImage:fullResolutionImage];
        }];
    } else {
         NSAssert(NO, @"Delegate didChooseImage: has to be implemented");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self prepareForImagePreviews];
    [self toggleCapturingMode];
    [self performSelector:@selector(reloadDataSource) withObject:nil afterDelay:1];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self prepareForImagePreviews];
    [self toggleCapturingMode];
}

@end
