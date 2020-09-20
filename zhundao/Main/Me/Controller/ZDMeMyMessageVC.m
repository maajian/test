//
//  ZDMeMyMessageVC.m
//  zhundao
//
//  Created by zhundao on 2017/11/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDMeMyMessageVC.h"
#import "ZDMeMyMessageView.h"
#import "ZDActivityBuyMessageVC.h"
#import "ZDActivityGroupSendViewModel.h"
#import "ZDMeSendMessageDetailVC.h"

@interface ZDMeMyMessageVC ()<ZDMeMyMessageViewDelegate>
/*! 视图 */
@property(nonatomic,strong)ZDMeMyMessageView *messageView;
/*! 用户ID */
@property(nonatomic,assign)NSInteger es_id ;

@end

@implementation ZDMeMyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的短信";
    [self rightButton];
    [self.view addSubview:self.messageView];
    // Do any additional setup after loading the view from its nib.
}

- (ZDMeMyMessageView *)messageView{
    if (!_messageView) {
        _messageView = [[ZDMeMyMessageView alloc]init];
        _messageView.ZDMeMyMessageViewDelegate = self;
    }
    return _messageView;
}


#pragma mark --- ZDMeMyMessageViewDelegate

- (void)payMessage{
    if ([_userDic[@"PayPassWord"] isEqual:[NSNull null]]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先前往我的钱包设置支付密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else{
        ZDActivityBuyMessageVC *buy = [[ZDActivityBuyMessageVC alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        buy.userDic = _userDic;
        [self.navigationController pushViewController:buy animated:YES];
    }
}

- (void)backpop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)allQues{
    ZDBaseWebViewVC *questionVC = [[ZDBaseWebViewVC alloc] init];
    questionVC.webTitle = @"常见问题";
    questionVC.urlString = @"https://www.zhundao.net/service/help/index/68";
    questionVC.isClose = YES;
    [self.navigationController pushViewController:questionVC animated:YES];
}

#pragma mark --- 获取短信条数

- (void)getMessage{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    ZDActivityGroupSendViewModel *viewModel = [[ZDActivityGroupSendViewModel alloc]init];
    [viewModel openMessage:^(id responseObject) {
        
        /*! 获取短信条数 */
         NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/GetAdminInfo?token=%@",zhundaoMessageApi,[[ZDSignManager shareManager] getToken]];
        [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            NSArray *array = dic[@"data"];
            NSDictionary *dataDic = array.firstObject;
            NSInteger messageCount = [dataDic[@"es_pay"] integerValue];
            _es_id = [dataDic[@"es_id"] integerValue];
            _messageView.countLabel.text = [NSString stringWithFormat:@"%li",messageCount];
            [indicator stopAnimating];
        } fail:^(NSError *error) {
            [[ZDSignManager shareManager]showNotHaveNet:self.view];
            [indicator stopAnimating];
        }];
    } error:^(NSError *error) {
        [[ZDSignManager shareManager]showNotHaveNet:self.view];
        [indicator stopAnimating];
    }];
}
#pragma mark --- 右边明细

-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(messageDetail)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)messageDetail{
    ZDBaseWebViewVC *questionVC = [[ZDBaseWebViewVC alloc] init];
    questionVC.webTitle = @"发送记录";
    questionVC.urlString = [NSString stringWithFormat:@"https://sms.zhundao.com.cn/wx/ios/%li#/outbox",_es_id];
    questionVC.isClose = YES;
    [self.navigationController pushViewController:questionVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMessage];
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
