#import "PGViewImageFinish.h"
//
//  PGMeAuthViewController.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMeAuthViewController.h"
#import "PGMeAutoTopTableViewCell.h"
#import "PGMeAutoBottomTableViewCell.h"
#import "BDImagePicker.h"
#import "PGNewOrEditMV.h"
#import "PGMeAuthViewModel.h"
#import "PGMeAuthModel.h"
static NSString *topID  = @"autoTopID";
static NSString *bottomID  = @"autobottomID";

@interface PGMeAuthViewController ()<UITableViewDelegate,UITableViewDataSource>

/*! 表视图 */
@property(nonatomic,strong)UITableView *tableView;
/*! 上传的字段 */
@property(nonatomic,strong)NSMutableDictionary *postDic;
/*! 用于转化图片的vm */
@property(nonatomic,strong)PGNewOrEditMV *imageMV;
/*! 发起认证的viewmodel */
@property(nonatomic,strong)PGMeAuthViewModel *AuthVM;

@property(nonatomic,strong)PGMeAuthModel *model;

@end

@implementation PGMeAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证";
    [self getData];
    [self.view addSubview:self.tableView];
    _imageMV = [[PGNewOrEditMV alloc]init];
    _AuthVM = [[PGMeAuthViewModel alloc]init];
    // Do any additional setup after loading the view.
}

- (void)getData{
    if (_authdic) {
        _model  = [PGMeAuthModel yy_modelWithJSON:[NSDictionary dictionaryWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"]]];
        [self.postDic setObject:_model.name forKey:@"Name"];
        [self.postDic setObject:_model.mobile forKey:@"Mobile"];
        [self.postDic setObject:_model.idCard forKey:@"IDCard"];
        [self.postDic setObject:_model.idCardBack forKey:@"IdCardBack"];
        [self.postDic setObject:_model.idCardFront forKey:@"IdCardFront"];
    }
}

#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
    }
    return _tableView;
}

- (NSMutableDictionary *)postDic{
    if (!_postDic) {
        _postDic = [NSMutableDictionary dictionary];
    }
    return _postDic;
}



#pragma mark -------UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  section==0?3:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PGMeAutoTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topID];
        if (!cell) {
            cell = [[PGMeAutoTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.rightTf addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEnd];
        }
        if (indexPath.row==0) {
            cell.leftStr=@"姓名";
            cell.rightTf.placeholder = @"请输入姓名";
            cell.rightTf.text = _model?_model.name:@"";
        }else if (indexPath.row==1){
            cell.leftStr=@"手机号码";
            cell.rightTf.placeholder = @"请输入手机号码";
            cell.rightTf.keyboardType = UIKeyboardTypeNumberPad;
            cell.rightTf.text = _model?_model.mobile:@"";
        }else{
            cell.leftStr=@"身份证号码";
            cell.rightTf.placeholder = @"请输入身份证号码";
            cell.rightTf.keyboardType = UIKeyboardTypeURL;
            cell.rightTf.text = _model?_model.idCard:@"";
        }
        cell.rightTf.tag = indexPath.row;
        
        return cell;
    }if (indexPath.section == 1||indexPath.section==2){
        PGMeAutoBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bottomID];
        if (!cell) {
            cell = [[PGMeAutoBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bottomID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedImage:)];
            cell.idCardImgView.userInteractionEnabled = YES;
            [cell.idCardImgView addGestureRecognizer:tap];
        }if (indexPath.section==1) {
            cell.topStr = @"身份证正面";
        }else{
            cell.topStr = @"身份证背面";
        }
        cell.idCardImgView.tag = indexPath.section;
        cell.model = _model;
        return cell;
    }
    return nil;
}
#pragma mark -------UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section==0?44:144;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   return  section==2?120:0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
        View.backgroundColor = [UIColor clearColor];
        UIButton *explainButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth-120, 0, 110, 44) title:@"为什么要实名认证" textcolor:ZDMainColor Target:self action:@selector(explain) BackgroundColor:nil cornerRadius:0 masksToBounds:0];
        explainButton.titleLabel.font = [UIFont systemFontOfSize:13];
        UIButton *addAccountButton = [MyButton initWithButtonFrame:CGRectMake(10, 44, kScreenWidth-20, 44) title:@"实名认证" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor: ZDMainColor cornerRadius:5 masksToBounds:YES];
        [View addSubview:addAccountButton];
        [View addSubview:explainButton];
        return View;
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    View.backgroundColor = [UIColor clearColor];
    return View;
}

