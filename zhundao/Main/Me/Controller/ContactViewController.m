//
//  ContactViewController.m
//  zhundao
//
//  Created by zhundao on 2017/5/23.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactMV.h"
#import "ContactTableViewCell.h"
//#import "QQPopMenuView.h"
#import "GroupViewController.h"
#import "UIImage+LGExtension.h"
#import "personDetailViewController.h"
#import "JQIndicatorView+Show.h"
#import "NewOrEditPersonViewController.h"
@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
{
    JQIndicatorView *indicator;
    Reachability *r;
    NSInteger deleteIndex; //删除位置
}
@property(nonatomic,strong)UITableView                      *tableView ;
@property(nonatomic,strong)UISearchController                *searchController;
@property(nonatomic,strong)NSArray                     *headerArray;     //存储名单字母的数组
@property(nonatomic,copy)NSDictionary                        *datadic ;   //
@property(nonatomic,strong)UIView                        *groupView;
@property(nonatomic,assign)NSInteger                     allCount ;
@property(nonatomic,strong)NSArray                       *networkArray ;
@property(nonatomic,strong)NSMutableArray               *nameArray;
@property(nonatomic,strong)NSMutableArray               *phoneArray;
@property(nonatomic,strong)NSMutableArray               *pinyinArray;
@property(nonatomic,strong)NSMutableArray               *companyArray;
@property(nonatomic,strong)NSMutableIndexSet           *set;  //搜索出来的位置index的集合
@property(nonatomic,strong)NSMutableArray              *searchDataArray  ;
@end
//POST api/Contact/PostContact?accessKey={accessKey}
@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseSetting];
    // Do any additional setup after loading the view.
}
#pragma  mark   基础设置
- (void)baseSetting
{
    self.title = @"通讯录";
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self firstload];
    [self createRightButton];
}
#pragma  mark  网络判断 离线还是有线 
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            DDLogVerbose(@"wu");
        {
            [self notHaveNet];
            break;
        }
        case ReachableViaWWAN:
            // 使用3G网络
            DDLogVerbose(@"wan");
            [self netWork];
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            DDLogVerbose(@"wifi");
            [self netWork];
            break;
    }
}
#pragma  mark  network 网络加载 或者没网加载
- (void)netWork
{
    indicator = [[JQIndicatorView alloc]showWithView:self.view];
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/PostContact?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
    ContactMV *mv = [[ ContactMV alloc]init];
    [mv createSignList];   //创建数据库表
    [mv netWorkWithStr:str]; //网络请求
    __weak typeof(mv) weakMv = mv;
    __weak typeof(self) weakSelf = self;
    mv.block = ^(NSArray *array)
    {
        [indicator stopAnimating];
        _datadic = [[weakMv getdicWithArray:array isHaveNet:YES]copy];
        weakSelf.networkArray = [array copy];
     _headerArray = [weakMv sortWithArray:_datadic.allKeys];
        [_tableView reloadData];
        _allCount  = array.count;
        _searchController.searchBar.placeholder = [NSString stringWithFormat:@"搜索%li位联系人",(long)_allCount];
        [weakMv netWorkGroupSave];
    };
    mv.searchBlcok = ^(NSArray *nameArray,NSArray *phoneArray,NSArray *numberArray,NSArray *companyArray)
    {
        weakSelf.nameArray = [nameArray mutableCopy];
        weakSelf.pinyinArray = [numberArray mutableCopy];
        weakSelf.phoneArray = [phoneArray mutableCopy];
        weakSelf.companyArray = [companyArray mutableCopy];
    };
}

