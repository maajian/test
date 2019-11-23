//
//  MeViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/2.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MyWalletViewController.h"
#import "ContactViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "UpDataViewController.h"
#import "NoticeViewController.h"
#import "NoticeViewModel.h"
#import "Time.h"
#import "PersonInfoViewController.h"
#import "MyMessageViewController.h"
@interface MeViewController ()
{
    NSString *uidstr;
    NSDictionary *userdic ;
    NSString *acc;
    NSString *phonestr;
}
/*! 手机号码 */
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
/*! 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/*! 名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/*! 通知公告 */
@property (weak, nonatomic) IBOutlet UITableViewCell *noticeCell;
/*! 钱包 */
@property (weak, nonatomic) IBOutlet UITableViewCell *myWalletCell;
/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UITableViewCell *suggestCell;
/*! tableview */
@property (strong, nonatomic) IBOutlet UITableView *tableview;
/*! vip标签 */
@property (weak, nonatomic) IBOutlet UILabel *VIPlabel;
/*! 通讯录 */
@property (weak, nonatomic) IBOutlet UITableViewCell *listCell;
/*! NoticeViewModel */
@property(nonatomic,strong)NoticeViewModel *noticeVM;
/*! 个人信息 */
@property (weak, nonatomic) IBOutlet UITableViewCell *infoCell;
/*! 短信 */
@property (weak, nonatomic) IBOutlet UITableViewCell *messageCell;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, _tableview.bounds.size.width,15.0f)];
    _tableview.backgroundColor = zhundaoBackgroundColor;
    uidstr = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    [self setVIP];
    
    SignManager *manager = [SignManager shareManager];
     acc =  [manager getaccseekey];
     [self setGestureRecognizer];
    _iconImageView.layer.cornerRadius = 33;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.borderColor =  zhundaoBackgroundColor.CGColor;
}

#pragma mark ---懒加载 
- (NoticeViewModel *)noticeVM{
    if (!_noticeVM) {
        _noticeVM = [[NoticeViewModel alloc]init];
    }
    return _noticeVM;
}

#pragma mark VIP
- (void)setVIP
{
    _VIPlabel.layer.cornerRadius = 6;
    _VIPlabel.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updataVIP)];
    _VIPlabel.userInteractionEnabled = YES;
    [_VIPlabel addGestureRecognizer:tap];
    
}
- (void)updataVIP
{
    UpDataViewController *updata = [[UpDataViewController alloc]init];
    updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[SignManager shareManager] getaccseekey]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:updata animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
#pragma mark -----跳转
- (void)setGestureRecognizer
{
    UITapGestureRecognizer *contacttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showsuggest)];
    [_suggestCell addGestureRecognizer:contacttap];
    
    UITapGestureRecognizer *walletTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushWallet)];
    [_myWalletCell addGestureRecognizer:walletTap];
    UITapGestureRecognizer *listTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushList)];
    [_listCell addGestureRecognizer:listTap];
    UITapGestureRecognizer *noticeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushNotice)];
    [_noticeCell addGestureRecognizer:noticeTap];
    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushChangeInfo)];
    [_infoCell addGestureRecognizer:infoTap];
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushMessage)];
    [_messageCell addGestureRecognizer:messageTap];
}

