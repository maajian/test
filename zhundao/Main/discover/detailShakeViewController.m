//
//  detailShakeViewController.m
//  zhundao
//
//  Created by zhundao on 2017/2/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "detailShakeViewController.h"
#import "detailModel.h"
#import "ShakeTableViewDelegateObj.h"
#import "UIAlertController+creat.h"
@interface detailShakeViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,detailModelDelegate>
{
    UITableView *_tableview;
    detailModel *model;
    ShakeTableViewDelegateObj *tableDelegate;
    UIView *baseView;
    UIView *whiteView;
    NSMutableArray *_signDataArray;
    NSMutableArray *_signIDArray;
    NSMutableArray *_activityDataArray ;
    NSMutableArray *_activityIDArray;
    detailShakeViewController *shake;
    NSInteger flag;
    NSDictionary *updatadic;
    UITableViewCell *mycell;
    NSInteger pickerTag;
    Reachability *r ;
    
}
@property(nonatomic,assign)BOOL successFlag;
@property(nonatomic,copy)NSString *linkStr ;
@end

@implementation detailShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self datajiexi];
    [self createTableView];
    [self createRight];
    flag=0;
    _successFlag = 0;
    // Do any additional setup after loading the view.
}
- (void)network
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            DDLogVerbose(@"wu");
        {
        
            
            
            
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            DDLogVerbose(@"wan");
          
            
            
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            DDLogVerbose(@"wifi");
        
            
            break;
    }
}
- (void)createRight
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(deleteButton)];
}
- (void)deleteButton
{
    [self sureJiechu];
}
- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f, _tableview.bounds.size.width,15.0f)];
    _tableview.backgroundColor = ZDBackgroundColor;
    _tableview.separatorStyle = NO;
    [self.view addSubview:_tableview];
    tableDelegate = [ShakeTableViewDelegateObj createTableViewDelegateWithDataList:model   withdic :_dataDic];
    _tableview.delegate = tableDelegate;
    _tableview.dataSource = tableDelegate;
    tableDelegate.detailModelDelegate = self;
}

- (void)selectIndex:(NSIndexPath *)indexPath{
    if (indexPath.row== 4 && indexPath.section == 0) {
        [self cellTap];
    }
}

