//
//  ListViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//
#import "ListViewController.h"
#import "listModel.h"
#import "SignleListViewController.h"
#import "ListTableViewCell.h"
#import "JQIndicatorView.h"
#import "Reachability.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSString *accesskey;
    NSMutableArray *dataarr;
    NSMutableArray *_dataArray;
    ListTableViewCell *mycell;
    NSString *listuser;
     Reachability *r;
}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    listuser = [NSString stringWithFormat:@"%li",(long)self.listID];
   self.title = @"名单";
    [self getaccseekey];
     [self createTableView];
  
    [self firstload];
}
- (void)firstload
{
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"wu");
        {
            
            NSMutableArray *muarray = [NSMutableArray array];
            NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:listuser];
            for (int i=0; i<array1.count; i++)
            {
                NSDictionary *acdic = [array1 objectAtIndex:i];
               
                
                listModel *model = [listModel yy_modelWithJSON:acdic];
                model.count = i+1;
                [muarray addObject:model];
            }
            _dataArray = [muarray copy];
            
            [_table reloadData];

            
          
            
          
            break;
        }
            
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"wan");
         [self loadData];
           
            
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            [self loadData];
            
        
            break;
    }
}


- (void)createTableView
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor colorWithRed:235.00f/255.00f green:235.00f/255.00f blue:235.00f/255.00f alpha:1];
    _table.separatorStyle = NO;
    [_table registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    [self.view addSubview:_table];
}

- (void)getaccseekey
{
    NSString *acc =[[NSUserDefaults standardUserDefaults]objectForKey:AccessKey];
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:WX_UNION_ID];
    if (acc) {
        accesskey = [acc copy];
    }
    if (uid) {
        accesskey = [uid copy];
    }
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
- (void)loadData    //网络加载数据
{
    JQIndicatorView *indicator = [[JQIndicatorView alloc]initWithType:3 tintColor: [UIColor colorWithRed:9.00f/255.0f green:187.00f/255.0f blue:7.00f/255.0f alpha:1] size:CGSizeMake(90, 70)];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerActivity/PostActivityListed?accessKey=%@",accesskey];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    NSDictionary *dic = @{@"activityId":[NSString stringWithFormat:@"%li",(long)self.listID],
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    [manager POST:listurl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array1 = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        dataarr = [NSMutableArray array];
                for (int i=0; i<array1.count; i++)
                {
                    NSDictionary *acdic = [array1 objectAtIndex:i];
                    
                    
                    
                    
                    listModel *model = [listModel yy_modelWithJSON:acdic];
                    model.count = i+1;
                    {
                        NSMutableDictionary *e = [NSMutableDictionary dictionary];
                     
                       [muarray addObject:model];
                            for (NSString *keystr in acdic.allKeys) {
        
                                if ([[acdic objectForKey:keystr] isEqual:[NSNull null]]) {
                                    //
                                    [e setObject:@"" forKey:keystr];
                                }
                                else
                                {
                                    [e setObject:[acdic objectForKey:keystr] forKey:keystr];
                                }
                            }
        
                            [dataarr addObject:e];
                        
      
                    }
        
         [indicator stopAnimating];
                
                }
        [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:listuser];
        [[NSUserDefaults standardUserDefaults]synchronize];
        _dataArray = [muarray copy];
        
         [_table reloadData];
      
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell"];
    if (cell==nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listcell"];
    }
    cell.model = _dataArray[indexPath.row];
    cell.listCount.text =[NSString stringWithFormat:@"%li",(long)cell.model.count];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAll:)];
    [cell addGestureRecognizer:tap];
    return cell;
    
}
- (void)pushAll:(UITapGestureRecognizer *)tap
{
    
    mycell = (ListTableViewCell *)tap.view;
    SignleListViewController *signle = [[SignleListViewController alloc]init];
    signle.listID = mycell.model.ID;
    [self  setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:signle animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
