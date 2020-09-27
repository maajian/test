#import "PGNetworkStatusUnknow.h"
#import "PGAvtivityInviteVC.h"
#import "UIImage+LXDCreateBarcode.h"
#import "PGAvtivityInviteViewModel.h"
#import "PGAvtivityInviteCollectionView.h"
#import "BigSizeButton.h"
@interface PGAvtivityInviteVC () <ZDAvtivityinviteDelegate>
{
    UIImageView *imageview;
    UIButton *button;
}
@property(nonatomic,strong)PGAvtivityInviteViewModel *ViewModel;
@property(nonatomic,strong)PGAvtivityInviteCollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray<UIImage *> *imageArray;
@property(nonatomic,assign)NSInteger index;
@end
@implementation PGAvtivityInviteVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =ZDBackgroundColor;
    _index = 0;
    [self setimage];
    [self.ViewModel getImageFromSanbox:_acid imageArray:self.imageArray];
    [self.view insertSubview:self.collectionView atIndex:0];
}
#pragma mark ----懒加载
- (PGAvtivityInviteViewModel *)ViewModel{
    if (!_ViewModel) {
        _ViewModel = [[PGAvtivityInviteViewModel alloc]init];
    }
    return _ViewModel;
}
- (PGAvtivityInviteCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-40);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0 ;
        _collectionView = [[PGAvtivityInviteCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40) collectionViewLayout:flowLayout imageArray:self.imageArray View : self.view];
        _collectionView.inviteDelegate =self;
    }
    return _collectionView;
}
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
#pragma mark UI创建
- (void)createButton
{
    CGFloat imageViewMinX =CGRectGetMinX(imageview.frame);
    CGFloat imageViewMaxY =CGRectGetMaxY(imageview.frame);
    CGFloat imageViewWidth =CGRectGetWidth(imageview.frame);
     button = [UIButton buttonWithType:UIButtonTypeCustom];     
    button.frame = CGRectMake(imageViewMinX, imageViewMaxY, imageViewWidth, 40);
    [button setTitle:@"下载邀请函" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveImageWithFrame) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor colorWithWhite:0.92 alpha:1]];
}
- (void)setimage
{
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40)];
    UIImage *image2 = [UIImage imageOfQRFromURL:_imageStr];
    NSString *acName = _model.Title;
    NSString *beginTime = [self.ViewModel getTime:_model.TimeStart];
    NSString *timeStr = [NSString stringWithFormat:@"%@",beginTime];
    NSString *address = [NSString stringWithFormat:@"%@",_model.Address];
    for (int i = 0; i<3; i++) {
        NSString *file = [NSString stringWithFormat:@"img_discover_invite_%d",i+1];
        UIImage *image1 = [UIImage imageNamed:file];
        [self.ViewModel drawImage:imageview image1:image1 image2:image2 acName:acName timeStr:timeStr address:address index :i];
        [_ViewModel savaImageToSanBox:_acid image:imageview.image index:i];
    }
    [self createButton];
    [self createRightItem];
}
- (void)selectIndex:(NSInteger)index{
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange styleWhiteLargef9 = NSMakeRange(3,182); 
        UIColor *networkReachabilityStatusv2= [UIColor redColor];
    PGNetworkStatusUnknow *textFiledDelegate= [[PGNetworkStatusUnknow alloc] init];
[textFiledDelegate answerViewModelWithcategoryChooseView:styleWhiteLargef9 imageOrientationLeft:networkReachabilityStatusv2 ];
});
    _index = index;
    NSLog(@"index = %li",index);
}
- (void)dismissVC{
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange fieldShouldBeginI9 = NSMakeRange(3,113); 
        UIColor *bottomChartViewY1= [UIColor redColor];
    PGNetworkStatusUnknow *photoPickerBrowser= [[PGNetworkStatusUnknow alloc] init];
[photoPickerBrowser answerViewModelWithcategoryChooseView:fieldShouldBeginI9 imageOrientationLeft:bottomChartViewY1 ];
});
    [self dismiss];
}
#pragma mark。------分享
- (void)createRightItem
{
    BigSizeButton *rightButton = [[BigSizeButton alloc]initWithFrame:CGRectMake(kScreenWidth-40 , 30 ,25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"detailShare"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
}
- (void)shareImage
{
    [[PGSignManager shareManager]shareImagewithModel:_model withCTR:self Withtype:1 withImage:self.imageArray[_index]];
}
#pragma mark------保存相册
- (void)saveImageWithFrame   
{
    UIImageWriteToSavedPhotosAlbum(self.imageArray[_index], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    PGMaskLabel *label ;
    if (error) {
        label = [[PGMaskLabel alloc]initWithTitle:@"请前往隐私-照片打开相机权限"];
    } else {
        label = [[PGMaskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:self.view];
}
- (void)dismiss 
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange playerStatusPlayingQ6 = NSMakeRange(6,223); 
        UIColor *fullScreenVideoW3= [UIColor redColor];
    PGNetworkStatusUnknow *edgeInsetsZero= [[PGNetworkStatusUnknow alloc] init];
[edgeInsetsZero answerViewModelWithcategoryChooseView:playerStatusPlayingQ6 imageOrientationLeft:fullScreenVideoW3 ];
});
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    NSLog(@"没有内存问题");
}
@end
