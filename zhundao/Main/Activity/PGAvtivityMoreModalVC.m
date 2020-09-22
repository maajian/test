#import "PGSwimingCommonSense.h"
//
//  PGAvtivityMoreModalVC.m
//  zhundao
//
//  Created by zhundao on 2017/2/16.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGAvtivityMoreModalVC.h"
#import "Time.h"
#import "PGActivityEditVC.h"
#import "PGActivityListVC.h"
#import "PGAvtivityCodeVC.h"
#import "PGAvtivityInviteVC.h"
#import "PGActivityDetailActivityVC.h"
#import "PGActivityConsultViewController.h"
#import <UShareUI/UShareUI.h>
#import "WXApi.h"
#import "PGAvtivityPostSignVC.h"
#import "PGAvtivityOneActivityVC.h"
#import "PGActivityPostActivityVC.h"
#import "PGAvtivitySignUpVC.h"
#import "PGDataPersonListVC.h"
#import "PGActivityPostEmailVC.h"

#import "PGAvtivityMoreModalModel.h"

#import "PGAvtivityMoreModalCell.h"
#import "PGAvtivityMoreModalHeaderView.h"
#import "PGStatisticsVC.h"

static const CGFloat itemSpace = 1;
static NSString *cellID = @"PGAvtivityMoreModalCell";
static NSString *headerID = @"PGAvtivityMoreModalHeaderView";

@interface PGAvtivityMoreModalVC ()<UICollectionViewDataSource, UICollectionViewDelegate, PGAvtivityMoreModalHeaderViewDelegate> {
    NSString *accesskey;
    NSString *_endTimeStr; // 截止时间
}
// 数据
@property (nonatomic, copy) NSArray<PGAvtivityMoreModalModel *> *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;


@end

@implementation PGAvtivityMoreModalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"model = %@",_moreModel);
    [self initSet];
    accesskey = [[PGSignManager shareManager]getaccseekey];
    if (!ZD_UserM.isAdmin) {
        [self networkForGetDataStatistics];
    }
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
        [_collectionView registerClass:[PGAvtivityMoreModalCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[PGAvtivityMoreModalHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
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
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *locationCollectionViewB8= [[UIView alloc] initWithFrame:CGRectZero]; 
    locationCollectionViewB8.backgroundColor = [UIColor whiteColor]; 
    locationCollectionViewB8.layer.cornerRadius = 
    locationCollectionViewB8.layer.masksToBounds = YES; 
        CGSize affineTransformRotateY3 = CGSizeZero;
    PGSwimingCommonSense *strokeCourseData= [[PGSwimingCommonSense alloc] init];
[strokeCourseData moviePlayTestWithattentionViewController:locationCollectionViewB8 pickerGroupTable:affineTransformRotateY3 ];
});
    self.title = @"活动管理";
    if (ZD_UserM.isAdmin) {
        _dataArray = @[[PGAvtivityMoreModalModel editModel],
                        [PGAvtivityMoreModalModel personListModel],
                        [PGAvtivityMoreModalModel PGActivityConsultModel],
                        [PGAvtivityMoreModalModel linkModel],
                        [PGAvtivityMoreModalModel applyEndModel],
                        [PGAvtivityMoreModalModel deleteModel],
                        [PGAvtivityMoreModalModel shareModel],
                        [PGAvtivityMoreModalModel inviteModel],
                        [PGAvtivityMoreModalModel qrcodeModel],
                        [PGAvtivityMoreModalModel copyModel],
                        [PGAvtivityMoreModalModel PGSignInSigninModel],
                        [PGAvtivityMoreModalModel statisticsModel],
        ];
    } else {
        _dataArray = @[ [PGAvtivityMoreModalModel personListModel],
                        [PGAvtivityMoreModalModel listOutputModel],
                        [PGAvtivityMoreModalModel dataPersonModel],
                        [PGAvtivityMoreModalModel linkModel],
                        [PGAvtivityMoreModalModel shareModel],
                        [PGAvtivityMoreModalModel qrcodeModel],
        ];
    }
    [self.view addSubview:self.collectionView];
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PGAvtivityMoreModalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.item];
    return cell;
}

