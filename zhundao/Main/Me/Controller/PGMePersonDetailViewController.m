#import "PGFieldValueDictionary.h"
//
//  PGMePersonDetailViewController.m
//  zhundao
//
//  Created by zhundao on 2017/5/25.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGMePersonDetailViewController.h"
#import "PGMeChooseGroupViewController.h"
#import "GZActionSheet.h"
#import "UIAlertController+creat.h"
#import "NSString+getColorFromFirst.h"
#import "PGMeContactMV.h"
#import "UIImage+LGExtension.h"
#import "PGMeNewOrEditPersonViewController.h"
#import "PGMeContactViewController.h"
@interface PGMePersonDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *firstCellArray;  //第一个cell后的数据
@property(nonatomic,strong)NSMutableArray *firstCellNameArray;  //第一个cell后的数据
@property(nonatomic,strong)NSMutableArray *otherDataArray; //第二个cell后的数据
@property(nonatomic,strong)NSMutableArray *topNameArray ;//第二个cell后名称数组
@property(nonatomic,copy)NSString *phoneStr;
@property(nonatomic,copy)NSString *groupStr ;
@end

@implementation PGMePersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
    
    // Do any additional setup after loading the view.
}
#pragma 基础设置 
- (void)baseSetting
{
    self.title = @"联系人详情";
    [self createRightNav];
    [self.firstCellArray addObjectsFromArray:self.dataArray.firstObject];
    self.otherDataArray = [_dataArray mutableCopy];
    if ([_otherDataArray[6] isEqualToString:@"0"]) {
        [_otherDataArray replaceObjectAtIndex:6 withObject:@""];
    }
    [_otherDataArray removeObjectAtIndex:0];
    NSMutableArray *array = [NSMutableArray arrayWithArray:_otherDataArray];
    NSMutableArray *array1 =  [NSMutableArray arrayWithArray:self.topNameArray];
    for (int i=0; i<array.count; i++) {
        if ([array[i] isEqualToString:@"(null)"]||[array[i] isEqualToString:@""]) {
            [_otherDataArray removeObject:array[i]];
            [_topNameArray removeObject:array1[i]];
        }
    }
    [self.view addSubview:self.tableview];
}

#pragma 懒加载
- (NSMutableArray *)firstCellNameArray{
    if (!_firstCellNameArray) {
        _firstCellNameArray = [NSMutableArray array];
        [_firstCellNameArray addObject:@"姓名"];
        [_firstCellNameArray addObject:@"图片"];
        [_firstCellNameArray addObject:@"性别"];
    }
    return _firstCellNameArray;
}
- (NSMutableArray *)topNameArray
{
    if (!_topNameArray) {
        _topNameArray = [NSMutableArray array];
        NSArray *array = @[@"手机",@"分组",@"地址",@"公司",@"职务",@"身份证",@"邮箱",@"编号",@"备注"];
        [_topNameArray addObjectsFromArray:array];
    }
    return _topNameArray;
}
- (NSMutableArray *)firstCellArray
{
    if (!_firstCellArray) {
        _firstCellArray = [NSMutableArray array];
    }
    return _firstCellArray;
}
- (NSMutableArray *)otherDataArray
{
    if (!_otherDataArray) {
        _otherDataArray = [NSMutableArray array];
    }
    return _otherDataArray;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate =self;
    }
    return _tableview;
}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _otherDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *personID =[NSString stringWithFormat:@"personID%li",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:personID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:personID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            
            
           [self createPhoneCellWithView:cell.contentView WithTopName:_topNameArray[indexPath.row] BottomName:_otherDataArray[indexPath.row]];
        }
        else{
            [self createGroupCellWithView:cell.contentView WithTopName:_topNameArray[indexPath.row] BottomName:_otherDataArray[indexPath.row]];
        }
        if ([_topNameArray[indexPath.row] isEqualToString:@"分组"]) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushChoose:)];
            self.groupStr =[_otherDataArray[indexPath.row] copy];
            [cell addGestureRecognizer:tap];
        }
        
    }
    
    
    return  cell;
}
- (void)pushChoose:(UITapGestureRecognizer *)tap  //选择分组
{
    NSInteger index = [_topNameArray indexOfObject:@"分组"];
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UILabel *label = [cell.contentView.subviews objectAtIndex:1];
    PGMeChooseGroupViewController *choose = [[PGMeChooseGroupViewController alloc]init];
    choose.nameStr = self.groupStr;
    choose.personid = self.personID;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:choose animated:YES];
    choose.block = ^(NSString *groupName,NSInteger groupID)
    {
        self.groupStr = groupName;
        [_otherDataArray replaceObjectAtIndex:index withObject:groupName];
        label.text = groupName;
        
    };
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 160;
    }
    else{
        return 55;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

#pragma 视图创建
-(void)createFirCellWithView :(UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 30, 50, 50)];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius= 25;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.borderWidth= 0.3;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+50+10, 30, 100, 50)];
    label.text = _firstCellArray[0];
    label.font = KHeitiSCMedium(15);
    if (![_firstCellArray[1] isEqualToString:@"(null)"]||[_firstCellArray[1] isEqualToString:@""]) { //姓名
        [imageView sd_setImageWithURL:[NSURL URLWithString:_firstCellArray[1]]];
    }else
    {
        
        NSString *text = _firstCellArray[0];
        UIColor *color = [[NSString alloc]getColorWithStr:text];
        if (text.length<=2) {
            text = _firstCellArray[0];
        }
        else
        {
            text = [text substringWithRange:NSMakeRange(text.length-2, 2)];
        }
        imageView.image = [UIImage circleImageWithText:text bgColor:color size:CGSizeMake(imageView.frame.size.height, imageView.frame.size.width)];
    }
    [view addSubview:imageView];
    [view addSubview:label];
}

