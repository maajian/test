//
//  FeeViewController.m
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "FeeViewController.h"
#import "FeeTableViewCell.h"
#import "FeeMV.h"
#import "FeeExplainViewController.h"
@interface FeeViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, feeTableViewCellDelegate>
{
    FeeTableViewCell *myCell;
}
@property(nonatomic,strong)               UITableView *tableview ;
/*! 数组的个数 */
@property(nonatomic,assign)   NSInteger sectionCount ;
/*! 外部传入的费用数组 */
@property(nonatomic,strong)   NSMutableArray *dataArray;
/*! 每个费用字典 */
@property(nonatomic,strong)    NSMutableDictionary *datadic ;

@property(nonatomic,assign)   NSInteger oriCount ;

/*! sectionCount =0 时出现的footerview */
@property(nonatomic,strong)UIView *topView;

@end

@implementation FeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    [self customBack];
    // Do any additional setup after loading the view.
}
#pragma 基础设置

- (void)baseSetting
{
    self.title = @"活动费用";
    [self sortData:self.dataArray];
    if (_feeArray) {
        _sectionCount = self.dataArray.count;
    }
    else{
        _sectionCount = 0;
    }
    _oriCount = self.dataArray.count;
    [self.view addSubview:self.tableview];
}
#pragma 自定义返回按钮 事件
-(void)customBack
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backpop)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
- (void)backpop
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存本次编辑?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sureAction];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma 懒加载

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource =self;
        [_tableview registerClass:[FeeTableViewCell class] forCellReuseIdentifier:@"FeeTableViewCell"];
        _tableview.rowHeight = 220;
        _tableview.separatorStyle = NO;
    }
    return _tableview;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        if (_feeArray) {
            _dataArray = [_feeArray mutableCopy];
        }else{
             _dataArray = [NSMutableArray array];
        }
}
    return _dataArray;
}
- (NSMutableDictionary *)datadic
{
    if (!_datadic) {
        _datadic = [NSMutableDictionary dictionary];
    }
    return _datadic;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [self footerView];
    }
    return _topView;
}
#pragma UITableViewDataSource  

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_sectionCount==0) {
        [self.view addSubview:self.topView];
    }else{
        [_topView removeFromSuperview];
    }
   return _sectionCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeeTableViewCell"];
    cell.feeTableViewCellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFIeld1.delegate =self;;
    cell.textFIeld2.delegate =self;
    cell.textFIeld3.delegate =self;
    cell.textField4.delegate =self;
    cell.textFIeld1.tag = indexPath.section+100;
    cell.textFIeld2.tag = indexPath.section+100;
    cell.textFIeld3.tag = indexPath.section+100;
    cell.textField4.tag = indexPath.section+100;
    [self setdataForCell:cell index:indexPath];
    cell.deleteImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteCellWithges:)];
    [cell.deleteImageView addGestureRecognizer:tap];
    return cell;
}
- (void)setdataForCell:(FeeTableViewCell *)cell index:(NSIndexPath *)indexpath {
     id dic =self.dataArray[indexpath.section];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        cell.textFIeld1.text = dic [@"Title"];
        if ([dic[@"Amount"] isKindOfClass:[NSString class]]) {
             cell.textFIeld2.text = dic[@"Amount"];
        }
        else if([dic[@"Amount"] isKindOfClass:[NSNumber class]]){
            cell.textFIeld2.text = [NSString stringWithFormat:@"%.2f",[dic[@"Amount"] floatValue]];
        }else{
            cell.textFIeld2.text = @"";
            cell.textFIeld2.placeholder = @"请输入金额";
        }
        
        if ([dic[@"Limit"] integerValue]==0) {
            cell.textFIeld3.placeholder = @"默认不限";
            cell.textFIeld3.text = @"";
        }
        else{
            cell.textFIeld3.text = [NSString stringWithFormat:@"%@",dic[@"Limit"]];
        }
        
        cell.textField4.text = dic[@"OrderNo"] ?  [NSString stringWithFormat:@"%@",dic[@"OrderNo"]] : @"0";
        cell.showSwitch.on = dic[@"Status"] ? ![dic[@"Status"] boolValue] : YES;
    }
}
#pragma textFieldDelegate 
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    myCell = (FeeTableViewCell *)textField.superview.superview;
    if (_oriCount>textField.tag-100&&[self.dataArray[textField.tag-100] isKindOfClass:[NSDictionary class]])  self.datadic = [self.dataArray[textField.tag-100] mutableCopy];
    if ([self.datadic objectForKey:@"ID"]&&[textField.placeholder isEqualToString:@"请输入金额"]) {
        FeeMV *mv = [[FeeMV alloc]init];
        [mv netWorkWithID:[[self.datadic objectForKey:@"ID"] integerValue]];
        mv.feeBlock = ^(NSInteger isChange)
        {
            if (isChange==0) {
                maskLabel *label = [[maskLabel alloc]initWithTitle:@"已有人报名，无法修改金额"];
                [label labelAnimationWithViewlong:self.view];
                [self.view endEditing:YES];
            }
            else if (isChange==1)
            {
            }
            else
            {
                [[SignManager shareManager]showNotHaveNet:self.view];
                [self.view endEditing:YES];
            }
            [self.datadic removeAllObjects];
        };
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_oriCount>textField.tag-100&&[self.dataArray[textField.tag-100] isKindOfClass:[NSDictionary class]])  self.datadic = [self.dataArray[textField.tag-100] mutableCopy];
    NSIndexPath *index = [_tableview indexPathForCell:myCell];
    for (UIView *view in myCell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            if (![myCell.textFIeld1.text isEqualToString:@""]) {
                [self.datadic setObject:myCell.textFIeld1.text forKey:@"Title"];
            }
            if(![myCell.textFIeld2.text isEqualToString:@""])
            {
                 [self.datadic setObject:myCell.textFIeld2.text forKey:@"Amount"];
            }
          
            if ([myCell.textFIeld3.text isEqualToString:@""]) {
                     [self.datadic setObject:@"0" forKey:@"Limit"];
                }
           else{
               [self.datadic setObject:myCell.textFIeld3.text forKey:@"Limit"];
                }
            
            if ([myCell.textField4.text isEqualToString:@"0"] || [myCell.textField4.text isEqualToString:@""]) {
                [self.datadic setObject:@"0" forKey:@"OrderNo"];
            }
            else{
                [self.datadic setObject:myCell.textField4.text forKey:@"OrderNo"];
            }
            [self.datadic setObject:myCell.showSwitch.isOn ? @"0" : @"1" forKey:@"Status"];
        }
    }
    [self.dataArray replaceObjectAtIndex:index.section withObject:[self.datadic copy]];
    if ([textField isEqual:(myCell.textField4)]) {
        [self sortData:self.dataArray];
        [self.tableview reloadData];
    }
    [self.datadic removeAllObjects];
   
}
#pragma mark --- feeTableViewCellDelegate
- (void)feeTableViewCell:(FeeTableViewCell *)feeTableViewCell showSwitchDidChange:(UISwitch *)showSwitch {
    if (self.dataArray.count > 1) {
        self.datadic = [self.dataArray[feeTableViewCell.textFIeld1.tag-100] mutableCopy];
        [self.datadic setObject:showSwitch.isOn ? @"0" : @"1" forKey:@"Status"];
        [self.dataArray replaceObjectAtIndex:feeTableViewCell.textFIeld1.tag-100 withObject:[self.datadic copy]];
        [self.datadic removeAllObjects];
    } else {
        showSwitch.on = !showSwitch.on;
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"费用项个数为1时，无法隐藏"];
        [label labelAnimationWithViewlong:self.view];
    }
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == (_sectionCount- 1)) return 150;
    else if (section==0&&_sectionCount==0)  return 150;
    else return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == (_sectionCount- 1)) return [self footerView];
    else if (section==0&&_sectionCount==0)  return [self footerView];
    else return nil;
}
#pragma 视图创建
- (UIView *)footerView
{
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    View.backgroundColor = [UIColor clearColor];
    [View addSubview:[self explainButton]];
    [View addSubview:[self createAddFeeButton]];
    [View addSubview:[self createSureButton]];
    return View;
}

