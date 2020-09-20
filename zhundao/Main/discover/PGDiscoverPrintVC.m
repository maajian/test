#import "PGOrderWithPayment.h"
//
//  PGDiscoverPrintVC.m
//  zhundao
//
//  Created by zhundao on 2017/6/29.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverPrintVC.h"
#import "PGDiscoverPrintVM.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "TscCommand.h"
#import "PGDiscoverXYVC.h"
#import "AppDelegate.h"
#import "BLKWrite.h"
#import "GZActionSheet.h"
#import "PGDiscoverGetCodeVC.h"
#import "PGDiscoverChooseCustomVC.h"
@interface PGDiscoverPrintVC ()<UITableViewDelegate ,UITableViewDataSource,XYdelegate>
@property(nonatomic,strong)        UITableView   *tableView ;
@property(nonatomic,strong)        UISwitch      *printSwitch ;
@property(nonatomic,strong)        PGDiscoverPrintVM        *ViewModel;
@property (strong , nonatomic)     CBCentralManager *manager;//中央设备
//@property(nonatomic,strong)        NSArray *sizeArray ;  //尺寸数组
@property(nonatomic,strong)        NSArray *modelArray ;  //模版数组
@property(nonatomic,strong)        NSArray *activeArray ;  //触发模式数组
@property(nonatomic,strong)        NSArray *headerArray ;  // 头数组
@property(nonatomic,strong)       NSMutableArray *sizeSelArray ; //尺寸bool数组 显示是否大勾
@property(nonatomic,strong)       NSMutableArray *modelSelArray ;// 模版bool数组
@property(nonatomic,strong)       NSMutableArray *activeSelArray ;// 触发模版bool数组
@property(nonatomic,assign)       BOOL isPrint ;
@property(nonatomic,copy)         NSString       *chooseStr ;   //打印设备选择标题字符串
@property(nonatomic,copy)       NSString      *offsetX;
@property(nonatomic,copy)       NSString      *offsetY;
@end

@implementation PGDiscoverPrintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    // Do any asdditional setup after loading the view.
}
#pragma mark 基础配置 
- (void)baseSetting
{

    [self createRightButton];
     _ViewModel = [[PGDiscoverPrintVM alloc]init];
//    self.sizeArray = @[@"小",@"中",@"大"];
    self.modelArray = @[@"二维码",@"二维码 + 姓名",@"纯文本",@"二维码 + 备注"];
    self.activeArray = @[@"签到成功",@"手动"];
    self.headerArray = @[@"",@"选择打印设备前，请先开启蓝牙",@"模版",@"触发模式"];
//    self.sizeSelArray = [[_ViewModel getSize] mutableCopy];
    self.modelSelArray= [[_ViewModel getModel]mutableCopy];
    self.activeSelArray = [[_ViewModel getActive]mutableCopy];
    self.offsetX = [_ViewModel getOffsetX];
    self.offsetY = [_ViewModel getOffsetY];
    self.isPrint = [_ViewModel getFlag];
    _chooseStr = @"打印设备选择";
    [self.view addSubview:self.tableView];
}
#pragma mark 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self ;
        _tableView.dataSource =self;
        _tableView.rowHeight = 44 ;
        _tableView.backgroundColor = ZDBackgroundColor ;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UISwitch *)printSwitch
{
    if (!_printSwitch) {
        _printSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-60, 6, 60, 44)];
        [_printSwitch setOn:_isPrint];
        [_printSwitch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    return _printSwitch;
}
#pragma mark UITableViewDataSource 必写代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) return 1;
//    else if (section==2) return 3 ;
    else if (section==2) return 4 ;
    else if (section==3) return 2;
    else return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString *printID = @"printID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:printID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:printID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tintColor = ZDMainColor;
    }
    if (indexPath.section==0) {
        cell.textLabel.text = @"开启打印";
        [cell.contentView addSubview:self.printSwitch];
    }
    if (indexPath.section==1) {
        if (indexPath.row ==0) {
            cell.textLabel.text = _chooseStr;
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"打印调试 : x = %@ ,y = %@",_offsetX,_offsetY];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    if (indexPath.section==2) {
//        cell.textLabel.text = _sizeArray[indexPath.row];
//        if ([_sizeSelArray[indexPath.row] integerValue]) cell.accessoryType = UITableViewCellAccessoryCheckmark;
//      
//    }
    if (indexPath.section==2) {
        cell.textLabel.text = _modelArray[indexPath.row];
        if ([_modelSelArray[indexPath.row] integerValue]) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    if (indexPath.section == 3) {
        cell.textLabel.text = _activeArray[indexPath.row];
        if ([_activeSelArray[indexPath.row] integerValue]) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}



#pragma mark UITableViewDelegate 选写代理

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = [UIColor clearColor];
    if (![_headerArray[section] isEqualToString:@""]) {
        UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, kScreenWidth, 30) Text:_headerArray[section] textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
        [view addSubview:label];
        return view;
    }else
    {
        view.frame = CGRectMake(0, 0, kScreenWidth, 20);
        return view;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==3) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = [UIColor clearColor];
//        UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 44) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(sureAction) BackgroundColor:ZDMainColor cornerRadius:5 masksToBounds:YES];
//        [view addSubview:button];
        return view;
    }
    else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==4) {
        return 50.0;
    }else{
        return 0.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }else{
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==1) {
        if (indexPath.row==0) [self pushToChoose];
        if (indexPath.row==1) [self setPrintXY];
        return;
    }