- (void)createPhoneCellWithView :(UIView *)view WithTopName:(NSString *)topName BottomName :(NSString *)bottomName
{
    [self createFirCellWithView:view];
    [self createTopLabelWithName:topName WithView:view y:115];
    [self createBottomLabelWithName:bottomName View:view y:135];
    self.phoneStr = [bottomName copy];
    UIImageView *callImage = [MyImage initWithImageFrame:CGRectMake(kScreenWidth-40, 125, 20, 20) imageName:@"img_public_call_phone" cornerRadius:0 masksToBounds:0];
    callImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callAlert)];
    [callImage addGestureRecognizer:tap];
    [view addSubview:callImage];
}

- (void)createGroupCellWithView :(UIView *)view WithTopName:(NSString *)topName BottomName :(NSString *)bottomName
{
    [self createTopLabelWithName:topName WithView:view y:5];
    [self createBottomLabelWithName:bottomName View:view y:25];
}

//创建label上面
- (void)createTopLabelWithName :(NSString *)name WithView :(UIView *)view y:(NSInteger)offsety
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(18, offsety, 150, 25)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = name;
    label.textColor = [UIColor lightGrayColor];
    [view addSubview:label];
}
- (void)createBottomLabelWithName :(NSString *)name View :(UIView *)view y:(NSInteger)offsety
{
    UILabel *phoneLabel = [[MyLabel alloc]initWithFrame:CGRectMake(18, offsety, kScreenWidth, 20) Text:name textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
    [view addSubview:phoneLabel];
}
- (void)createRightNav
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(moreAction)];
}
#pragma 事件响应
- (void)moreAction
{
    NSArray *array = @[@"删除联系人",@"编辑联系人"];
    GZActionSheet *sheet = [[GZActionSheet alloc]initWithTitleArray:array WithRedIndex:1 andShowCancel:YES];
    // 2. Block 方式
    __weak typeof(self) weakSelf = self;
    sheet.ClickIndex = ^(NSInteger index){
        NSLog(@"Show Index %zi",index); //取消0
        
        if (index==1) {   //删除
            [weakSelf createAlert];
        }
        
        if (index==2) { //编辑
            PGMeNewOrEditPersonViewController *new = [[PGMeNewOrEditPersonViewController alloc]init];
            [weakSelf setHidesBottomBarWhenPushed:YES];
            new.personID = self.personID;
            [weakSelf.navigationController pushViewController:new animated:YES];
        }
    };
    
    [self.view.window addSubview:sheet];
}
-(void)createAlert
{
    UIAlertController *alert = [UIAlertController initWithNotHaveTextFieldTitle:nil message:@"删除当前联系人" sureAction:^(UIAlertAction *action) {
        if (_block) {
            _block(1);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)callAlert  //打电话
{
    [PGAlertView alertWithTitle:@"确定拨打电话?" message:nil sureBlock:^{
        [self callphone];
    } cancelBlock:^{
        
    }];
}
- (void)callphone
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.phoneStr];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