- (void)pushMessage{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"GradeId"] integerValue]>1) {
        MyMessageViewController *message = [[MyMessageViewController alloc]init];
        message.userDic = userdic;
        [self setHidesBottomBarWhenPushed: YES];
        [self.navigationController pushViewController:message animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该功能仅限V2以上会员使用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)pushChangeInfo{
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"个人信息";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"%@/Activity/UserEdit?token=%@",zhundaoH5Api,[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)pushList
{
    ContactViewController *contact = [[ContactViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:contact animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)showsuggest
{
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的工单";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Extra/TicketMain?token=%@",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)pushWallet {
    ZDWebViewController *web = [[ZDWebViewController alloc] init];
    web.webTitle = @"我的钱包";
    web.isClose = YES;
    web.urlString = [NSString stringWithFormat:@"https://m.zhundao.net/Activity/MyWallet?token=%@",[[SignManager shareManager] getToken]];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:web animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

/*! 通知公告 */
- (void)pushNotice {
    NoticeViewController *notice = [[NoticeViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:notice animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
#pragma mark 获取信息
- (void)getuser {
        NSString *userstr = [NSString stringWithFormat:@"%@api/v2/user/getUserInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:userstr parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"errcode"] integerValue] == 0) {
            userdic = [obj[@"data"] copy];
            // 头像
            NSString *headImgUrl = userdic[@"headImgUrl"] ? userdic[@"headImgUrl"] : @"";
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:headImgUrl] placeholderImage:[UIImage imageNamed:@"user.png"]];
            // 等级
            [[NSUserDefaults standardUserDefaults]setObject:userdic[@"gradeId"] forKey:@"GradeId"];
            _VIPlabel.text = [NSString stringWithFormat:@"V%@",userdic[@"gradeId"]];
            
            // 手机号码
            NSString *mobile = userdic[@"phone"] ? userdic[@"phone"] : @"";
            [[ NSUserDefaults  standardUserDefaults]setObject:mobile forKey:@"mobile"];
            _phoneLabel.text = [NSString stringWithFormat:@"准到ID: %@",userdic[@"id"]];
            
            // 姓名
            NSString *nickName = userdic[@"nickName"] ?  userdic[@"nickName"] : @"";
            _nameLabel.text = nickName;
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if ([[ NSUserDefaults standardUserDefaults]objectForKey:ZDUserDefault_Network_Line]) {
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:ZDUserDefault_Network_Line];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                } else {
                    [[NSUserDefaults standardUserDefaults]setObject:@"备用线路" forKey:ZDUserDefault_Network_Line];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                [self getuser];
            });
        });
    }];
}

- (void)getAuth {
    NSString *str = [NSString stringWithFormat:@"%@api/v2/user/getAuthInfo?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] integerValue] == 1) {
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Authentication"];
            
            NSMutableDictionary *authdic = [obj[@"data"] mutableCopy];
            NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:obj[@"data"]];
            for (NSString *key in tempDic.allKeys) {
                if ([[tempDic objectForKey:key] isEqual:[NSNull null]]) {
                    [authdic setObject:@"" forKey:key];
                }else{}
            }
            NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"auth.plist"];
            BOOL issuccess = [authdic writeToFile:path atomically:YES];
            if (issuccess) {
                NSLog(@"写入成功");
            }
        } else {
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Authentication"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark 通知公告小红点


/*! 是否显示小红点 */
- (void)isShowRed {
    [self removeLayer];
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeTime"];
    if (array) {
       return  [self getNotice:array];
    }else{
        [self createShape];
    }
}
/*! 移除CAShapeLayer */
- (void)removeLayer {
    [_noticeCell.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]]) {
            [obj removeFromSuperlayer];
            *stop = YES;
        }
    }];
}
/*! 创建CAShapeLayer */
- (void)createShape {
    CAShapeLayer *shape = [CAShapeLayer layer];
    /*! 内切圆 */
    CGFloat x = kScreenWidth -40 ;
    CGFloat y = 17;
    CGFloat width = 10 ;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x, y, width, width)];
    shape.path = bezierPath.CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    [_noticeCell.layer addSublayer:shape];
}
/*! 判断是非存在ID ，不存在则创建layer */
- (void)getNotice :(NSArray *)localArray {
    __weak typeof(self) weakself = self;
    [self.noticeVM netWorkWithPage:0 Block:^(NSArray *array) {
        for (NSDictionary *dic in array) {
            NSString *time = dic[@"AddTime"] ;
            Time *nowTime1 = [Time bringWithTime:time];
            NSString *lastStr =  [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeTime"];
            NSDateFormatter *dataFormatter =   [[NSDateFormatter alloc]init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSTimeInterval lastTime = [[dataFormatter dateFromString:lastStr] timeIntervalSince1970];
            NSTimeInterval nowTime = [[dataFormatter dateFromString:nowTime1.timeStr] timeIntervalSince1970];
            if (nowTime >lastTime) {
                [weakself createShape];
            }break;
        }
    }];
}


#pragma mark ------生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getuser];
    [self getAuth];
    [self isShowRed];
    [MobClick beginLogPageView:self.navigationItem.title];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.navigationItem.title];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