//   else if(indexPath.section==2) {
//        [_ViewModel checkWithboolArray:_sizeSelArray tableView:tableView section:2];
//        [_ViewModel changeArray:_sizeSelArray row:indexPath.row];
//        [[NSUserDefaults standardUserDefaults]setObject:_sizeSelArray forKey:@"sizeArray"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
   else if (indexPath.section==2)
    {
        [_ViewModel checkWithboolArray:_modelSelArray tableView:tableView section:2];
        [_ViewModel changeArray:_modelSelArray row:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:_modelSelArray forKey:@"modelSelArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if (indexPath.row==2||indexPath.row==3) {
            PGDiscoverChooseCustomVC *choose = [[PGDiscoverChooseCustomVC alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"printArray"]) {
                choose.nowDataArray =[[[NSUserDefaults standardUserDefaults]objectForKey:@"printArray"]copy];
            }
            [self.navigationController pushViewController:choose animated:YES];
            choose.block = ^(NSArray *array) {
                [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"printArray"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            };
        }else{}
    }else if (indexPath.section==3)
    {
        [_ViewModel checkWithboolArray:_activeSelArray tableView:tableView section:4];
        [_ViewModel changeArray:_activeSelArray row:indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:_activeSelArray forKey:@"activeSelArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        return;
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
}

#pragma mark ------纯文本选择

#pragma mark 右侧导航栏 
- (void)createRightButton
{
    [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(showa)];
}

- (void)showa
{
    NSArray *array = @[@"测试打印",@"扫码打印"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:10 andShowCancel:YES];
    // 2. Block 方式
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        
        if (index==1) {   //测试打印
             [_ViewModel printQRCode:@"m819993" name:@"准到科技" isPrint:YES offsetx:[_offsetX intValue] offsety:[_offsetY intValue]];
            
        }
        if (index==2) {
            PGDiscoverGetCodeVC *getcode = [[PGDiscoverGetCodeVC alloc]init];
            getcode.offsetX = _offsetX;
            getcode.offsetY = _offsetY;
            [self presentViewController:getcode animated:YES completion:nil];
        }
    };
    [self.view.window addSubview:sheet];
    
}

#pragma mark 开关改变事件
- (void)switchChange
{
    self.isPrint = !_isPrint;
     [[NSUserDefaults standardUserDefaults]setBool:_isPrint forKey:@"printFlag"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma  mark 跳转选择蓝牙
                                       
- (void)pushToChoose
{
    [self setHidesBottomBarWhenPushed:YES];
    [[BLKWrite Instance] setBWiFiMode:NO];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.navigationController pushViewController:dele.mConnBLE animated:YES];
}

#pragma mark 跳转设置偏移值
- (void)setPrintXY
{
    PGDiscoverXYVC *xy = [[PGDiscoverXYVC alloc]init];
    xy.delegate = self;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:xy animated:YES];
}
#pragma mark XYdelegate
- (void)backWithX:(NSString *)offsetx y:(NSString *)offsety
{
    self.offsetX = offsetx;
    self.offsetY = offsety;
    [_tableView reloadData];
}







- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    NSRange progressTypeDefaultN6 = NSMakeRange(4,96); 
        NSString *photosDelegateWithv1 = @"updateStatuOptional";
    PGOrderWithPayment *mutableParagraphStyle= [[PGOrderWithPayment alloc] init];
[mutableParagraphStyle pg_weekTimeIntervalWithcourseScrollView:progressTypeDefaultN6 mainMessageView:photosDelegateWithv1 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
