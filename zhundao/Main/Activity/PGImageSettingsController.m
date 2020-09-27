#import "PGViewWithIdentifier.h"
#import "PGImageSettingsController.h"
#import "PGPhotoCollectionCell.h"
#import "PGImagePreviewController.h"
@import Photos;
@interface PGImageSettingsController () <UICollectionViewDataSource, UICollectionViewDelegate, PGImagePreviewControllerDelegate, PHPhotoLibraryChangeObserver, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (nonatomic, strong) UIViewController *previewController;
@property (nonatomic, assign) BOOL selecting;
@property (nonatomic, strong) PHFetchResult *photosResult;
@property (nonatomic, strong) NSMutableDictionary *photos;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end
@implementation PGImageSettingsController
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selecting = NO;
    self.button1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.button2.imageView.contentMode = UIViewContentModeScaleAspectFit;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selecting = NO;
    self.button1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.button2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self PG_fetchPhotos];
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}
- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    layout.itemSize = CGSizeMake(height * 0.8, height);
    [self.collectionView setNeedsLayout];
}
- (void)setSelecting:(BOOL)selecting {
    _selecting = selecting;
    if (selecting){
        [self.button1 setImage:[UIImage imageNamed:@"img_public_preview"] forState:UIControlStateNormal];
        [self.button2 setImage:[UIImage imageNamed:@"img_public_check_blue"] forState:UIControlStateNormal];
        [self.button1 setTitle:@"预览" forState:UIControlStateNormal];
        [self.button2 setTitle:@"发送" forState:UIControlStateNormal];
        [self.button2 setTitleColor:[UIColor colorWithRed:93/255.f green:150/255.f blue:209/255.f alpha:1.f] forState:UIControlStateNormal];
    }
    else {
        [self.button1 setImage:[UIImage imageNamed:@"img_public_photo_image"] forState:UIControlStateNormal];
        [self.button2 setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
        [self.button1 setTitle:@"拍照" forState:UIControlStateNormal];
        [self.button2 setTitle:@"相册" forState:UIControlStateNormal];
        [self.button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}
#warning 可能错误
- (void)PG_fetchPhotos {
    PHFetchOptions *nearestPhotosOptions = [[PHFetchOptions alloc] init];
    nearestPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.photosResult = [PHAsset fetchAssetsWithOptions:nearestPhotosOptions];
    self.photos = [NSMutableDictionary dictionary];
}
- (void)reload {
    self.selecting = NO;
    self.selectedIndexPath = nil;
    [self.collectionView reloadData];
}
- (IBAction)buttonAction:(UIButton *)sender {
    if (self.selecting) {
        if (sender == self.button1) {
            PGImagePreviewController *previewController = [self.storyboard instantiateViewControllerWithIdentifier:@"preview"];
            previewController.delegate = self;
            previewController.asset = self.photosResult[self.selectedIndexPath.item];;
            UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:previewController];
            [self.delegate lm_imageSettingsController:self presentPreview:naviController];;
        }
        else {
            PHAsset *asset = self.photosResult[self.selectedIndexPath.item];
            CGSize targetSize = [UIScreen mainScreen].bounds.size;
            targetSize.width *= 2;
            targetSize.height *= 2;
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:targetSize
                                                      contentMode:PHImageContentModeAspectFit
                                                          options:nil
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                        BOOL isDegraded = [info[PHImageResultIsDegradedKey] boolValue];
                                                        if (!isDegraded) {
                                                            [self.delegate lm_imageSettingsController:self insertImage:result];
                                                        }
                                                    }];
        }
    }
    else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if (sender == self.button1) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        picker.delegate = self;
        [self.delegate lm_imageSettingsController:self presentImagePickerView:picker];
    }
}
#pragma mark - <PHPhotoLibraryChangeObserver>
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    [self PG_fetchPhotos];
}
#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosResult.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PGPhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    UIImage *image = self.photos[indexPath];
    if (image) {
        cell.imageView.image = image;
    }
    else {
        cell.imageView.image = nil;
        PHAsset *asset = self.photosResult[indexPath.item];
        CGSize targetSize = CGSizeMake(200, 200);
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:targetSize
                                                  contentMode:PHImageContentModeAspectFit
                                                      options:nil
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    self.photos[indexPath] = result;
                                                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                }];
    }
    cell.selected = ([indexPath isEqual:self.selectedIndexPath]);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange playerItemPlaybackd5 = NSMakeRange(2,81); 
        UITextView *applicationStateActiveW0= [[UITextView alloc] initWithFrame:CGRectMake(23,211,169,100)]; 
    applicationStateActiveW0.editable = NO; 
    applicationStateActiveW0.font = [UIFont systemFontOfSize:22];
    applicationStateActiveW0.text = @"moreRecommendUser";
    PGViewWithIdentifier *swimRecordData= [[PGViewWithIdentifier alloc] init];
[swimRecordData keyboardTypeNumberWithvideoPreviewCell:playerItemPlaybackd5 cyclingLineAnimation:applicationStateActiveW0 ];
});
    if ([indexPath isEqual:self.selectedIndexPath]) {
        self.selectedIndexPath = nil;
        self.selecting = NO;
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    else {
        self.selectedIndexPath = indexPath;
        self.selecting = YES;
    }
}
#pragma mark - <PGImagePreviewControllerDelegate>
- (void)lm_previewController:(PGImagePreviewController *)previewController dismissPreviewWithCancel:(BOOL)cancel {
    if (!cancel) {
        [self.delegate lm_imageSettingsController:self insertImage:self.photos[self.selectedIndexPath]];
    }
}
#pragma mark - 
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    CGSize targetSize = [UIScreen mainScreen].bounds.size;
    targetSize.width *= 2;
    targetSize.height = targetSize.width * originalImage.size.height / originalImage.size.width;
    UIGraphicsBeginImageContext(targetSize);
    [originalImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.delegate lm_imageSettingsController:self insertImage:scaledImage];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
