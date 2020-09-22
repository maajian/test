#import "PGCompositionWithAsset.h"
//
//  PGMePersonInfoVC.m
//  zhundao
//
//  Created by zhundao on 2017/10/31.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMePersonInfoVC.h"
#import "PGMePersonInfoCell.h"
#import "PGMePersonInfoModel.h"
#import "BDImagePicker.h"
#import "PGNewOrEditMV.h"
#import "PGMeChangeSexVC.h"
#import "PGMeChangeInfoVC.h"
#import "PGMeChangeInfoViewModel.h"
@interface PGMePersonInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *imageView;
/*! 数据源 */
@property(nonatomic,strong)PGMePersonInfoModel *model;
/*! 左边的字符串 */
@property(nonatomic,copy)NSArray *leftArray;

@property(nonatomic,strong)PGMeChangeInfoViewModel *viewModel;

@end

@implementation PGMePersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)baseSetting{
    self.title = @"信息修改";
    _viewModel = [[PGMeChangeInfoViewModel alloc]init];
   _model = [PGMePersonInfoModel yy_modelWithJSON:_userDic];
    _leftArray = [NSArray arrayWithObjects:@"头像",@"姓名",@"昵称",@"手机",@"邮箱",@"性别",@"单位",@"行业",@"职务", nil];
}

#pragma mark--- 网络请求

- (void)netWork{
    [_viewModel getUserInfo:^(id responseObject) {
        NSDictionary *data = [NSDictionary dictionaryWithDictionary:responseObject];
        _userDic = [data[@"data"] copy];
        _model  = [PGMePersonInfoModel yy_modelWithJSON:_userDic];
        [_tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    }
    return _tableView;
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"infoCell1";
    static NSString *cellID2 = @"infoCell2";
    if (indexPath.row==0) {
        UITableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!Cell) {
            Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            [self createImageView:Cell];
        }
        return Cell;
    }else{
        PGMePersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell = [[PGMePersonInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        cell.leftArray = _leftArray;
        cell.model = _model;
        cell.cellTag = indexPath.row;
        return cell;
    }
}

- (void)createImageView:(UITableViewCell *)cell{
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *sizeWithAssett6= [UIImage imageNamed:@""]; 
        UITableViewStyle browserPhotoViewp6 = UITableViewStylePlain; 
    PGCompositionWithAsset *periodicTimeObserver= [[PGCompositionWithAsset alloc] init];
[periodicTimeObserver photosBytesWithWithbadgeDefaultFont:sizeWithAssett6 timeRangeValue:browserPhotoViewp6 ];
});
    UILabel *leftLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 40, 70) Text:@"头像" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [cell.contentView addSubview:leftLabel];
    _imageView = [[UIImageView alloc]init];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.headImgurl] placeholderImage:[UIImage imageNamed:@"user"]];
    _imageView.layer.cornerRadius = 5;
    _imageView.layer.masksToBounds = YES;
    [cell.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView).offset(0);
        make.top.equalTo(cell.contentView).offset(8);
        make.bottom.equalTo(cell.contentView).offset(-8);
        make.width.mas_equalTo(54);
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 70;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            if (image) {
                MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
                [PGNewOrEditMV changeToNetImage:image block:^(NSString *str) {
                    _imageView.image = image;
                    [hud hideAnimated:YES];
                    MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"上传成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
                    [hud1 hideAnimated:YES afterDelay:1.5];
                    NSDictionary *dic = @{@"HeadImgurl":str};
                    [_viewModel UpdateUserInfo:dic successBlock:^(id responseObject) {
                        NSLog(@"responseObject = %@",responseObject);
                    } errorBlock:^(NSError *error) {
                        NSLog(@"error = %@",error);
                    }];
                }];
                
            }
        }];
    }else if (indexPath.row == 5){
        PGMeChangeSexVC *changeSex = [[PGMeChangeSexVC alloc]init];
        changeSex.Sex = _model.Sex;
        [self setHidesBottomBarWhenPushed: YES];
        [self.navigationController pushViewController:changeSex animated:YES];
    }else{
        PGMePersonInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        PGMeChangeInfoVC *changeInfo = [[PGMeChangeInfoVC alloc]init];
        changeInfo.oriStr = cell.rightLabel.text;
        changeInfo.cellTag = indexPath.row;
        [self setHidesBottomBarWhenPushed: YES];
        [self.navigationController pushViewController:changeInfo animated:YES];;
    }
}

#pragma mark --- 视图生命周期

- (void)viewWillAppear:(BOOL)animated{
dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *badgeWithStyleN0= [UIImage imageNamed:@""]; 
        UITableViewStyle inviteAnswerNormalg4 = UITableViewStylePlain; 
    PGCompositionWithAsset *sliderTouchDown= [[PGCompositionWithAsset alloc] init];
[sliderTouchDown photosBytesWithWithbadgeDefaultFont:badgeWithStyleN0 timeRangeValue:inviteAnswerNormalg4 ];
});
    [super viewWillAppear:animated];
    [self netWork];
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