-(void)notHaveNet
{
    ContactMV *mv = [[ContactMV alloc]init];
    [mv createSignList];
    self.networkArray = [[mv searchAllData] copy];
    _datadic = [[mv getdicWithArray:_networkArray isHaveNet:NO] copy];
    _headerArray = [mv sortWithArray:_datadic.allKeys];
    _allCount = _networkArray.count;
    [_tableView reloadData];
    _searchController.searchBar.placeholder = [NSString stringWithFormat:@"搜索%li位联系人",(long)_allCount];
    mv.searchBlcok = ^(NSArray *nameArray,NSArray *phoneArray,NSArray *numberArray,NSArray *companyArray)
    {
        self.nameArray = [nameArray mutableCopy];
        self.pinyinArray = [numberArray mutableCopy];
        self.phoneArray = [phoneArray mutableCopy];
        self.companyArray = [companyArray mutableCopy];
    };
    
}
#pragma  mark   懒加载
- (NSMutableArray *)searchDataArray
{
    if (!_searchDataArray) {
        _searchDataArray = [NSMutableArray array];
    }
    return _searchDataArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"contactID"];
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return _tableView;
}
- (NSArray *)networkArray
{
    if (!_networkArray) {
        _networkArray = [NSArray array];
    }
    return _networkArray;
}
- (NSMutableArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}
- (NSMutableArray *)phoneArray
{
    if (!_phoneArray) {
        _phoneArray = [NSMutableArray array];
    }
    return _phoneArray;
}
- (NSMutableArray *)pinyinArray
{
    if (!_pinyinArray) {
        _pinyinArray = [NSMutableArray array];
    }
    return _pinyinArray;
}
- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil]; //不写nil可以选择新建控制器，通过block回调数据
        _searchController.searchBar.frame = CGRectMake(0, 2, kScreenWidth, 42);
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.barTintColor = ZDBackgroundColor; //搜索框旁边的颜色
        _searchController.dimsBackgroundDuringPresentation = NO;  //开始搜索时是否显示背景
        _searchController.delegate = self;   // 控制出现和消失等情况的代理 UISearchControllerDelegate
        [_searchController.searchBar sizeToFit];
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
        self.searchController.searchResultsUpdater = self;  //UISearchResultsUpdating 输入时实时更新的代理
       self.definesPresentationContext = YES;  //让搜索框一起滑动
    }
    return _searchController;
}
#pragma  mark   UITableViewDelegate 实现

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchController.active) {
        return 0.1;
    }
    else{
        if (section==0) {
            return 75;
        }
        else{
            return 20;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==_headerArray.count-1) {
        if (_headerArray.count==0) {
            return 0.1;
        }else
        {
            return 60;
        }
    }else{
        return 0.1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==_headerArray.count-1) {
        if (_headerArray.count==0) {
            return nil;
        }else
        {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
            NSString *numberStr = nil;
            if (_searchController.active) {
                numberStr = [NSString stringWithFormat:@"%li位联系人",(unsigned long)_searchDataArray.count];
            }
            else
            {
                numberStr = [NSString stringWithFormat:@"%li位联系人",(long)_allCount];
            }
            UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/4, 0, kScreenWidth/2, 60) Text:numberStr textColor:[UIColor colorWithRed:137.0f/256.0f green:137.0f/256.0f blue:137.0f/256.0f alpha:1] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:0];
            [view addSubview:label];
            return view;
        }
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_searchController.active) {
        return nil;
    }else{
        if (section>0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 20)];
            UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 25, 20) Text:_headerArray[section] textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0 ];
            [view addSubview:label];
            return view;
        }
        else
        {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/3, 75)];
            
            _groupView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
            _groupView.backgroundColor = [UIColor whiteColor];
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 32, 32)];
            imageview.image = [UIImage imageNamed:@"分组"];
            imageview.layer.cornerRadius = 2;
            imageview.layer.masksToBounds = YES;
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(56,0, 60, 55)];
            label.font = [UIFont systemFontOfSize:15];
            label.text = @"分组";
            [_groupView addSubview:label];
            [_groupView addSubview:imageview];
            UILabel *label1 = [MyLabel initWithLabelFrame:CGRectMake(10, 55, 25, 20) Text:_headerArray[section] textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0 ];
            [view addSubview:_groupView];
            [view addSubview:label1];
            [self addGes];
            
            return view;
        }
    }
}

