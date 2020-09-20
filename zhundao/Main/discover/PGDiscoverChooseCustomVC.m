//
//  PGDiscoverChooseCustomVC.m
//  zhundao
//
//  Created by zhundao on 2017/7/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverChooseCustomVC.h"
#import "PGActivityEditMoreChooseCell.h"
#import "PGActivityEditMoreChooseViewModel.h"
@interface PGDiscoverChooseCustomVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView ;
@property(nonnull,strong)PGActivityEditMoreChooseViewModel *VM;
@property(nonatomic,strong)NSArray *nameArray ;

@property(nonatomic,strong)NSMutableArray *indexArray; //选择的名字index数组

@property(nonatomic,strong)NSMutableArray *selectArray;  //选择的名字数组

@end

@implementation PGDiscoverChooseCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSeting];
    [self leftButton];
    
    // Do any additional setup after loading the view.
}
#pragma mark baseSeting 基础设置

- (void)baseSeting
{
    [self.view addSubview:self.tableView];
    _VM = [[PGActivityEditMoreChooseViewModel alloc]init];
}
#pragma mark 自定义返回按钮

- (void)leftButton
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(-8, 20, 80, 44)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    UIImageView *imageview = [MyImage initWithImageFrame:CGRectMake(-8, 10, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    UILabel *button = [MyLabel initWithLabelFrame:CGRectMake(15, 0, 40,45) Text:@"返回" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:NO];
    [view addSubview:imageview];
    [view addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = item;
    [view addGestureRecognizer:tap3];
}
- (void)backAction
{
    [self.selectArray removeAllObjects];
    for (int i = 0; i <self.indexArray.count; i++) {
        if ([self.indexArray[i] isEqualToString:@"1"]) {
            [self.selectArray addObject:self.nameArray[i]];
        }
    }
    if (self.selectArray.count>0&&self.selectArray.count<=3) {
        _block(_selectArray);
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.selectArray.count==0){
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"至少选择一项"];
        [label labelAnimationWithViewlong:self.view];
    }else
    {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"至多选择三项"];
        [label labelAnimationWithViewlong:self.view];
    }
    
}




#pragma mark 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        [_tableView registerNib:[UINib nibWithNibName:@"PGActivityEditMoreChooseCell" bundle:nil] forCellReuseIdentifier:@"moreChooseID"];
        _tableView.backgroundColor  = ZDBackgroundColor;
    }
    return _tableView;
}

- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"姓名",@"手机",@"单位",@"部门",@"职务",@"身份证",@"行业",@"邮箱",@"地址",@"管理员备注"];
    }
    return _nameArray;
}
- (NSMutableArray *)indexArray
{
    if (!_indexArray) {
        _indexArray = [[_VM getIndexArrayFromArray:_nowDataArray allArray:_nameArray] mutableCopy];
    }
    return _indexArray;
}
- (NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityEditMoreChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreChooseID"];
    if (!cell) {
        cell = [[PGActivityEditMoreChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreChooseID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.indexArray[indexPath.row]integerValue]==1) {
        cell.imageview.image = [UIImage imageNamed:@"option打勾"];
    }else
    {
        cell.imageview.image = [UIImage imageNamed:@"空圈"];
    }
    cell.titleLabel.text = self.nameArray[indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 30)];
    label.textColor = ZDHeaderTitleColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"请选择文本打印，至少一项，至多三项";
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityEditMoreChooseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([self.indexArray[indexPath.row] integerValue]) {
            [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
            cell.imageview.image = [UIImage imageNamed:@"空圈"];
        }else{
            [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
            cell.imageview.image = [UIImage imageNamed:@"option打勾"];
        }
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
