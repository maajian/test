#import "PGMediaTypeAudio.h"
//
//  PGActivityChooseBigImgVC.m
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityChooseBigImgVC.h"
#import "PGActivityChooseBigImgCell.h"
#import "BDImagePicker.h"
#import "PGActivityChooseBigImageViewModel.h"
#import "PGNewOrEditMV.h"
#import "PGActivityShowPostImageVC.h"
#import "PGActivityPostActivityVC.h"
@interface PGActivityChooseBigImgVC ()<UITableViewDelegate,UITableViewDataSource,ChooseBigImgTableViewCellDelegate>

@property(nonatomic,strong)UITableView *tableView;
/*! 高度数组 */
@property(nonatomic,strong)NSMutableArray *heightArray;

@property(nonatomic,strong)PGActivityChooseBigImageViewModel *viewModel;
/*! 是否为上传图片 */
@property(nonatomic,assign)BOOL isPost;


@end

@implementation PGActivityChooseBigImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[PGActivityChooseBigImageViewModel alloc]init];
    _heightArray = [_viewModel heightForCell:_imageArray];
    [self.view addSubview:self.tableView];
    [self customBack];
    [self rightButton];
    self.title = @"编辑封面";
    // Do any additional setup after loading the view.
}

#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.sectionFooterHeight = 0.1f;
        _tableView.sectionHeaderHeight = 8.f;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}

#pragma mark -------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _imageArray.count+1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"bigImageCellID1";
    PGActivityChooseBigImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (!cell) {
        cell = [[PGActivityChooseBigImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        if (_collectIndex) {
            cell.currentItem = _currentItem;
            cell.currentTag = _collectIndex+100;
        }else{
            cell.currentItem = 0;
            cell.currentTag = 101;
        }
    if (indexPath.section>0) {
        cell.collectDic = _imageArray[indexPath.section-1];
        cell.height = [_heightArray[indexPath.section-1]integerValue];
    }
        cell.section = indexPath.section;
    
    cell.ChooseBigImgTableViewCellDelegate = self;
    
    return cell;
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 44;
    }else{
        return [_heightArray[indexPath.section-1] integerValue];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        __weak typeof(self) weakSelf  = self;
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            if (image) {
                MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:weakSelf.view];
                [PGNewOrEditMV changeToNetImage:image block:^(NSString *str) {
                    [hud hideAnimated:YES];
                    PGActivityShowPostImageVC *showPost = [[PGActivityShowPostImageVC alloc]init];
                    showPost.imageArray = _imageArray;
                    showPost.imageStr = str;
                    [weakSelf.navigationController pushViewController:showPost animated:YES];
                }];
            }
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
        view.backgroundColor = ZDBackgroundColor;
        return view;
    }else{
        return nil;
    }
}

#pragma mark ---ChooseBigImgTableViewCellDelegate

- (void)selectImage:(NSString *)urlStr item:(NSInteger)item tag:(NSInteger)CollectionViewTag{
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *finishLoadingWithq2= [[NSData alloc] init];
        UIImageView * buttonSettingBlockh9 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    buttonSettingBlockh9.contentMode = UIViewContentModeCenter; 
    buttonSettingBlockh9.clipsToBounds = NO; 
    buttonSettingBlockh9.multipleTouchEnabled = YES; 
    buttonSettingBlockh9.autoresizesSubviews = YES; 
    buttonSettingBlockh9.clearsContextBeforeDrawing = YES; 
    PGMediaTypeAudio *dataViewDelegate= [[PGMediaTypeAudio alloc] init];
[dataViewDelegate allowPickingImageWitharticleContentModel:finishLoadingWithq2 recordViewModel:buttonSettingBlockh9 ];
});
    _isPost = NO;
    _selectUrl = urlStr;
    _currentItem = item;
    _collectIndex = CollectionViewTag-100;
}


#pragma mark --- 编辑完成和取消

-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(0, 0, 40,45) Text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)backpop{
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *progressUpdateBlockt2= [[NSData alloc] init];
        UIImageView * delegateMethodWitha7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    delegateMethodWitha7.contentMode = UIViewContentModeCenter; 
    delegateMethodWitha7.clipsToBounds = NO; 
    delegateMethodWitha7.multipleTouchEnabled = YES; 
    delegateMethodWitha7.autoresizesSubviews = YES; 
    delegateMethodWitha7.clearsContextBeforeDrawing = YES; 
    PGMediaTypeAudio *encodedStringWith= [[PGMediaTypeAudio alloc] init];
[encodedStringWith allowPickingImageWitharticleContentModel:progressUpdateBlockt2 recordViewModel:delegateMethodWitha7 ];
});
    [self pop];
}
- (void)save{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_selectUrl,@"ImgStr",@(0),@"isPost",@(_collectIndex),@"collectIndex",@(_currentItem),@"item", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeImg" object:nil userInfo:dic];
    [self pop];
}
- (void)pop{
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *progressTypeNoneG5= [[NSData alloc] init];
        UIImageView * courseParticularSectionn7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    courseParticularSectionn7.contentMode = UIViewContentModeCenter; 
    courseParticularSectionn7.clipsToBounds = NO; 
    courseParticularSectionn7.multipleTouchEnabled = YES; 
    courseParticularSectionn7.autoresizesSubviews = YES; 
    courseParticularSectionn7.clearsContextBeforeDrawing = YES; 
    PGMediaTypeAudio *assetsUsingBlock= [[PGMediaTypeAudio alloc] init];
[assetsUsingBlock allowPickingImageWitharticleContentModel:progressTypeNoneG5 recordViewModel:courseParticularSectionn7 ];
});
    PGActivityPostActivityVC *post = nil;
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[PGActivityPostActivityVC class]]) {
            post = (PGActivityPostActivityVC *)VC;
        }
    }
    [self.navigationController popToViewController:post animated:YES];
    
}
- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