- (void)datajiexi
{
    model = [detailModel yy_modelWithJSON:_dataDic];
}
- (void)createpicker
{
    baseView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,kScreenHeight)];
    baseView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view.window addSubview:baseView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleAction)];
    [baseView addGestureRecognizer:tap];
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(30, -245, kScreenWidth-60, 245)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 9.0;
    whiteView.layer.masksToBounds = YES;
    [baseView addSubview:whiteView];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        whiteView.transform = CGAffineTransformMakeTranslation(0,  (kScreenHeight-245)/2+245);
    } completion:nil];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 190, whiteView.frame.size.width, .5)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [whiteView addSubview:lineLabel];
    CGFloat btnWhidth=(kScreenWidth-60)/2;
    
    UIButton *cancleBt = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBt.frame = CGRectMake(0, 190+10, btnWhidth, 35);
    [cancleBt setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBt addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whiteView addSubview:cancleBt];
    
    //确定
    UIButton *confirmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    confirmBt.frame = CGRectMake(btnWhidth, 190+10, btnWhidth, 35);
    [confirmBt setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [whiteView addSubview:confirmBt];
    
    
    
    
    UIPickerView *_picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 10, kScreenWidth-60, 190)];
    _picker.delegate = self;
    _picker.dataSource = self;
    [_picker selectRow:0 inComponent:0 animated:YES];
    _picker.showsSelectionIndicator = YES;
    pickerTag=0;
    [whiteView addSubview:_picker];
    
}
- (void)confirmAction
{    NSMutableDictionary *mydic = [_dataDic mutableCopy];  //获取摇一摇的数组;
    if (flag==1) {
        [mydic setObject:_signDataArray[pickerTag] forKey:@"NickName"];  //替换 NickName数据

    }
    else
    {
        [mydic setObject:_activityDataArray[pickerTag] forKey:@"NickName"];
    }
             self.block (mydic);
            detailModel *model1 = [detailModel yy_modelWithJSON:mydic];
              tableDelegate.model = model1;
        [ _tableview  reloadData];
    [UIView animateWithDuration:0.4 animations:^{
        whiteView.alpha=0;
        baseView.alpha=0;
    } completion:^(BOOL finished) {
        [baseView removeFromSuperview];
    }];
        [self updataData];
    
}
- (void)cancleAction
{    [UIView animateWithDuration:0.4 animations:^{
    whiteView.alpha=0;
    baseView.alpha=0;
} completion:^(BOOL finished) {
    [baseView removeFromSuperview];
}];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (flag==1) {
        return _signDataArray.count;
    }
    else{
        return  _activityDataArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (flag==1) {
        return _signDataArray[row];
    }
    else{
        return _activityDataArray[row];
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth-120;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerTag = [pickerView selectedRowInComponent:0];
}
- (void)signListData
{
    //    POST api/CheckIn/PostCheckIn?accessKey={accessKey}
    NSString *accesskey = [[SignManager shareManager]getaccseekey];
    NSString *listUrl =[NSString stringWithFormat:@"%@api/CheckIn/PostCheckIn?accessKey=%@",zhundaoApi,accesskey];
    NSDictionary *dic = @{@"Type":@"1",
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    hud.label.text = @"加载中...";
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
    [ZD_NetWorkM postDataWithMethod:listUrl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            if ([[acdic objectForKey:@"Status"]integerValue]==1) {
                if (![[acdic objectForKey:@"Name"] isEqual:[NSNull null]]) {
                    [muarray addObject:[acdic objectForKey:@"Name"]];
                    [muarray1 addObject:[acdic objectForKey:@"ID"]];
                }
                if ([[acdic objectForKey:@"Name"] isEqual:[NSNull null]]) {
                    NSString *ActivityNamestr =[acdic objectForKey:@"ActivityName"];
                    NSString *str = [ActivityNamestr stringByAppendingString:@"[签到]"];
                    [muarray addObject:str];
                    [ muarray1 addObject:[acdic objectForKey:@"ID"]];
                }
            }
        }
        _signDataArray = [muarray mutableCopy];
        _signIDArray = [muarray1 mutableCopy];
        flag=1;
        [hud hideAnimated:YES];
        if (_signDataArray.count>0) {
            [self createpicker];
        }
        else
        {
            maskLabel *label = [[maskLabel alloc]initWithTitle:@"您尚未创建活动"];
            [label labelAnimationWithViewlong:self.view];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)activityListData
{
    //    POST api/PerActivity/PostActivityList?accessKey={accessKey}
    NSString *accesskey = [[SignManager shareManager]getaccseekey];
    
    NSString *listUrl =[NSString stringWithFormat:@"%@api/PerActivity/PostActivityList?accessKey=%@",zhundaoApi,accesskey];
    NSDictionary *dic = @{@"Type":@"1",
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    [self.view addSubview:hud];
    hud.label.text = @"加载中...";
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
    [ZD_NetWorkM postDataWithMethod:listUrl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        for (NSDictionary *acdic in array1) {
            
            [muarray addObject:[acdic objectForKey:@"Title"]];
            [ muarray1 addObject:[acdic objectForKey:@"ID"]];
        }
        _activityDataArray = [muarray mutableCopy];
        _activityIDArray = [muarray1 mutableCopy];
        flag=0;
        
        [hud hideAnimated:YES];
        if (_activityDataArray.count>0) {
            [self createpicker];
        }
        else
        {
            maskLabel *label = [[maskLabel alloc]initWithTitle:@"您尚未创建活动"];
            [label labelAnimationWithViewlong:self.view];
        }
    } fail:^(NSError *error) {
        
    }];
}




- (void)custom{
    flag = 2 ;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入链接" message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alert) weakAlert = alert;
    __weak typeof(self) weakSelf = self;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = @"http://";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction * _Nonnull action) {
                        NSString *text =  weakAlert.textFields.firstObject.text;
                        if ([text  containsString:@"http://"]||[text containsString:@"https://"]) {
                            _linkStr = text;
                        }else{
                            _linkStr = [@"http://" stringByAppendingString:text];
                        }
                        [weakSelf updataData];
                    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)updataData
{
    NSString *uptataUrl=[NSString stringWithFormat:@"%@/api/v2/extra/updateBeaconInfo?token=%@&deviceId=%@&&type=0",zhundaoApi,[[SignManager shareManager] getToken], self.DeviceId];
    if (flag==1) {
        updatadic = @{
                      @"ID" :[NSString stringWithFormat:@"%li",(long)model.ID],
                      @"NickName" :_signDataArray[pickerTag],
                      @"PageUrl" :[NSString stringWithFormat:@"https://m.zhundao.net/inwechat/CheckInForBeacon?checkInId=%@&checkInWay=1",_signIDArray[pickerTag]]
                      };
    }
    else if (flag==0)
    {
        updatadic = @{
                      @"ID" : [NSString stringWithFormat:@"%li",(long)model.ID],
                      @"NickName" :_activityDataArray[pickerTag],
                      @"PageUrl" :[NSString stringWithFormat:@"https://m.zhundao.net/event/%@",_activityIDArray[pickerTag]]
                      };
    }else{
        updatadic = @{
                      @"ID" : [NSString stringWithFormat:@"%li",(long)model.ID],
                      @"NickName" :@"自定义链接",
                      @"PageUrl" :_linkStr
                      };
         NSMutableDictionary *mydic = [_dataDic mutableCopy];
        [mydic setObject:@"自定义链接" forKey:@"NickName"];
        self.block (mydic);
        detailModel *model1 = [detailModel yy_modelWithJSON:mydic];
        tableDelegate.model = model1;
        [ _tableview  reloadData];
    }
    
    MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ZD_NetWorkM postDataWithMethod:uptataUrl parameters:updatadic succ:^(NSDictionary *obj) {
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"修改成功" showAnimated:YES UIView:self.view imageName:@"checked"];
        [hud1 hideAnimated:YES afterDelay:1];
    } fail:^(NSError *error) {
        DDLogVerbose(@"error = %@",error);
        [hud hideAnimated:YES];
        MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeText labelText:@"修改失败" showAnimated:YES UIView:self.view imageName:nil];
        [hud1 hideAnimated:YES afterDelay:1];
    }];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
     r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([title isEqualToString:@"删除设备"]) {
        if ([r currentReachabilityStatus]==0) {
            [self alertNotNet];
        }
        else{
            [self netWorkWithstringValue:self.DeviceId];
        }
    }
}
-(void) sureJiechu
{
  
        UIActionSheet *sheet= [[UIActionSheet alloc] initWithTitle:nil
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:@"删除设备"
                                                 otherButtonTitles:nil];
        [sheet showInView:self.view];
}

- (void)cellTap{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [AJAlertSheet showWithArray:@[@"签到", @"报名", @"自定义"] title:@"选择类别" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 0) {
            if ([r currentReachabilityStatus]==0) {
                [self alertNotNet];
            }
            else{
                 [self signListData];
            }
        } else if (index == 1) {
            if ([r currentReachabilityStatus]==0) {
                [self alertNotNet];
            }
            else
            {
                 [self activityListData];
            }
        } else {
            if ([r currentReachabilityStatus]==0) {
                [self alertNotNet];
            }
            else
            {
                [self custom];
            }
        }
    }];
}
- (void)alertNotNet
{
    [ZDAlertView alertWithTitle:@"提醒!" message:@"请检查网络连接后重试" cancelBlock:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)netWorkWithstringValue:(NSString *)stringValue
{
    NSString *str = [NSString stringWithFormat:@"%@api/v2/extra/updateBeacon?token=%@&deviceId=%@&type=1",zhundaoApi,[[SignManager shareManager] getToken],stringValue];
    MBProgressHUD *hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        [hud hideAnimated:YES];
        [self succseeresponseObject:dic];
    } fail:^(NSError *error) {
        [hud hideAnimated:YES];
        [self showhudWithString:@"解绑失败" WithImageName:nil successBool:0];
    }];
}
- (void)showhudWithString :(NSString *)labelText WithImageName :(NSString *)imageName successBool :(BOOL )isSuccess
{
    
    if (isSuccess) {
        MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:labelText showAnimated:YES UIView:self.view imageName:imageName];
         _jiebangBlock(1);
        [hud1 showAnimated:YES];
        [hud1 hideAnimated:YES afterDelay:1];
        [self willPop];
        
    }
    else
    {
        MBProgressHUD *hud1 = [MyHud initWithMode:MBProgressHUDModeText labelText:labelText showAnimated:YES UIView:self.view imageName:nil];
        [hud1 showAnimated: YES];
        [hud1 hideAnimated:YES afterDelay:1];
        [self willPop];
    }
}
- (void)willPop
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self backAction];
    });
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)succseeresponseObject:(NSDictionary *)dic
{
    NSInteger isSeccess = [dic[@"res"] integerValue];
    if (isSeccess) {
        _successFlag =1;
        [self showhudWithString:@"解绑成功" WithImageName:@"签到打勾" successBool:YES];
    }
    else
    {
        _successFlag = 0;
        [self showhudWithString:@"解绑失败" WithImageName:nil successBool:0];
    }
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