- (UIButton *)createAddFeeButton
{

    UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10, 20, kScreenWidth-20, 40) title:@"+ 添加费用项" textcolor:ZDGreenColor Target:self action: @selector(addFeeSection) BackgroundColor:[UIColor clearColor] cornerRadius:5 masksToBounds:YES];
    button.layer.borderWidth = 1;
    button.layer.borderColor = ZDGreenColor.CGColor;
    return button;
}
- (UIButton *)createSureButton
{
    UIButton *button = [MyButton initWithButtonFrame:CGRectMake(10, 70, kScreenWidth-20, 40) title:@"确定" textcolor:[UIColor whiteColor] Target:self action: @selector(sureAction) BackgroundColor:ZDGreenColor  cornerRadius:5 masksToBounds:YES];
    return button;
}
- (UIButton *)explainButton
{
    UIButton *button = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth / 2 - 50, 120, 100 , 30) title:@"交易服务费说明" textcolor:ZDGreenColor Target:self action: @selector(pushToExplain) BackgroundColor:[UIColor clearColor] cornerRadius:5 masksToBounds:YES];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"交易服务费说明"];
    [str addAttribute:NSForegroundColorAttributeName value:ZDGreenColor range:NSMakeRange(0, str.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    return button;
}
- (UILabel *)leftLabel
{
 
    UILabel   * _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 85, 44)];
    _leftLabel.font = [UIFont systemFontOfSize:15];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = [UIColor blackColor];
    return _leftLabel;
}
- (UITextField *)rightTextField
{
   
     UITextField  * _rightTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth-100, 44)];
        _rightTextField.font =  [UIFont systemFontOfSize:15];
        _rightTextField.textAlignment = NSTextAlignmentLeft;
        _rightTextField.textColor = [UIColor blackColor];
 
    return _rightTextField;
}


