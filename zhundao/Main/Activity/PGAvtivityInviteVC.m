#import "PGNetworkStatusUnknow.h"
//
//  PGAvtivityInviteVC.m
//  zhundao
//
//  Created by zhundao on 2017/2/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

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

//254 255 13。黄
// 0 79 155 蓝字

@property(nonatomic,strong)PGAvtivityInviteViewModel *ViewModel;
/*! 滑动视图 */
@property(nonatomic,strong)PGAvtivityInviteCollectionView *collectionView;
/*! 图片数组 */
@property(nonatomic,strong)NSMutableArray<UIImage *> *imageArray;
/*! 当前滑动位置 */
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
//    for (int i = 0; i <3 ; i++) {
//        UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(100*i, 5, 100, 100)];
//        imageView.image = self.imageArray[i];
//        [self.view addSubview:imageView];
//    }
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
     button = [UIButton buttonWithType:UIButtonTypeCustom];     //保存图片按钮
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
    /*! 二维码图片 */
    UIImage *image2 = [UIImage imageOfQRFromURL:_imageStr];
//    /*! 邀请函背景图 */
//    NSString *file = [[NSBundle mainBundle]pathForResource:@"邀请函1" ofType:@".png"];
//    UIImage *image1 = [UIImage imageWithContentsOfFile:file];
    /*! 获取名称字符串 */
    NSString *acName = _model.Title;
    /*! 时间字符串 */
    NSString *beginTime = [self.ViewModel getTime:_model.TimeStart];
    NSString *timeStr = [NSString stringWithFormat:@"%@",beginTime];
    /*! 地址 */
    NSString *address = [NSString stringWithFormat:@"%@",_model.Address];
    /*! 绘制 */
    for (int i = 0; i<3; i++) {
        /*! 邀请函背景图 */
        NSString *file = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"邀请函%d",i+1] ofType:@".png"];
        UIImage *image1 = [UIImage imageWithContentsOfFile:file];
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
[textFiledDelegate pg_answerViewModelWithcategoryChooseView:styleWhiteLargef9 imageOrientationLeft:networkReachabilityStatusv2 ];
});
    _index = index;
    NSLog(@"index = %li",index);
}

- (void)dismissVC{
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange fieldShouldBeginI9 = NSMakeRange(3,113); 
        UIColor *bottomChartViewY1= [UIColor redColor];
    PGNetworkStatusUnknow *photoPickerBrowser= [[PGNetworkStatusUnknow alloc] init];
[photoPickerBrowser pg_answerViewModelWithcategoryChooseView:fieldShouldBeginI9 imageOrientationLeft:bottomChartViewY1 ];
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
- (void)saveImageWithFrame   //保存到相册
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

- (void)dismiss //弹出
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange playerStatusPlayingQ6 = NSMakeRange(6,223); 
        UIColor *fullScreenVideoW3= [UIColor redColor];
    PGNetworkStatusUnknow *edgeInsetsZero= [[PGNetworkStatusUnknow alloc] init];
[edgeInsetsZero pg_answerViewModelWithcategoryChooseView:playerStatusPlayingQ6 imageOrientationLeft:fullScreenVideoW3 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"没有内存问题");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end