#import "PGVideoWithScroll.h"
//
//  PGSignInResultsVC.m
//  zhundao
//
//  Created by zhundao on 2017/3/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGSignInResultsVC.h"
#import "PGSignInLoadAllSignCell.h"
#import "PGSignInLoadallsignModel.h"
#import "PGSignInLoadAllSignCell.h"
#import "PGSignResult.h"
#import "PGSignInOnePersonDataNetWork.h"
#import "PGActivitySignleListVC.h"
@interface PGSignInResultsVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataArray;
    PGSignInLoadAllSignCell *myCell;
    NSMutableIndexSet *set;
}
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)PGSignInOnePersonDataNetWork *oneVM;
@property(nonatomic,strong)NSMutableArray *phoneArray ;
@property(nonatomic,strong)NSMutableArray *nameArray;
@end

@implementation PGSignInResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
#pragma mark ----- 懒加载
- (PGSignInOnePersonDataNetWork *)oneVM{
    if (!_oneVM) {
        _oneVM = [[PGSignInOnePersonDataNetWork alloc]init];
    }
    return _oneVM;
}
- (NSMutableArray *)nameArray
{
    if (_nameArray ==nil) {
        _nameArray = [NSMutableArray array];
    }
    for (int i= 0; i<self.alldata.count; i++) {
        PGSignInLoadallsignModel *model = [self.alldata objectAtIndex:i];
        [_nameArray addObject:model.TrueName];
    }
    return _nameArray;
}
- (NSMutableArray *)phoneArray
{
    if (_phoneArray ==nil) {
       _phoneArray = [NSMutableArray array];
    }
    for (int i= 0; i<self.alldata.count; i++) {
        PGSignInLoadallsignModel *model = [self.alldata objectAtIndex:i];
        [_phoneArray addObject:model.Mobile];
    }
    return _phoneArray;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
      [_tableView registerNib:[UINib nibWithNibName:@"PGSignInLoadAllSignCell" bundle:nil] forCellReuseIdentifier:@"loadID"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor =ZDBackgroundColor;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *assetResourceTypeg3= [[UISlider alloc] initWithFrame:CGRectZero]; 
    assetResourceTypeg3.minimumValue = 0; 
    assetResourceTypeg3.maximumValue = 100; 
    assetResourceTypeg3.value =48; 
        UITableView *keyboardWillChanget2= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    keyboardWillChanget2.frame = CGRectZero; 
    keyboardWillChanget2.showsVerticalScrollIndicator = NO; 
    keyboardWillChanget2.showsHorizontalScrollIndicator = NO; 
    keyboardWillChanget2.backgroundColor = [UIColor whiteColor]; 
    keyboardWillChanget2.separatorColor = [UIColor whiteColor]; 
    keyboardWillChanget2.tableFooterView = [UIView new]; 
    keyboardWillChanget2.estimatedRowHeight =77; 
    keyboardWillChanget2.estimatedSectionHeaderHeight =49; 
    keyboardWillChanget2.estimatedSectionFooterHeight =49; 
    keyboardWillChanget2.rowHeight =18; 
    keyboardWillChanget2.sectionFooterHeight =34; 
    keyboardWillChanget2.sectionHeaderHeight =88; 
    keyboardWillChanget2.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(211,175,170,64)];
     keyboardWillChanget2.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(188,3,68,232)];
     PGVideoWithScroll *effectThumbImage= [[PGVideoWithScroll alloc] init];
[effectThumbImage pg_pickerViewShowWithphotosDelegateWith:assetResourceTypeg3 colorSpaceCreate:keyboardWillChanget2 ];
});
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGSignInLoadAllSignCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadID"];
    if (cell==nil) {
        cell = [[PGSignInLoadAllSignCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   cell.model = dataArray[indexPath.row];
    if (cell.model.Status==0) {
        cell.checkLabel.image = [ UIImage imageNamed:@"打勾-9"];
    }if (cell.model.Status==1) {
        cell.checkLabel.image = [ UIImage imageNamed:@"打勾-8"];
        cell.nameLabel.frame = CGRectMake(0, 20, 100, 100);
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callAlert)];
    cell.phoneLabel.userInteractionEnabled = YES;
    [cell.phoneLabel  addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(signOther:)];
    cell.timeLabel.userInteractionEnabled = YES;
    [cell.timeLabel addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail:)];
    [cell addGestureRecognizer:tap2];
    return cell;
}