#pragma mark --- UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PGAvtivityMoreModalHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        header.model = self.moreModel;
        header.endTime = _endTimeStr;
        header.headerViewDelegate = self;
        return header;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PGAvtivityMoreModalModel *model = _dataArray[indexPath.item];
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
            [[PGSignManager shareManager]shareImagewithModel:_moreModel withCTR:self Withtype:5 withImage:nil];
        }
            break;
        case MoreMoalTypeInvite: {
            PGAvtivityInviteVC *invite = [[PGAvtivityInviteVC alloc]init];
            invite.acid = _moreModel.ID;
            invite.model = self.moreModel;
            NSString *imagestr =   [NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)_moreModel.ID];
            invite.imageStr = imagestr ;
            [self presentViewController:invite animated:YES completion:nil];
        }
            break;
        case MoreMoalTypeQRCode: {
            ZDBlock_Str codeBlock = ^(NSString *str) {
                PGAvtivityCodeVC *code = [[PGAvtivityCodeVC alloc]init];
                NSString *imagestr =  str;
                code.imagestr = imagestr;
                code.titlestr = _moreModel.Title;
                code.labelStr = @"报名";
                [self presentViewController:code animated:YES completion:nil];
            };
            if (ZD_UserM.isAdmin) {
                codeBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)_moreModel.ID]);
            } else {
                [self networkForGetActivityLinkSuccess:^(NSString *obj) {
                    codeBlock(obj);
                }];
            }
        }
            break;
        case MoreMoalTypeSignin: {
            [self PGSign];
        }
            break;
        case MoreMoalTypeCopy: {
            [self copyActivity];
        }
            break;
        case MoreMoalTypeDataPerson: {
            PGDataPersonListVC *personList = [[PGDataPersonListVC alloc] init];
            personList.activityID = self.moreModel.ID;
            [self.navigationController pushViewController:personList animated:YES];
        }
            break;
        case MoreMoalTypeListOutput: {
            PGActivityPostEmailVC *post = [[PGActivityPostEmailVC alloc]init];
            post.activityID = self.moreModel.ID;
            [self.navigationController pushViewController:post animated:YES];
        }
            break;
        case MoreMoalTypeStatistics: {
            PGStatisticsVC *statistics = [[PGStatisticsVC alloc] init];
            statistics.moreModel = self.moreModel;
            [self.navigationController pushViewController:statistics animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark --- PGAvtivityMoreModalHeaderViewDelegate
// 跳转详情
- (void)header:(PGAvtivityMoreModalHeaderView *)headerView didTapDetailView:(UIView *)detailView {
    ZDBlock_Str detailBlock = ^(NSString *str) {
        PGActivityDetailActivityVC *detail = [[PGActivityDetailActivityVC alloc]init];
        detail.model =_moreModel;
        detail.urlString = str;
        [self.navigationController pushViewController:detail animated:YES];
    };
    
    if (ZD_UserM.isAdmin) {
        detailBlock([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)_moreModel.ID]);
    } else {
        [self networkForGetActivityLinkSuccess:^(NSString *obj) {
            detailBlock(obj);
        }];
    }
}

// 图表
- (void)header:(PGAvtivityMoreModalHeaderView *)headerView didTapChartView:(chartType)type {
    ZDBlock_Void pushPersonBlock = ^() {
        PGAvtivitySignUpVC *signUp = [[PGAvtivitySignUpVC alloc] init];
        signUp.activityId = _moreModel.ID;
        signUp.chartType = ChartTypeActivityPerson;
        [self.navigationController pushViewController:signUp animated:YES];
    };
    
    if (!ZD_UserM.isAdmin) {
//        pushPersonBlock();
        return;
    }
    
    switch (type) {
            //  报名
        case chartTypeApply: {
            pushPersonBlock();
        }
            break;
            // 收入
        case chartTypeIncome: {
            PGAvtivitySignUpVC *signUp = [[PGAvtivitySignUpVC alloc] init];
            signUp.activityId = _moreModel.ID;
            signUp.chartType = ChartTypePay;
            [self.navigationController pushViewController:signUp animated:YES];
        }
            break;
            // 浏览
        case chartTypeBrowse: {
            PGAvtivitySignUpVC *signUp = [[PGAvtivitySignUpVC alloc] init];
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
- (void)PGSign {
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *statusWithBlockA4= [[UIView alloc] initWithFrame:CGRectZero]; 
    statusWithBlockA4.backgroundColor = [UIColor whiteColor]; 
    statusWithBlockA4.layer.cornerRadius = 
    statusWithBlockA4.layer.masksToBounds = YES; 
        CGSize directionVerticalMovedw2 = CGSizeZero;
    PGSwimingCommonSense *tableViewCell= [[PGSwimingCommonSense alloc] init];
[tableViewCell moviePlayTestWithattentionViewController:statusWithBlockA4 pickerGroupTable:directionVerticalMovedw2 ];
});
    PGAvtivityOneActivityVC *one = [[PGAvtivityOneActivityVC alloc]init];
    one.acID = _moreModel.ID;
    one.activityName = _moreModel.Title;
    [self.navigationController pushViewController:one animated:YES];
}

// 删除活动
- (void)delelteActivity {
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *courseRecommendCellU7= [[UIView alloc] initWithFrame:CGRectZero]; 
    courseRecommendCellU7.backgroundColor = [UIColor whiteColor]; 
    courseRecommendCellU7.layer.cornerRadius = 
    courseRecommendCellU7.layer.masksToBounds = YES; 
        CGSize actualBadgeSuperU2 = CGSizeMake(48,48); 
    PGSwimingCommonSense *tweetViewModel= [[PGSwimingCommonSense alloc] init];
[tweetViewModel moviePlayTestWithattentionViewController:courseRecommendCellU7 pickerGroupTable:actualBadgeSuperU2 ];
});
    [PGAlertView alertWithTitle:@"确定删除活动?" message:@"删除后将不能恢复" sureBlock:^{
        MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        NSString *urlStr = [NSString stringWithFormat:@"%@api/v2/activity/deleteActivity?token=%@&activityId=%li",zhundaoApi,[PGSignManager shareManager].getToken,(long)_moreModel.ID];
        [ZD_NetWorkM postDataWithMethod:urlStr parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            NSLog(@"%@",dic);
            [hud hideAnimated:YES];
            if ([dic[@"Res"] integerValue]==0) {
                MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"删除成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
                [hud1 hideAnimated:YES afterDelay:1.5];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    _backBlock(1);   //1 表示删除
                });
            }else{
                PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:dic[@"Msg"]];
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
        PGActivityEditVC *editctr = [[PGActivityEditVC alloc]init];
        editctr.urlString =[NSString stringWithFormat: @"%@Activity/PubActivity/%ld?accesskey=%@",zhundaoH5Api,(long)_moreModel.ID,accesskey];
        [self.navigationController pushViewController:editctr animated:YES];
    }
    else {
        PGActivityPostActivityVC *post = [[PGActivityPostActivityVC alloc]init];
        post.activityModel = self.moreModel;
        [self.navigationController pushViewController:post animated:YES];
    }
}

