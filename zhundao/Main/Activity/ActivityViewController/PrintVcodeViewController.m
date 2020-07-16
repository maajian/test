//
//  PrintVcodeViewController.m
//  zhundao
//
//  Created by zhundao on 2017/7/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PrintVcodeViewController.h"
#import "PrintVcodeTableViewCell.h"
#import "PrintVcodeModel.h"
#import "PrintVM.h"
#import "printView.h"
#import "PrintVcodeVM.h"
@interface PrintVcodeViewController () <UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView      *tableView ;

@property(nonatomic,strong) PrintVcodeVM    *VM;
@end

@implementation PrintVcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    // Do any additional setup after loading the view.
}

#pragma mark ----- 基础设置 
- (void)baseSetting
{
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = ZDBackgroundColor;
    
}

#pragma mark ---- 懒加载 

- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.rowHeight = 60 ;
        
        [_tableView registerNib:[UINib nibWithNibName:@"PrintVcodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"printID"];
    }
    return _tableView;
}
- (PrintVcodeVM *)VM
{
    if (!_VM) {
        _VM = [[PrintVcodeVM alloc]init];
    }
    return _VM;
}
#pragma mark -----   UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *printID = @"printID";
    PrintVcodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:printID];
    if (!cell) {
        cell = [[PrintVcodeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:printID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _modelArray[indexPath.row];
    [cell.pOneButton addTarget:self action:@selector(printOne:) forControlEvents:UIControlEventTouchUpInside];
    [cell.pMoreButton addTarget:self action:@selector(printMore:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark  ------  UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 30)];
    label.textColor = ZDHeaderTitleColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"使用前，请蓝牙连接打印机";
    [view addSubview:label];
    return view;
}

#pragma mark ------- 打印一个二维码 

- (void)printOne:(UIButton *)button
{
    PrintVcodeTableViewCell *cell =(PrintVcodeTableViewCell *)button.superview.superview;
    PrintVM *printvm = [[PrintVM alloc]init];
    NSArray *modelselArray = [printvm getModel];
    NSInteger index = [modelselArray indexOfObject:@"1"];
    int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
    int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
     NSArray *nameArray = [self.VM getNameArray];
    if (index ==0) {  //打印二维码
        [printvm printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
     }else if(index ==1){  //打印二维码加姓名
        [printvm printQRCode:cell.model.VCode name:cell.model.UserName isPrint:YES offsetx:offsetx offsety:offsety];
    }else if(index ==2){
        //打印纯文本
        NSMutableArray *printArray =  [[_VM getID:nameArray model:cell.model] copy];
        [printvm printTextIsPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
    }else{
        NSMutableArray *printArray =  [[_VM getID:nameArray model:cell.model] copy];
        [printvm printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
    }
    [self postPrintLogWithModel:cell.model];
}
#pragma mark -------打印多个二维码

- (void)printMore : (UIButton *)button
{
    
    PrintVcodeTableViewCell *cell =(PrintVcodeTableViewCell *)button.superview.superview;
    printView *view = [[printView alloc]initWithFirstIndex:cell.model.count];
    [self.view addSubview:view];
    [view comeIn];
    view.block = ^(int begin,int end) {
        PrintVM *printvm = [[PrintVM alloc]init];
        NSArray *modelselArray = [printvm getModel];
        NSInteger index = [modelselArray indexOfObject:@"1"];
        int offsetx = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printX"] intValue];
        int offsety = [[[NSUserDefaults standardUserDefaults]objectForKey:@"printY"] intValue];
        if (end>_modelArray.count) {
            end = (int) _modelArray.count;
        }
        NSArray *nameArray = [self.VM getNameArray];
        @autoreleasepool {
            
            for (int i = begin-1 ; i <end; i++) {
                listModel *model = (listModel *)_modelArray[_modelArray.count-i-1];
                
                if (index ==0) {  //打印二维码
                    [printvm printQRCode:model.VCode isPrint:YES offsetx:offsetx offsety:offsety];
                }else if(index ==1){  //打印二维码加姓名
                    [printvm printQRCode:model.VCode name:model.UserName isPrint:YES offsetx:offsetx offsety:offsety];
                }
                else if(index ==2){
                    //打印纯文本
                   NSMutableArray *printArray =  [[_VM getID:nameArray model:model] copy];
                [printvm printTextIsPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
                }else{
                    NSMutableArray *printArray =  [[_VM getID:nameArray model:model] copy];
                    [printvm printQRCode:cell.model.VCode isPrint:YES offsetx:offsetx offsety:offsety textArray:printArray];
                }
                [self postPrintLogWithModel:model];
            }
        }
        
    };
}

- (void)postPrintLogWithModel:(listModel *)model {
    NSString *urlStr = [NSString stringWithFormat:@"%@zhundao2b?token=%@", zhundaoLogApi,[[ZDDataManager shareManager] getToken]];
    NSDictionary *params = @{@"BusinessCode": @"Log_InsertUserLog",
                             @"Data": @{
                                     @"ActivityId": @(_activityID),
                                     @"AdminUserId": @(ZD_UserM.userID),
                                     @"UserId": @(model.ID),
                                     @"VCode": @"",
                                     @"AddTime" : @"",
                                     @"From" : @"IOS"
                                     }
                             };
    [ZD_NetWorkM postDataWithMethod:urlStr parameters:params succ:^(NSDictionary *obj) {
        
        NSLog(@"succsss --- ");
    } fail:^(NSError *error) {
        NSLog(@"error --- ");
    }];
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
