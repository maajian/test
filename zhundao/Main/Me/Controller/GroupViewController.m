//
//  GroupViewController.m
//  zhundao
//
//  Created by zhundao on 2017/5/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupMV.h"
#import "ContactMV.h"
#import "groupModel.h"
#import "GroupTableViewCell.h"
#import "NSString+getColorFromFirst.h"
#import "NSString+ChangeToPinyin.h"
#import "UIImage+LGExtension.h"
#import "personDetailViewController.h"
@interface GroupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    Reachability *r;
}
@property(nonatomic,strong)UITableView *tableView ;
@property(nonatomic,strong)NSMutableArray *titleArray ;
@property(nonatomic,strong)NSMutableDictionary *openSectionDict;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *mobileArray;
@property(nonatomic,strong)NSMutableArray *personIDArray;
@property(nonatomic,assign)BOOL isDelete;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBack];
    [self baseSetting];
    
    // Do any additional setup after loading the view.
}
#pragma 基础设置 base 
- (void)baseSetting
{
    self.openSectionDict = [[NSMutableDictionary alloc] init];
    _nameArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    _mobileArray = [NSMutableArray array];
    _personIDArray= [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self firstload];
    
}

#pragma  懒加载

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"GroupTableViewCell" bundle:nil] forCellReuseIdentifier:@"groupID"];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _tableView;
}
#pragma network 网络
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            [self notHaveNet];
            break;
        }
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
            [self netWork];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self netWork];
            break;
    }
}
- (void)netWork
{
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/PostContactGroup?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    GroupMV *Group = [[GroupMV alloc]init];
    [Group netWorkWithStr:str];
    __weak typeof(Group) weakGroup = Group;
    if (_nameArray) {
        [_nameArray removeAllObjects];
        [_personIDArray removeAllObjects];
        [_mobileArray removeAllObjects];
        [_imageArray removeAllObjects];
    }
    Group.block = ^(NSArray *array)
    {
        NSMutableArray *array1 = [NSMutableArray array];
        [_nameArray addObject:[weakGroup searchDatabaseFromID:0].firstObject];
        [_imageArray addObject:[[weakGroup searchDatabaseFromID:0] objectAtIndex:1]];
        [_mobileArray addObject:[[weakGroup searchDatabaseFromID:0] lastObject]];
        [_personIDArray addObject:[[weakGroup searchDatabaseFromID:0] objectAtIndex:2]];
        for (NSDictionary *dic in array) {
            groupModel *model = [groupModel yy_modelWithDictionary:dic];
            [array1 addObject:model.GroupName];
            [_nameArray addObject:[weakGroup searchDatabaseFromID:model.ID].firstObject];
            [_imageArray addObject:[[weakGroup searchDatabaseFromID:model.ID] objectAtIndex:1]];
            [_mobileArray addObject:[[weakGroup searchDatabaseFromID:model.ID] lastObject]];
            [_personIDArray addObject:[[weakGroup searchDatabaseFromID:model.ID] objectAtIndex:2]];
        }
        _titleArray =[array1 mutableCopy];
        [_titleArray insertObject:@"未分组" atIndex:0];
        [_tableView reloadData];
    };
    
}
- (void)notHaveNet
{
    GroupMV *Group = [[GroupMV alloc]init];
    if (_nameArray) {
        [_nameArray removeAllObjects];
        [_personIDArray removeAllObjects];
        [_mobileArray removeAllObjects];
        [_imageArray removeAllObjects];
    }
    [_nameArray addObject:[Group searchDatabaseFromID:0].firstObject];
    [_imageArray addObject:[[Group searchDatabaseFromID:0] objectAtIndex:1]];
    [_mobileArray addObject:[[Group searchDatabaseFromID:0] lastObject]];
    [_personIDArray addObject:[[Group searchDatabaseFromID:0] objectAtIndex:2]];
    NSArray *Array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupID"] copy];
    for (NSString *str in Array) {
        [_nameArray addObject:[Group searchDatabaseFromID:[str integerValue]].firstObject];
        [_imageArray addObject:[[Group searchDatabaseFromID:[str integerValue]] objectAtIndex:1]];
        [_mobileArray addObject:[[Group searchDatabaseFromID:[str integerValue]] lastObject]];
        [_personIDArray addObject:[[Group searchDatabaseFromID:[str integerValue]] objectAtIndex:2]];
    }
    _titleArray = [[[NSUserDefaults standardUserDefaults]objectForKey:@"GroupName"] mutableCopy];
    [_titleArray insertObject:@"未分组" atIndex:0];
    [_tableView reloadData];
}
#pragma UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *groupID = @"groupID";
        GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupID];
        if (!cell) {
            cell = [[GroupTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupID];
        }
        NSArray *groupNameArray = [_nameArray objectAtIndex:indexPath.section];
        NSArray *groupMobileArray = [_mobileArray objectAtIndex:indexPath.section];
        NSString *nameStr =groupNameArray[indexPath.row];
        NSArray *groupImageArray = [_imageArray objectAtIndex:indexPath.section];
        NSString *imageStr = groupImageArray[indexPath.row];
        [self setimageWithNameStr:nameStr imageStr:imageStr withCell:cell];
        cell.nameLabel.text = nameStr;
        cell.nameLabel.font = [UIFont systemFontOfSize:14];
        cell.phoneLabel.text = groupMobileArray[indexPath.row];
        cell.separatorInset = UIEdgeInsetsMake(30, 0, 30, 0);
        return cell;
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, 0, rect.size.width-30, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width-30, 1));
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.tag = section+100;
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, view.bounds.size.width, view.bounds.size.height)];
        label.text = self.titleArray[section];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        if ([[self.openSectionDict valueForKey:[NSString stringWithFormat:@"%li", (long)section]] integerValue] == 0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (view.bounds.size.height - 10) / 2, 10, 10)];
            imageView.image = [UIImage imageNamed:@"rightTriangle"];   //  三角形小图片
            
            [view addSubview:imageView];
        } else {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (view.bounds.size.height - 7) / 2-3, 10, 10)];
            imageView.image = [UIImage imageNamed:@"bottomTriangle"];
            [view addSubview:imageView];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTap:)];
        [view addGestureRecognizer:tap];
        return view;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }else{
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    personDetailViewController *person = [[personDetailViewController alloc]init];
    ContactMV *mv = [[ContactMV alloc]init];
    NSArray *idarray = [_personIDArray objectAtIndex:indexPath.section];
    NSArray *pushArray = [mv searchDatabaseFromID:[idarray[indexPath.row] integerValue]];
    person.dataArray = [pushArray copy];
    person.personID =[idarray[indexPath.row] integerValue];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:person animated:YES];
    
    
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/DeleteContact/%li?accessKey=%@",zhundaoApi,(long)[idarray[indexPath.row] integerValue],[[SignManager shareManager] getaccseekey]];
    person.block = ^(BOOL isDelete)
    {
        if (isDelete) {
            [mv deleteDataWithModel:[idarray[indexPath.row] integerValue]];
            [mv deleteDataHaveNetWithStr:str];
            [self netWork];
            _isDelete = isDelete;
        }
    };
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        if ([[self.openSectionDict valueForKey:[NSString stringWithFormat:@"%li", (long)section]] integerValue] == 0) {    //根据记录的展开状态设置row的数量
            return 0;
        } else {
            NSArray *array =_nameArray[section];
            return array.count;
        }
}