// 签到名单
- (void)signList
{
    if (_moreModel.HasJoinNum==0) {
        [PGAlertView alertWithTitle:@"尚未有人参加" message:nil cancelBlock:nil];
    }
    else
    {
        PGActivityListVC *list = [[PGActivityListVC alloc]init];
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
    [PGAlertView alertWithTitle:@"确定将活动截止?" message:@"确定后如要再次开启报名请通过编辑活动修改报名截止时间" sureBlock:^{
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
            hud1.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_public_signin_check"]];
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
    PGActivityConsultViewController *consult = [[PGActivityConsultViewController alloc]init];
    consult.acID = self.moreModel.ID;
    [self.navigationController pushViewController:consult animated:YES];
}

// 链接
- (void)link {
    ZDBlock_Str block = ^(NSString *str) {
        UIPasteboard *pastboard = [UIPasteboard generalPasteboard];
        [pastboard setString:str];
        [PGAlertView alertWithTitle:@"已成功复制到粘贴板" message:nil cancelBlock:nil];
    };
    if (ZD_UserM.isAdmin) {
        block([NSString stringWithFormat:@"https://m.zhundao.net/eventjt/{%li}/0",(long)_moreModel.ID]);
    } else {
        [self networkForGetActivityLinkSuccess:^(NSString *obj) {
            block(obj);
        }];
    }
}

#pragma mark --- network
- (void)netWorkConsult{
    NSString *url = [NSString stringWithFormat:@"%@api/PerBase/PstConsultList?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
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
            [_dataArray enumerateObjectsUsingBlock:^(PGAvtivityMoreModalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
// 获取数据统计
- (void)networkForGetDataStatistics {
    ZD_HUD_SHOW_WAITING
    ZD_WeakSelf
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetActivityDepartDate",
                          @"Data" : @{
                                  @"ActivityId": @(self.moreModel.ID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        weakSelf.moreModel.total = ZD_SafeIntValue(obj[@"data"][@"total"]);
        weakSelf.moreModel.yesterday = ZD_SafeIntValue(obj[@"data"][@"yesterday"]);
        weakSelf.moreModel.today = ZD_SafeIntValue(obj[@"data"][@"today"]);
        [weakSelf.collectionView reloadData];
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}
- (void)networkForGetActivityLinkSuccess:(ZDBlock_Str)success {
    ZD_HUD_SHOW_WAITING
    NSString *url = [NSString stringWithFormat:@"%@jinTaData?token=%@", zhundaoLogApi, ZD_UserM.token];
    NSDictionary *dic = @{@"BusinessCode": @"GetActivityLink",
                          @"Data" : @{
                                  @"ActivityId": @(self.moreModel.ID),
                         }
    };
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        ZD_HUD_DISMISS
        ZDDo_Block_Safe_Main1(success, obj[@"data"])
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}

// 复制活动
- (void)copyActivity {
     MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    hud.label.text = @"加载中...";
    NSString *url = [NSString stringWithFormat:@"%@api/v2/activity/copyActivity?token=%@&activityId=%li",zhundaoApi,[[PGSignManager shareManager] getToken],self.moreModel.ID];
    [ZD_NetWorkM postDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"复制成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
        [hud1 hideAnimated:YES afterDelay:1.5];
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDNotification_Load_Activity object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"复制活动失败"];
        [label labelAnimationWithViewlong:self.view];
    }];
}


@end