- (void)showDetail:(UITapGestureRecognizer *)tap
{
    myCell = (PGSignInLoadAllSignCell *)tap.view;
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%li",(long)self.activityID]];
    __weak typeof(self) weakSelf = self;
    if (array) {
        [self pushToDetail:array];
    }else{
        [self.oneVM getNewList:self.activityID BackBlock:^(NSArray *backArray) {
            [weakSelf pushToDetail:backArray];
        }];
    }
}
- (void)pushToDetail :(NSArray *)array
{
    __block NSDictionary *datadic = nil;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        datadic = [(NSDictionary *)array[idx] copy];
        if ([datadic[@"Mobile"] isEqualToString:myCell.model.Mobile]) {
            *stop = YES;
        }
        NSLog(@"index = %lu",(unsigned long)idx);
    }];
    __weak typeof(self) weakSelf = self;
    PGActivitySignleListVC *signle = [[PGActivitySignleListVC alloc]init];
    if (datadic) {
        signle.datadic =datadic;
        signle.userInfo = [weakSelf getUserInfo:datadic];
    }else{
        NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
        signle.userInfo = @"100,101";
        signle.datadic = [arr objectAtIndex:myCell.tag];
    }
    signle.personID = myCell.model.UserID;
    signle.activityID = [datadic[@"ActivityID"] integerValue];
    signle.vcode = myCell.model.VCode;
    [weakSelf.presentingViewController  setHidesBottomBarWhenPushed:YES];
    [weakSelf.presentingViewController.navigationController pushViewController:signle animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_phoneArray removeAllObjects];
    [_nameArray removeAllObjects];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:self.phoneArray];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray: self.nameArray];
    NSMutableArray *array3 = nil;
    NSMutableArray *array4 = nil;
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchController.searchBar.text];
    array3 = [NSMutableArray arrayWithArray:[_phoneArray filteredArrayUsingPredicate:searchPredicate]];
     array4 =[NSMutableArray arrayWithArray:[_nameArray filteredArrayUsingPredicate:searchPredicate]];
    if (set) {
        [set removeAllIndexes];
    }
    else{
        set = [[NSMutableIndexSet alloc]init];
    }
    if (array3.count!=0||array4.count!=0) {
      
            for (int i =0; i<array3.count; i++) {
                [set addIndex:[array1 indexOfObject:array3[i]]];
            }
            for (int i=0 ; i<array4.count; i++) {
                [set addIndex:[array2 indexOfObject:array4[i]]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                dataArray = [[_alldata  objectsAtIndexes:set]mutableCopy];
                [_tableView reloadData];
            });
    }
    else
    {
        dataArray = nil;
        [_tableView reloadData];
    }
}
- (void)signOther:(UITapGestureRecognizer *)tap
{
    myCell = (PGSignInLoadAllSignCell *)tap.view.superview.superview;
    if (!myCell.model.SignTime||[myCell.timeLabel.text isEqualToString:@" 管理员代签  "]) {
        [self showSign];
    }
}

- (void)showSign {
    ZD_WeakSelf
    [PGAlertView alertWithTitle:[NSString stringWithFormat:@"确定为 %@ 代签",myCell.model.TrueName] message:@"代签后不能修改" sureBlock:^{
        [[PGSignResult alloc] dealAdminSignWithSignID:weakSelf.signID phone:myCell.model.Mobile action1:^{
            [weakSelf TableReloadData];
        }];
    } cancelBlock:^{
        
    }];
}
- (void)TableReloadData
{
    self.alldata = [self getallData];
   NSInteger index = [dataArray indexOfObject:myCell.model];
    NSMutableArray *arr  = [dataArray mutableCopy];
    [arr removeObjectAtIndex:index];
    NSArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)_signID]];
   PGSignInLoadallsignModel *model =[self.alldata objectAtIndex:array.count-1];
    [arr insertObject:model atIndex:index];
    dataArray = [arr mutableCopy];
    [_tableView reloadData];
}
- (NSArray *)getallData
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)_signID]];
    NSMutableArray *alldataarray = [NSMutableArray array];
    for (NSDictionary *acdic in arr) {
        PGSignInLoadallsignModel *model = [PGSignInLoadallsignModel yy_modelWithJSON:acdic];
        [alldataarray addObject:model];
    }
    return [alldataarray copy];;
}
- (void)callAlert
{
    ZD_WeakSelf
    [PGAlertView alertWithTitle:@"确定拨打电话?" message:nil sureBlock:^{
        [weakSelf callphone];
    } cancelBlock:^{
        
    }];
}
- (void)callphone
{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",myCell.model.Mobile];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}


- (NSString *)getUserInfo:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"100",@"101", nil];
    NSArray *engArray = @[@"Sex",@"Company",@"Depart",@"Duty",@"IDcard",@"Industry",@"Email",@"Address",@"Remark",@"FaceImg"];
    NSArray *arr=  @[@"102",@"103",@"104",@"105",@"110",@"106",@"107",@"111",@"109",@"112"];
    for (int i = 0; i <10; i++) {
        if (![[dic objectForKey:engArray[i]] isEqual:@""]) {
            [array addObject:arr[i]];
        }
    }
    if ([[dic objectForKey:@"Sex"] longValue]==0) {
        [array removeObject:@"102"];
    }
    return [array componentsJoinedByString:@","];
}
@end
