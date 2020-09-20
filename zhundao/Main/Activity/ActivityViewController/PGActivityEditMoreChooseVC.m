//
//  PGActivityEditMoreChooseVC.m
//  zhundao
//
//  Created by zhundao on 2017/6/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGActivityEditMoreChooseVC.h"
#import "PGActivityEditMoreChooseViewModel.h"
#import "PGActivityEditMoreChooseCell.h"
#import "UIView+LeftBack.h"
@interface PGActivityEditMoreChooseVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView ;
@property(nonnull,strong)PGActivityEditMoreChooseViewModel *VM;
@property(nonatomic,strong)NSMutableArray *indexArray ;
@end

@implementation PGActivityEditMoreChooseVC

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
    NSString *str = @"";
    NSInteger strCount = 0 ;
    for (int i = 0; i <_indexArray.count; i++) {
        if ([_indexArray[i] integerValue]) {
            if (strCount==0) {
                str = [str stringByAppendingString:self.allDataArray[i]];
            }
            else
            {
                str = [[str stringByAppendingString:@"|"] stringByAppendingString:self.allDataArray[i]];
            }
            strCount +=1;
        }
    }
   
    if (_isMust&&[str isEqualToString:@""]) {
        PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"内容不能为空"];
        [label labelAnimationWithViewlong:self.view];
    }else{
        if (_strBlock) {
            _strBlock(str);
        }
        [self.navigationController popViewControllerAnimated:YES];
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

- (NSMutableArray *)indexArray
{
    if (!_indexArray) {
        _indexArray = [[_VM getIndexArrayFromArray:_nowDataArray allArray:_allDataArray] mutableCopy];
    }
    return _indexArray;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.allDataArray.count;
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
    cell.titleLabel.text = self.allDataArray[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
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
    if (self.isMoreChoose) {    //多选 则点击能多选
        if ([self.indexArray[indexPath.row] integerValue]) {
            [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
            cell.imageview.image = [UIImage imageNamed:@"空圈"];
        }else{
              [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
              cell.imageview.image = [UIImage imageNamed:@"option打勾"];
        }
    }else
    {
        [self.indexArray removeAllObjects];
        for (int i = 0; i <self.allDataArray.count; i++ ) {
            [self.indexArray addObject:@"0"];
        }
        [self.indexArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        [_tableView reloadData];
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