#pragma sectionHeader Clicked 头视图点击
- (void)gesTap:(UITapGestureRecognizer *)tap
{
    NSString *key = [NSString stringWithFormat:@"%li",tap.view.tag-100];
    if ([[self.openSectionDict objectForKey:key]integerValue]==0) {
        [self.openSectionDict setObject:@"1" forKey:key];
    }
    else{
        [self.openSectionDict setObject:@"0" forKey:key];
    }
    NSUInteger index = tap.view.tag;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:index-100];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
   
}
#pragma contentFill 视图内容填充 图片和名字
- (void)setimageWithNameStr :(NSString *)nameStr imageStr :(NSString *)imageStr withCell :(GroupTableViewCell *)cell
{
    UIColor *color = [[NSString alloc]getColorWithStr:nameStr];
    if (![imageStr isEqualToString:@"(null)"]) {
        [cell.groupImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        cell.groupImageView.layer.cornerRadius = cell.groupImageView.frame.size.width/2;
        cell.groupImageView.layer.masksToBounds = YES;
    }
    else{
        NSString *text = nil;
        if (nameStr.length<=2) {
            text = nameStr;
        }
        else
        {
            text = [nameStr substringWithRange:NSMakeRange(nameStr.length-2, 2)];
        }
        cell.groupImageView.image = [UIImage circleImageWithText:text bgColor:color size:CGSizeMake(cell.groupImageView.frame.size.height, cell.groupImageView.frame.size.width)];
    }

}
#pragma 自定义返回按钮
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
-(void)backpop
{
    if (_deleteBlock) {
        _deleteBlock(_isDelete);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"分组没有内存泄漏");
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
