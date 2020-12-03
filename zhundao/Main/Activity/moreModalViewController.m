//
//  moreModalViewController.m
//  zhundao
//
//  Created by zhundao on 2017/2/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "moreModalViewController.h"
#import "Time.h"
#import "editViewController.h"
#import "ListViewController.h"
#import "CodeViewController.h"
#import "inviteViewController.h"
#import "detailActivityViewController.h"
#import "ConsultViewController.h"
#import "WXApi.h"
#import "PostSignViewController.h"
#import "oneActivityViewController.h"
#import "postActivityViewController.h"
#import "SignUpViewController.h"

#import "moreModalModel.h"

#import "moreModalCell.h"
#import "moreModalHeaderView.h"

static const CGFloat itemSpace = 1;
static NSString *cellID = @"moreModalCell";
static NSString *headerID = @"moreModalHeaderView";

@interface moreModalViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, moreModalHeaderViewDelegate> {
    NSString *accesskey;
    NSString *_endTimeStr; // 截止时间
}
// 数据
@property (nonatomic, copy) NSArray<moreModalModel *> *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation moreModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"model = %@",_moreModel);
    [self initSet];
    accesskey = [[SignManager shareManager]getaccseekey];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netWorkConsult];
}

#pragma mark --- lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 150);
        layout.itemSize = CGSizeMake((kScreenWidth - 3 * itemSpace) / 3 , 90);
        layout.minimumLineSpacing = itemSpace;
        layout.minimumInteritemSpacing = itemSpace;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopBarHeight) collectionViewLayout:layout];
        [_collectionView registerClass:[moreModalCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[moreModalHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        _collectionView.backgroundColor = ZDBackgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

#pragma mark --- initLayout
- (void)initSet {
    self.title = @"活动管理";
    _dataArray = @[[moreModalModel editModel],
                   [moreModalModel personListModel],
                   [moreModalModel consultModel],
                   [moreModalModel linkModel],
                   [moreModalModel applyEndModel],
                   [moreModalModel deleteModel],
                   [moreModalModel shareModel],
                   [moreModalModel inviteModel],
                   [moreModalModel qrcodeModel],
                   [moreModalModel copyModel],
                   [moreModalModel signinModel]];
    [self.view addSubview:self.collectionView];
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    moreModalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

#pragma mark --- UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        moreModalHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        header.model = self.moreModel;
        header.endTime = _endTimeStr;
        header.headerViewDelegate = self;
        return header;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    moreModalModel *model = _dataArray[indexPath.item];
    switch (model.moreMoalType) {
        case MoreMoalTypeEdit: {
            [self pushToEdit];
        }
            break;
        case MoreMoalTypePersonList: {
            [self signList];
        }
            break;
        case MoreMoalTypeConsult: {
            [self consult];
        }
            break;
        case MoreMoalTypeLink: {
            [self link];
        }
            break;
        case MoreMoalTypeApplyEnd: {
            [self signEnd];
        }
            break;
        case MoreMoalTypeDelete: {
            [self delelteActivity];
        }
            break;
        case MoreMoalTypeShare: {
            [[SignManager shareManager]shareImagewithModel:_moreModel withCTR:self Withtype:5 withImage:nil];
        }
            break;
        case MoreMoalTypeInvite: {
            inviteViewController *invite = [[inviteViewController alloc]init];
            invite.acid = _moreModel.ID;
            invite.model = self.moreModel;
            NSString *imagestr =   [NSString stringWithFormat:@"%@event/%li",zhundaoH5Api,(long)_moreModel.ID];
            invite.imageStr = imagestr ;
            [self presentViewController:invite animated:YES completion:nil];
        }
            break;
        case MoreMoalTypeQRCode: {
            CodeViewController *code = [[CodeViewController alloc]init];
            NSString *imagestr =   [NSString stringWithFormat:@"%@event/%li",zhundaoH5Api,(long)_moreModel.ID];
            code.imagestr = imagestr;
            code.titlestr = _moreModel.Title;
            code.labelStr = @"报名";
            [self presentViewController:code animated:YES completion:nil];
        }
            break;
        case MoreMoalTypeSignin: {
            [self signin];
        }
            break;
        case MoreMoalTypeCopy: {
            [self copyActivity];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- moreModalHeaderViewDelegate
// 跳转详情
- (void)header:(moreModalHeaderView *)headerView didTapDetailView:(UIView *)detailView {
    detailActivityViewController *detail = [[detailActivityViewController alloc]init];
    detail.model =_moreModel;
    detail.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/event/%li?accesskey=%@",(long)_moreModel.ID,accesskey];
    [self.navigationController pushViewController:detail animated:YES];
}

// 图表
- (void)header:(moreModalHeaderView *)headerView didTapChartView:(chartType)type {
    switch (type) {
            //  报名
        case chartTypeApply: {
            SignUpViewController *signUp = [[SignUpViewController alloc] init];
            signUp.activityId = _moreModel.ID;
            signUp.chartType = ChartTypeActivityPerson;
            [self.navigationController pushViewController:signUp animated:YES];
        }
            break;
            // 收入
        case chartTypeIncome: {
            SignUpViewController *signUp = [[SignUpViewController alloc] init];
            signUp.activityId = _moreModel.ID;
            signUp.chartType = ChartTypePay;
            [self.navigationController pushViewController:signUp animated:YES];
        }
            break;
            // 浏览
        case chartTypeBrowse: {
            SignUpViewController *signUp = [[SignUpViewController alloc] init];
            signUp.activityId = _moreModel.ID;
            signUp.chartType = ChartTypeRead;
            [self.navigationController pushViewController:signUp animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- action
// 签到
- (void)signin {
    oneActivityViewController *one = [[oneActivityViewController alloc]init];
    one.acID = _moreModel.ID;
    one.activityName = _moreModel.Title;
    [self.navigationController pushViewController:one animated:YES];
}

// 删除活动
- (void)delelteActivity {
    [ZDAlertView alertWithTitle:@"确定删除活动?" message:@"删除后将不能恢复" sureBlock:^{
        MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/activity/deleteActivity?token=%@&activityId=%li&from=ios",zhundaoApi,[SignManager shareManager].getToken,(long)_moreModel.ID];
        [ZD_NetWorkM postDataWithMethod:urlStr parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            NSLog(@"%@",dic);
            [hud hideAnimated:YES];
            if ([dic[@"Res"] integerValue]==0) {
                MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
                [hud1 hideAnimated:YES afterDelay:1.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    _backBlock(1);   //1 表示删除
                });
            }else{
                maskLabel *label = [[maskLabel alloc]initWithTitle:dic[@"Msg"]];
                [label labelAnimationWithViewlong:self.view];
            }
        } fail:^(NSError *error) {
            NSLog(@"error = %@",error);
            [hud hideAnimated:YES];
        }];
    } cancelBlock:^{
        
    }];
}

// 跳转编辑
- (void)pushToEdit {
    if ([self.moreModel.Content containsString:@"class=\"zhundaoQQ\""]) {
        editViewController *editctr = [[editViewController alloc]init];
        editctr.urlString =[NSString stringWithFormat: @"%@Activity/PubActivity/%ld?accesskey=%@",zhundaoH5Api,(long)_moreModel.ID,accesskey];
        [self.navigationController pushViewController:editctr animated:YES];
    }
    else {
        postActivityViewController *post = [[postActivityViewController alloc]init];
        post.activityModel = self.moreModel;
        [self.navigationController pushViewController:post animated:YES];
    }
}

// 签到名单
- (void)signList
{
    if (_moreModel.HasJoinNum==0) {
        [ZDAlertView alertWithTitle:@"尚未有人参加" message:nil cancelBlock:nil];
    }
    else
    {
        ListViewController *list = [[ListViewController alloc]init];
        list.listID =_moreModel.ID;
        list.feeArray = [_moreModel.ActivityFees copy];
        list.userInfo = _moreModel.UserInfo;
        list.HasJoinNum = _moreModel.HasJoinNum;
        list.listName = _moreModel.Title;
        list.timeStart = _moreModel.TimeStart;
        list.address = _moreModel.Address;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:list animated:YES];
    }
}

// 活动截止
- (void)signEnd
{
    [ZDAlertView alertWithTitle:@"确定将活动截止?" message:@"确定后如要再次开启报名请通过编辑活动修改报名截止时间" sureBlock:^{
        NSString *urlstr = [NSString stringWithFormat:@"%@api/PerActivity/UnDueActivity?accessKey=%@&activityId=%li",zhundaoApi,accesskey,(long)_moreModel.ID];
        //    2017-01-09 19:27:20
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *Datastr = [format stringFromDate:date];
        //    NSDictionary *dic = @{@"TimeStop":Datastr};
        MBProgressHUD *hud = [[MBProgressHUD alloc]init];
        [self.view addSubview:hud];
        hud.animationType = MBProgressHUDAnimationFade;
        [hud showAnimated: YES];
        [ZD_NetWorkM getDataWithMethod:urlstr parameters:nil succ:^(NSDictionary *obj) {
            NSLog(@"设置成功");
            [hud hideAnimated:YES];
            MBProgressHUD *hud1 = [[MBProgressHUD alloc]init];
            hud1.mode = MBProgressHUDModeCustomView;
            hud1.label.text = @"设置成功";
            [self.view addSubview:hud1];
            hud1.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"签到打勾"]];
            [hud1 showAnimated:YES];
            [hud1 hideAnimated:YES afterDelay:1];
            Time *TimeStop = [Time bringWithTime:Datastr];
            _endTimeStr = [NSString stringWithFormat:@"报名截止 : %@", TimeStop.timeStr];
            [_collectionView reloadData];
        } fail:^(NSError *error) {
            [hud hideAnimated:YES];
            NSLog(@"error = %@",error);
        }];
    } cancelBlock:^{
        
    }];
}

// 咨询
- (void)consult {
    ConsultViewController *consult = [[ConsultViewController alloc]init];
    consult.acID = self.moreModel.ID;
    [self.navigationController pushViewController:consult animated:YES];
}

// 链接
- (void)link {
    UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
    [pastboard setString:[NSString stringWithFormat:@"%@event/%li",zhundaoH5Api,(long)_moreModel.ID]];
    [ZDAlertView alertWithTitle:@"已成功复制到粘贴板" message:nil cancelBlock:nil];
    NSLog(@"pastboardstr = %@",[NSString stringWithFormat:@"%@event/%li?accesskey=%@",zhundaoH5Api,(long)_moreModel.ID,accesskey]);
}

#pragma mark --- network
- (void)netWorkConsult{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/PstConsultList?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    NSDictionary *dic = @{@"Status":@"2",
                          @"ID":@(_moreModel.ID),
                          @"title":@"",
                          @"pageSize":@"10000",
                          @"curPage":@"1"};
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array = dic[@"Data"];
        if (array.count>0) {
            [_dataArray enumerateObjectsUsingBlock:^(moreModalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.moreMoalType == MoreMoalTypeConsult) {
                    obj.isRed = YES;
                    *stop = YES;
                }
            }];
            [_collectionView reloadData];
        }
    } fail:^(NSError *error) {
        
    }];
}

// 复制活动
- (void)copyActivity {
     MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"加载中...";
    NSString *url = [NSString stringWithFormat:@"%@api/v2/activity/copyActivity?token=%@&activityId=%li",zhundaoApi,[[SignManager shareManager] getToken],self.moreModel.ID];
    [ZD_NetWorkM postDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"复制成功" showAnimated:YES UIView:self.view imageName:@"签到打勾"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Load_Activity object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"复制活动失败"];
        [label labelAnimationWithViewlong:self.view];
    }];
}


@end