#pragma mark Action  按钮动作
- (void)deleteCellWithges:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    myCell = (FeeTableViewCell *)tap.view.superview.superview;
    NSDictionary *dic = self.dataArray[[_tableview indexPathForCell:myCell].section];
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([dic objectForKey:@"ID"]) {
            FeeMV *mv = [[FeeMV alloc]init];
            [mv netWorkWithID:[[dic objectForKey:@"ID"] integerValue]];
            mv.feeBlock = ^(NSInteger isChange)
            {
                if (isChange==0) {
                    maskLabel *label = [[maskLabel alloc]initWithTitle:@"已有人报名该项目，无法删除"];
                    [label labelAnimationWithViewlong:self.view];
                    
                }
                else if (isChange==1)
                {
                    [self deleteData];
                }
                else
                {
                    [[SignManager shareManager]showNotHaveNet:self.view];
                }
                [self.datadic removeAllObjects];
            };
        }
        else{
            [self deleteData];
        }
    }
    else{
        [self deleteData];
    }
}
- (void)deleteData
{
    _sectionCount -=1;
    myCell.textFIeld1.text = @"";
    myCell.textFIeld2.text =@"";
    myCell.textFIeld3.text = @"";
    [self.dataArray removeObjectAtIndex:[_tableview indexPathForCell:myCell].section];
    if (self.dataArray.count == 1) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.dataArray[0]];
        [dic setObject:@"0" forKey:@"Status"];
        [self.dataArray replaceObjectAtIndex:0 withObject:dic];
    }
    [_tableview deleteSections:[NSIndexSet indexSetWithIndex:[_tableview indexPathForCell:myCell].section] withRowAnimation:UITableViewRowAnimationFade];
    DDLogVerbose(@"data = %@",self.dataArray);
    [_tableview reloadData];
}

- (void)pushToExplain
{
    FeeExplainViewController *detail = [[FeeExplainViewController alloc]init];
    detail.urlString = @"https://www.zhundao.net/shouxufei.html";
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)addFeeSection
{
    [self.view endEditing:YES];
//    [_tableview insertSections:<#(nonnull NSIndexSet *)#> withRowAnimation:(UITableViewRowAnimation)]
    _sectionCount +=1;   //要先 改变numberofsection 个数。加1
    [self.dataArray addObject:@{}];
     [_tableview insertSections:[NSIndexSet indexSetWithIndex:_sectionCount-1] withRowAnimation:UITableViewRowAnimationRight];  //再添加单元格分组
    DDLogVerbose(@"data = %@",self.dataArray);
    [_tableview reloadData];
}
- (void)sureAction
{
    [self.view endEditing:YES];
    NSInteger a = 0; //记录当前循环次数
    for (id dic1 in _dataArray) {
        if([dic1 isKindOfClass:[NSDictionary class]]){
            a = a+1;
            NSDictionary *dic = (NSDictionary *)dic1;
            if ([[dic objectForKey:@"Title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
                [self showLabel];
                return;
            };
            if (([dic objectForKey:@"Amount"]&&[[dic objectForKey:@"Amount"] integerValue]<0)||![dic objectForKey:@"Amount"]){
                [self showLabel];
                return;
            };
            
        }
        if(![dic1 isKindOfClass:[NSDictionary class]]){
            [self showLabel];
            return;
        };
    }
       if (_block) {
            _block(_dataArray);
        }
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)showLabel
{
    maskLabel *label = [[maskLabel alloc]initWithTitle:@"请输入完整信息"];
    [label labelAnimationWithViewlong:self.view];
}
- (void)sortData:(NSMutableArray *)array {
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1[@"OrderNo"] integerValue] > [obj2[@"OrderNo"] integerValue];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
