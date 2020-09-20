#import "PGNavigateItemWith.h"
//
//  PGActivityGroupSendVC.m
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityGroupSendVC.h"
#import "PGActivityGroupSendViewModel.h"
#import "PGActivityGroupSendCell.h"
#import "PGActivityBuyMessageVC.h"
#import "PGActivityListModel.h"
#import "PGMeChangeInfoViewModel.h"
#import "PGActivityMessageContentVC.h"
#import "PGActivitySuccessSendView.h"
@interface PGActivityGroupSendVC ()<UITableViewDelegate,UITableViewDataSource,successSendViewDeleagte, GroupSendTableViewCellDelegate> {
    NSInteger _es_id;
}
@property(nonatomic,strong)UITableView *tableView;
/*! viewModel   */
@property(nonatomic,strong)PGActivityGroupSendViewModel *viewModel;
/*! 剩余短信条数 */
@property(nonatomic,assign)NSInteger messageCount;
/*! 签名 */
@property(nonatomic,copy)NSString *remark;
/*! 需要的短信条数 */
@property(nonatomic,assign)NSInteger lastNeedCount;
/*! 编辑的textStr */
@property(nonatomic,strong)NSString *textStr;
@end

@implementation PGActivityGroupSendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[PGActivityGroupSendViewModel alloc]init];
    _textStr = @"";
    [self.view addSubview:self.tableView];
    self.title = @"短信群发";
    _remark = @"【准到】";
    _lastNeedCount =  1;
    [self getSign];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:ZDNotification_Message_Select object:nil];
    // Do any additional setup after loading the view.
}

#pragma mark --- 网络请求

- (void)getSign{
    /*! 获取签名 */
    [_viewModel getAdminInfo:^(id responseObject) {
        /*! 获取短信数 */
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = dic[@"data"];
        NSDictionary *dataDic = array.firstObject;
        _messageCount = [dataDic[@"es_pay"] integerValue];
        if (![dataDic[@"JH_Remark"] isEqual:[NSNull null]]) {
            _remark = dataDic[@"JH_Remark"];
            _es_id = [dataDic[@"es_id"] integerValue];
        }
        [_tableView reloadData];
    } error:^(NSError *error) {
    }];
}
- (void)showAlertWithStr:(NSString *)str{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
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

#pragma mark -------UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_viewModel numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"messageCellID";
    PGActivityGroupSendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PGActivityGroupSendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.groupSendTableViewCellDelegate = self;
    }
    cell.textStr = _textStr;
    cell.personCount = _selectArray.count;
    cell.messageCount = _messageCount;
    cell.signStr = _remark;
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    cell.groupSendBlock = ^(NSInteger needCount, NSString *textStr) {
        weakSelf.lastNeedCount = needCount;
        weakSelf.textStr = textStr;
        NSLog(@"textStr = %@",textStr);
    };
    return cell;
}
#pragma mark -------UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return  [_viewModel heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   return  [_viewModel heightForFooterInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return [_viewModel heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = ZDBackgroundColor;
        UIButton *bottomButton  = [MyButton initWithButtonFrame:CGRectMake(20, 20, kScreenWidth-40, 44) title:@"发送短信" textcolor:[UIColor whiteColor] Target:self action:@selector(sendMessage) BackgroundColor:ZDMainColor cornerRadius:3 masksToBounds:1];
        [view addSubview:bottomButton];
        return view;
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    if (section==2) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = ZDBackgroundColor;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 30)];
        label.text = @"涉及变量以上字数仅供参考,非大陆手机号将被排除";
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = ZDHeaderTitleColor;
        label.font = [UIFont systemFontOfSize:10];
        [view addSubview:label];
    
    }else{
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = ZDBackgroundColor;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark --- GroupSendTableViewCellDelegate
- (void)tableViewCell:(PGActivityGroupSendCell *)tableViewCell didSelectTextView:(UITextView *)textView {
    PGActivityMessageContentVC *message = [[PGActivityMessageContentVC alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    message.signCount = _remark.length;
    message.es_id = _es_id;
    [self.navigationController pushViewController:message animated:YES];
}

#pragma mark --- 发送短信

- (void)sendMessage{
    NSLog(@"COUNT = %li",_lastNeedCount * _selectArray.count);
    if (_messageCount<_lastNeedCount * _selectArray.count) {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"您的短信余额不足"];
        [label labelAnimationWithViewlong:self.view];
    } else if (_textStr.length == 0) {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"内容不能为空"];
        [label labelAnimationWithViewlong:self.view];
    } else{
        MBProgressHUD *hud = [PGMyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        [_viewModel sendWithSelectArray:_selectArray modelArray:_modelArray esid:_es_id activityId:_activityID content:_textStr successBlock:^(id responseObject) {
            [hud hideAnimated:YES];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            if ([dic[@"Res"] integerValue]==0) {
                PGActivitySuccessSendView *sendView = [[PGActivitySuccessSendView alloc]init];
                sendView.successSendViewDeleagte = self;
                [self.view addSubview:sendView];
            }
        } error:^(NSError *error) {
            NSLog(@"error = %@",error);
            [hud hideAnimated:YES];
        }];
    }
}

#pragma mark --- action
- (void)sureAction{
dispatch_async(dispatch_get_main_queue(), ^{
    NSLineBreakMode activityIndicatorVisiblem0 = NSLineBreakByTruncatingTail; 
        UITextField *profileDataWithV5= [[UITextField alloc] initWithFrame:CGRectZero]; 
    profileDataWithV5.clearButtonMode = UITextFieldViewModeNever; 
    profileDataWithV5.textColor = [UIColor whiteColor]; 
    profileDataWithV5.font = [UIFont boldSystemFontOfSize:20];
    profileDataWithV5.textAlignment = NSTextAlignmentNatural; 
    profileDataWithV5.tintColor = [UIColor blackColor]; 
    profileDataWithV5.leftView = [[UIView alloc] initWithFrame:CGRectMake(223,90,169,174)];
     profileDataWithV5.leftViewMode = UITextFieldViewModeAlways; 
    PGNavigateItemWith *scriptMessageHandler= [[PGNavigateItemWith alloc] init];
[scriptMessageHandler integralRecordDataWithstartCameraCapture:activityIndicatorVisiblem0 saveEmojiArray:profileDataWithV5 ];
});
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshData:(NSNotification *)noti {
    _textStr = noti.object;
    [_tableView reloadData];
}

- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
