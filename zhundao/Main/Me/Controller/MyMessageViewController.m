//
//  MyMessageViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageView.h"
#import "BuyMessageViewController.h"
#import "GroupSendViewModel.h"
#import "sendMessageDetailViewController.h"
#import "MessageContentViewController.h"

@interface MyMessageViewController ()<MyMessageViewDelegate>
/*! 视图 */
@property(nonatomic,strong)MyMessageView *messageView;
/*! 用户ID */
@property(nonatomic,assign)NSInteger es_id ;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的短信";
    [self rightButton];
    [self.view addSubview:self.messageView];
    // Do any additional setup after loading the view from its nib.
}

- (MyMessageView *)messageView{
    if (!_messageView) {
        _messageView = [[MyMessageView alloc]init];
        _messageView.MyMessageViewDelegate = self;
    }
    return _messageView;
}


#pragma mark --- MyMessageViewDelegate

- (void)payMessage{
    if ([_userDic[@"PayPassWord"] isEqual:[NSNull null]]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先前往我的钱包设置支付密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else{
        BuyMessageViewController *buy = [[BuyMessageViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        buy.userDic = _userDic;
        [self.navigationController pushViewController:buy animated:YES];
    }
}

- (void)backpop{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)allQues{
    ZDWebViewController *questionVC = [[ZDWebViewController alloc] init];
    questionVC.webTitle = @"常见问题";
    questionVC.urlString = @"https://www.zhundao.net/service/help/index/68";
    questionVC.isClose = YES;
    [self.navigationController pushViewController:questionVC animated:YES];
}
- (void)showModel {
    NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/GetAdminInfo?token=%@",zhundaoMessageApi,[[SignManager shareManager] getToken]];
    __block NSString *remark = @"【准到】";
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        DDLogVerbose(@"responseObject = %@",obj );
        /*! 获取短信数 */
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array = dic[@"data"];
        NSDictionary *dataDic = array.firstObject;
        if (![dataDic[@"JH_Remark"] isEqual:[NSNull null]]) {
            remark = dataDic[@"JH_Remark"];
            _es_id = [dataDic[@"es_id"] integerValue];
        }
        MessageContentViewController *message = [[MessageContentViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        message.signCount = remark.length;
        message.es_id = _es_id;
        [self.navigationController pushViewController:message animated:YES];
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR(error)
    }];
}

#pragma mark --- 获取短信条数

- (void)getMessage{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    GroupSendViewModel *viewModel = [[GroupSendViewModel alloc]init];
    [viewModel openMessage:^(id responseObject) {
        
        /*! 获取短信条数 */
         NSString *str = [NSString stringWithFormat:@"%@api/CoreByAccessKey/GetAdminInfo?token=%@",zhundaoMessageApi,[[SignManager shareManager] getToken]];
        [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
            NSArray *array = dic[@"data"];
            NSDictionary *dataDic = array.firstObject;
            NSInteger messageCount = [dataDic[@"es_pay"] integerValue];
            _es_id = [dataDic[@"es_id"] integerValue];
            _messageView.countLabel.text = [NSString stringWithFormat:@"%li",messageCount];
            [indicator stopAnimating];
        } fail:^(NSError *error) {
            [[SignManager shareManager]showNotHaveNet:self.view];
            [indicator stopAnimating];
        }];
    } error:^(NSError *error) {
        [[SignManager shareManager]showNotHaveNet:self.view];
        [indicator stopAnimating];
    }];
}
#pragma mark --- 右边明细

-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"明细" style:UIBarButtonItemStylePlain target:self action:@selector(messageDetail)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDGreenColor};
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)messageDetail{
    ZDWebViewController *questionVC = [[ZDWebViewController alloc] init];
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