#pragma mark --- 选择图片 

- (void)selectedImage:(UITapGestureRecognizer *)tap{
dispatch_async(dispatch_get_main_queue(), ^{
    CGRect separatorStyleSinglef7 = CGRectZero;
        NSData *spinLockLockR7= [[NSData alloc] init];
    PGViewImageFinish *groupViewController= [[PGViewImageFinish alloc] init];
[groupViewController pg_progressUpdateBlockWithimageGenerationError:separatorStyleSinglef7 finishLoadWith:spinLockLockR7 ];
});
    UIImageView *imgView =(UIImageView *)tap.view;
    __weak typeof(self) weakSelf = self;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        imgView.image = image;
        [PGNewOrEditMV changeToNetImage:image block:^(NSString *str) {
            if (tap.view.tag==1) {
                [weakSelf.postDic setObject:str forKey:@"IdCardFront"];
            }else{
                [weakSelf.postDic setObject:str forKey:@"IdCardBack"];
            }
        }];
    }];
}

#pragma mark --- 输入框事件 

- (void)textFieldEnd:(UITextField *)textField{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        return;
    }
    switch (textField.tag) {
        case 0:{
            [self.postDic setObject:textField.text forKey:@"Name"];
        }break;
        case 1:{
            [self.postDic setObject:textField.text forKey:@"Mobile"];
        }break;
        case 2:{
            [self.postDic setObject:textField.text forKey:@"IDCard"];
        }break;
        default:
            break;
    }
}

#pragma mark---- 按钮点击事件

- (void)sureAction{
    [self.view endEditing:YES];
    if ( (_model&&self.postDic.count!=6)||(!_model&&self.postDic.count!=5)) {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"请完善信息"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [_AuthVM postAuthentication:self.postDic authBlock:^(BOOL isSuccess) {
        [hud hideAnimated:YES];
        if (isSuccess) {
            MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeText labelText:@"申请成功，我们会在一个工作日内审核" showAnimated:YES UIView:self.view imageName:nil];
            [hud1 hideAnimated:YES afterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else{
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"手机号或身份证号已被实名认证"];
            [label labelAnimationWithViewlong:self.view];
        }
    }];
}
- (void)explain{
dispatch_async(dispatch_get_main_queue(), ^{
    CGRect articleDailyTrainT0 = CGRectMake(158,7,223,214); 
        NSData *changeFrameNotificationX7= [[NSData alloc] init];
    PGViewImageFinish *collectionViewCell= [[PGViewImageFinish alloc] init];
[collectionViewCell pg_progressUpdateBlockWithimageGenerationError:articleDailyTrainT0 finishLoadWith:changeFrameNotificationX7 ];
});
    [PGAlertView alertWithTitle:@"提示" message:@"所有委托准到代收款的活动，为了确保主办方的资金安全，我们在首次提现时进行了实名认证。实名认证成功后才允许提现，且申请提现支付宝和银行卡的所有者须为此实名用户" cancelBlock:nil];
}


- (void)dealloc{
dispatch_async(dispatch_get_main_queue(), ^{
    CGRect underlineStyleSingleM2 = CGRectZero;
        NSData *pageIndicatorTintz5= [[NSData alloc] init];
    PGViewImageFinish *metersTimeLabel= [[PGViewImageFinish alloc] init];
[metersTimeLabel pg_progressUpdateBlockWithimageGenerationError:underlineStyleSingleM2 finishLoadWith:pageIndicatorTintz5 ];
});
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
