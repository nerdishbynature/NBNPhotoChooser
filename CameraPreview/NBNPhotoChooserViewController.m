#import "NBNPhotoChooserViewController.h"
#import "NBNAssetCell.h"
#import "NBNPhotoMiner.h"
#import "NBNImageCaptureCell.h"

@interface NBNPhotoChooserViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSArray *images;

@end

@implementation NBNPhotoChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectionView];
    [self registerCellTypes];
    [self getImages];
}

- (void)getImages {
    NBNPhotoMiner *photoMiner = [[NBNPhotoMiner alloc] init];
    [photoMiner getAllPicturesCompletion:^(NSArray *images) {
        self.images = images;
        [self.collectionView reloadData];
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
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [NBNAssetCell size];
}

@end