- (void)addGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushGroup)];
    [_groupView addGestureRecognizer:tap];
    
}
- (void)pushGroup
{
    GroupViewController *group = [[GroupViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:group animated:YES];
    group.deleteBlock = ^(BOOL isDelete)
    {
        if (isDelete) {
            [self netWork];
        }
    };

}

#pragma  mark  UITableViewDataSource 实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *ContactID = @"contactID";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactID];
    if (!cell) {
        cell = [[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ContactID];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToPersonDetail:)];
    [cell addGestureRecognizer:tap];
    if (_searchController.active) {
        cell.model = _searchDataArray[indexPath.row];
    }
    else{
        NSArray *array = [_datadic objectForKey:_headerArray[indexPath.section]];
        cell.model = array [indexPath.row];
    }
    return cell;
}
- (void)pushToPersonDetail:(UITapGestureRecognizer *)tap
{
    
    ContactTableViewCell *cell = (ContactTableViewCell *)tap.view;
    personDetailViewController *person = [[personDetailViewController alloc]init];
    ContactMV *mv = [[ContactMV alloc]init];
   NSArray *pushArray = [mv searchDatabaseFromID:cell.model.ID];
    person.personID = cell.model.ID;
    person.dataArray = [pushArray copy];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:person animated:YES];
    person.block = ^(BOOL isDelete)
    {
        if (isDelete) {
            if (_searchController.active) {
                NSString *str = [NSString stringWithFormat:@"%@api/Contact/DeleteContact/%li?accessKey=%@",zhundaoApi,(long)cell.model.ID,[[SignManager shareManager] getaccseekey]];
                [mv deleteDataHaveNetWithStr:str];
                [self netWork];
            }else{
                deleteIndex = [_phoneArray indexOfObject:cell.model.Mobile];
                NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
                 [self deletaWithCell:cell indexpath:indexPath];
            }
        }
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_searchController.active) {
        return 1;
    }
    else{
        return _headerArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchController.active) {
        return _searchDataArray.count;
    }
    else{
        NSArray *countArray =[_datadic objectForKey:_headerArray[section]];
        return  countArray.count;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        [self deletaWithCell:cell indexpath:indexPath];
        deleteIndex = [_phoneArray indexOfObject:cell.model.Mobile];
    }
}
- (void)deletaWithCell:(ContactTableViewCell *)cell indexpath :(NSIndexPath *)indexPath
{
    NSMutableDictionary *dic = [_datadic mutableCopy];
    NSMutableArray *deleteArray = [[_datadic objectForKey:_headerArray[indexPath.section]] mutableCopy];
    [deleteArray removeObject:deleteArray[indexPath.row]];
//    [self deleteSearchArray];
    if (deleteArray.count==0) {
        [dic removeObjectForKey:_headerArray[indexPath.section]];
        NSMutableArray *headerarray = [_headerArray mutableCopy];
        [headerarray removeObject:_headerArray[indexPath.section]];
        _headerArray = [headerarray copy];
        _datadic = [dic copy];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteDataWithCell:cell];
    }
    else{
        [dic setObject:deleteArray forKey:_headerArray[indexPath.section]];
        _datadic = [dic copy];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self deleteDataWithCell:cell];
    }
}
- (void)deleteDataWithCell :(ContactTableViewCell *)cell
{
    NSString *str = [NSString stringWithFormat:@"%@api/Contact/DeleteContact/%li?accessKey=%@",zhundaoApi,(long)cell.model.ID,[[SignManager shareManager] getaccseekey]];
    ContactMV *mv = [[ContactMV alloc]init];
    _allCount = _allCount-1;
    _searchController.searchBar.placeholder = [NSString stringWithFormat:@"搜索%li位联系人",(long)_allCount];
    [mv deleteDataWithModel:cell.model.ID];
    [mv deleteDataHaveNetWithStr:str];
}
- (void)deleteSearchArray
{
    [_nameArray removeObjectAtIndex:deleteIndex];
    [_phoneArray removeObjectAtIndex:deleteIndex];
    [_pinyinArray removeObjectAtIndex:deleteIndex];
    [_companyArray removeObjectAtIndex:deleteIndex];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSString *key = [_headerArray objectAtIndex:index];
    if (key == UITableViewIndexSearch) {
        [_tableView setContentOffset:CGPointZero animated:YES];
        return NSNotFound;
    }
    return index;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_searchController.active) {
        return nil;
    }else
    {
        return _headerArray;
    }
}
#pragma  mark  UISearchResultsUpdating 实现
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:_nameArray];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:_phoneArray];
    NSMutableArray *array5= [NSMutableArray arrayWithArray:_pinyinArray];
     NSMutableArray *array7= [NSMutableArray arrayWithArray:_companyArray];
    
    NSMutableArray *array3 = nil;
    NSMutableArray *array4 =nil;
    NSMutableArray *array6 =nil;
    NSMutableArray *array8 = nil;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    array3= [NSMutableArray arrayWithArray:[_nameArray filteredArrayUsingPredicate:preicate]];
    array4 = [NSMutableArray arrayWithArray:[_phoneArray filteredArrayUsingPredicate:preicate]];
    array6 = [NSMutableArray arrayWithArray:[_pinyinArray filteredArrayUsingPredicate:preicate]];
    array8 = [NSMutableArray arrayWithArray:[_companyArray filteredArrayUsingPredicate:preicate]];
    if (_set) {
        [_set removeAllIndexes];
        [self.searchDataArray removeAllObjects];
    }
    else{
        _set = [[NSMutableIndexSet alloc]init];
    }
    if (array3.count!=0||array4.count!=0||array6.count!=0||array8.count!=0) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i =0; i<array3.count; i++) {
                [_set addIndex:[array1 indexOfObject:array3[i]]];
                [array1 replaceObjectAtIndex:[array1 indexOfObject:array3[i]] withObject:@""];
            }
            for (int i =0; i<array4.count; i++) {
                [_set addIndex:[array2 indexOfObject:array4[i]]];
                [array2 replaceObjectAtIndex:[array2 indexOfObject:array4[i]] withObject:@""];
            }
            for (int i =0; i<array6.count; i++) {
                [_set addIndex:[array5 indexOfObject:array6[i]]];
                [array5 replaceObjectAtIndex:[array5 indexOfObject:array6[i]] withObject:@""];
            }
            for (int i =0; i<array8.count; i++) {
                [_set addIndex:[array7 indexOfObject:array8[i]]];
                [array7 replaceObjectAtIndex:[array7 indexOfObject:array8[i]] withObject:@""];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *search= [[self.networkArray objectsAtIndexes:_set]mutableCopy];
                for (NSDictionary *searchdic in search) {
                    ContactModel *model = [ContactModel yy_modelWithDictionary:searchdic];
                    [self.searchDataArray addObject:model];
                }

                [_tableView reloadData];
            });
        });
    }else
    {
        if (searchController.searchBar.text.length==0) {
            for (NSDictionary *searchdic in self.networkArray) {
                ContactModel *model = [ContactModel yy_modelWithDictionary:searchdic];
                [self.searchDataArray addObject:model];
            }
            [_tableView reloadData];
        }
        else{
            _searchDataArray = nil;
            [_tableView reloadData];
        }
    }
}

#pragma  mark  UISearchControllerDelegate 实现
- (void)willPresentSearchController:(UISearchController *)searchController
{
    DDLogVerbose(@"搜索即将出现");
    _tableView.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight);
    searchController.searchBar.backgroundColor = ZDBackgroundColor;
}
- (void)willDismissSearchController:(UISearchController *)searchController
{
    DDLogVerbose(@"视图即将消失");
    [UIView animateWithDuration:0.1 animations:^{
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    }];
    [_tableView reloadData];
}
#pragma  mark   hud 显示
- (void) viewDidLayoutSubviews
{
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
    }
}

#pragma  mark  添加好友
- (void)createRightButton
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"添加朋友" Withtarget:self Selector:@selector(showa)];
}
- (void)showa
{
    NewOrEditPersonViewController *new = [[NewOrEditPersonViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:new animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    DDLogVerbose(@"没有内存泄漏");
}
/*
#pragma  mark  mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
