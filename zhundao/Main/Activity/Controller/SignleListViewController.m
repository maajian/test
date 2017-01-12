//
//  SignleListViewController.m
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import "SignleListViewController.h"
#import "SignleModel.h"
#import "Reachability.h"
@interface SignleListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSMutableArray *_dataArray;
    NSMutableArray *_dataArray1;
    
    NSMutableArray *_allInfoArray;
    NSMutableArray *_allInfoArray1;
    
    NSMutableArray *_idarray;
    NSString *accesskey;
    NSString *Remarkstr;
     Reachability *r;
    double flag;
    NSString *listTitle;
    NSInteger sign;
    NSArray *ActivityOptionslast;
    UITableViewCell *cell;
}
@end

@implementation SignleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"个人信息";
    flag = 0;
    [self getaccseekey];
      [self createTableView];
     [self network];

    // Do any additional setup after loading the view.
}
- (void)network
{
    
    
    //获取网络状态
    r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:{
        
        NSDictionary *datadic = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"list%li",(long)self.listID]]copy];
        NSLog(@"datadic = %@",datadic);
            if (datadic) {
          
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        NSMutableArray *infoarray = [NSMutableArray array];
        NSMutableArray *infoarray1 = [NSMutableArray array];
        NSMutableArray *imageArray = [NSMutableArray array];
        NSMutableArray *imageArray1 = [NSMutableArray array];

        for (NSString *keystr in datadic.allKeys) {
          
                if ([keystr  isEqualToString:@"UserName"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                    [muarray addObject:@"姓名"];
                    [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                }
                if ([keystr isEqualToString:@"Mobile"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"手机"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                }
                if ([keystr isEqualToString:@"Company"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"单位"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                }
                if ([keystr isEqualToString:@"Sex"]) {
                    
                    if ([[[datadic valueForKey:keystr]stringValue] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {if ([[datadic objectForKey:keystr]integerValue]==1) {
                        [muarray addObject:@"性别"];
                        [muarray1 addObject:@"男"];
                    }
                        if ([[datadic objectForKey:keystr]integerValue]==2) {
                            [muarray addObject:@"性别"];
                            [muarray1 addObject:@"女"];
                        }
                        else
                        {
                            continue;
                        }

                    }
                    
            }
                if ([keystr isEqualToString:@"Depart"]) {
                    
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"部门"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
            }
                if ([keystr isEqualToString:@"Industry"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"行业"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }

                }
                if ([keystr isEqualToString:@"Duty"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"职务"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                }
                if ([keystr isEqualToString:@"IDcard"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"身份证"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                }
                if ([keystr isEqualToString:@"Email"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"邮箱"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }

                }
                if ([keystr isEqualToString:@"Remark"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                       Remarkstr = [NSString stringWithFormat:@"%@",[datadic objectForKey:keystr]];
                    }
                } if ([keystr isEqualToString:@"Num"]) {
                    if ([[[datadic valueForKey:keystr]stringValue] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        if ([[datadic objectForKey:keystr]integerValue]!=0) {
                            [muarray addObject:@"参与人数"];
                            [muarray1 addObject:[[datadic objectForKey:keystr] stringValue]];
                        }
                    }
                }
                if ([keystr isEqualToString:@"Address"]) {
                    if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                        continue;
                    }
                    else
                    {
                        [muarray addObject:@"地址"];
                        [muarray1 addObject:[datadic objectForKey:keystr]];
                    }
                
            }
            if ([keystr isEqualToString:@"Amount"]) {
                if ([[[datadic valueForKey:keystr]stringValue] isEqualToString:@""]) {
                    continue;
                }
                if ([[datadic objectForKey:keystr]doubleValue]!=0) {
                    flag=[[datadic objectForKey:keystr]doubleValue];
                    [muarray addObject:@"付款信息"];
                    [muarray1 addObject:[[datadic objectForKey:keystr]stringValue ]];
                }
                if ([[datadic objectForKey:keystr]doubleValue]==0) {
                    continue;
                }
            }
            if ([keystr isEqualToString:@"ActivityOptions"]) {
                
                if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                    continue;
                }
            }
            if ([keystr isEqualToString:@"ExtraInfo"]) {
                if ([[datadic valueForKey:keystr] isEqualToString:@""]) {
                    continue;
                }
                else
                {
                    NSMutableArray *infarr = [NSMutableArray array];
                    NSArray *arr1 = [datadic[@"ExtraInfo"] componentsSeparatedByString:@"\""];
                    for (int i=0; i<arr1.count; i++) {
                        if (i%2==1) {
                            [infarr addObject:[arr1 objectAtIndex:i]];
                        }
                    }
                    for (int k=0; k<infarr.count; k++) {
                        NSString *infokeyStr = [infarr objectAtIndex:k];
                        NSArray *allArray = [infokeyStr componentsSeparatedByString:@"https://joinheadoss.oss-cn"];
                        if (allArray.count==1) {
                            if (k%2==0) {
                                [infoarray addObject:infokeyStr];
                            }
                            if (k%2==1) {
                                [infoarray1 addObject:infokeyStr];
                            }
                        }
                        if (allArray.count==2)
                        {
                            
                            [imageArray addObject:[infarr objectAtIndex:k-1]];
                            
                            [infoarray removeObject:[infarr objectAtIndex:k-1]];
                            [imageArray1 addObject:infokeyStr];
                        }
                        
                    }
                }
            }
        }
        {
            
            
            NSArray *ActivityOptions = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"ActivityOptions%li",(long)self.listID]];
            NSMutableArray *muActivityOptions = [NSMutableArray array];
            for (NSString *ActivityOptionsstr in ActivityOptions) {
                if ([ActivityOptionsstr integerValue]!=4) {
                    [muActivityOptions addObject:ActivityOptionsstr];
                }
                
            }
            
            ActivityOptionslast = [muActivityOptions copy];
        }
        _idarray = [NSMutableArray array];
        _allInfoArray = [NSMutableArray array];
        _allInfoArray1 = [NSMutableArray array];
        if (![[datadic objectForKey:@"Title"] isEqualToString:@""]) {
            
            [_allInfoArray addObject:[datadic objectForKey:@"Title"]];
            [_allInfoArray1 addObject:[datadic objectForKey:@"Amount"]];
            [_idarray addObject:@"5"];
        }
        if (Remarkstr) {
            [_allInfoArray addObject:@"备注"];
            [_allInfoArray1 addObject:Remarkstr];
            [_idarray addObject:@"6"];
        }
        [_allInfoArray addObjectsFromArray:infoarray];      //把key 和value相结合
        [_allInfoArray addObjectsFromArray:imageArray];
        [_idarray addObjectsFromArray:ActivityOptionslast];
        for (int i=0; i<imageArray.count; i++) {
            [_idarray addObject:@"4"];
        }
        [_allInfoArray1 addObjectsFromArray:infoarray1];
        [_allInfoArray1 addObjectsFromArray:imageArray1];

        _dataArray1 = [muarray1 mutableCopy];
        _dataArray = [muarray mutableCopy];
        
        
        
        [_table reloadData];

        }
            break;
        }
        case ReachableViaWWAN:{
            // 使用3G网络
            NSLog(@"wan");
          
            [self loadData];
            
            break;
        }
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
    
    NSString *listurl = [NSString stringWithFormat:@"https://open.zhundao.net/api/PerActivity/GetSingleActivityList?accessKey=%@&activityListId=%li",accesskey,(long)self.listID];
    AFHTTPSessionManager *manager = [AFmanager shareManager];
    [manager GET:listurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:responseObject];
        NSDictionary *datadic = result[@"Data"];
        NSMutableArray *muarray = [NSMutableArray array];
        NSMutableArray *muarray1 = [NSMutableArray array];
        
        
        NSMutableArray *infoarray = [NSMutableArray array];
        NSMutableArray *infoarray1 = [NSMutableArray array];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        NSMutableArray *imageArray1 = [NSMutableArray array];
         NSMutableDictionary *e = [NSMutableDictionary dictionary];
        for (NSString *keystr in datadic.allKeys) {
            if ([[datadic objectForKey:keystr] isEqual:[NSNull null]]) {
                //
                [e setObject:@"" forKey:keystr];
            }
            else
            {
               
                [e setObject:[datadic objectForKey:keystr] forKey:keystr];
                if ([keystr  isEqualToString:@"UserName"]) {
                    [muarray addObject:@"姓名"];
                    [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"Mobile"]) {
                    [muarray addObject:@"手机"];
                 [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"Company"]) {
                    [muarray addObject:@"单位"];
                   [muarray1 addObject:[datadic objectForKey:keystr]];                }
                if ([keystr isEqualToString:@"Sex"]) {
                    if ([[datadic objectForKey:keystr]integerValue]==1) {
                        [muarray addObject:@"性别"];
                        [muarray1 addObject:@"男"];
                    }
                    if ([[datadic objectForKey:keystr]integerValue]==2) {
                        [muarray addObject:@"性别"];
                        [muarray1 addObject:@"女"];
                    }
                    else
                    {
                        continue;
                    }
                }
                if ([keystr isEqualToString:@"Depart"]) {
                    [muarray addObject:@"部门"];
                   [muarray1 addObject:[datadic objectForKey:keystr]];                }
                if ([keystr isEqualToString:@"Industry"]) {
                    [muarray addObject:@"行业"];
                 [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"Duty"]) {
                    [muarray addObject:@"职务"];
                   [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"IDcard"]) {
                    [muarray addObject:@"身份证"];
                  [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"Email"]) {
                    [muarray addObject:@"邮箱"];
                  [muarray1 addObject:[datadic objectForKey:keystr]];
                }
                if ([keystr isEqualToString:@"Remark"]) {
                     Remarkstr = [NSString stringWithFormat:@"%@",[datadic objectForKey:keystr]];
                } if ([keystr isEqualToString:@"Num"]) {
                    if ([[datadic objectForKey:keystr]integerValue]!=0) {
                        [muarray addObject:@"参与人数"];
                        [muarray1 addObject:[[datadic objectForKey:keystr] stringValue]];
                    }
                }
                if ([keystr isEqualToString:@"Address"]) {
                    [muarray addObject:@"地址"];
                    [muarray1 addObject:[NSString stringWithFormat:@"%@",[datadic objectForKey:keystr]]];
                }
                if ([keystr isEqualToString:@"Amount"]) {
                    if ([[datadic objectForKey:keystr]doubleValue]!=0) {
                      
                        flag=[[datadic objectForKey:keystr]doubleValue];
                    }
                     if ([[datadic objectForKey:keystr]doubleValue]==0) {
                         continue;
                    }
                }
                if ([keystr isEqualToString:@"Title"]) {
                    listTitle = [datadic objectForKey:@"Title"];
                }
                if ([keystr isEqualToString:@"ActivityOptions"]) {
                    NSArray *ActivityOptions =   datadic[@"ActivityOptions"];
                    NSMutableArray *muActivityOptions = [NSMutableArray array];
                    for (NSDictionary *ActivityOptionsdic in ActivityOptions) {
                        if ([[ActivityOptionsdic objectForKey:@"InputType"]integerValue]!=4) {
                             [muActivityOptions addObject:[ActivityOptionsdic objectForKey:@"InputType"]];
                        }
                    }
                    [e setObject:@"" forKey:keystr];
                    ActivityOptionslast = [muActivityOptions copy];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:ActivityOptionslast forKey:[NSString stringWithFormat:@"ActivityOptions%li",(long)self.listID]];
                }
                if ([keystr isEqualToString:@"ExtraInfo"]) {
                    {
                        NSMutableArray *infarr = [NSMutableArray array];
                        NSArray *arr1 = [datadic[@"ExtraInfo"] componentsSeparatedByString:@"\""];
                        for (int i=0; i<arr1.count; i++) {
                            if (i%2==1) {
                                [infarr addObject:[arr1 objectAtIndex:i]];
                            }
                        }
                        for (int k=0; k<infarr.count; k++) {
                            NSString *infokeyStr = [infarr objectAtIndex:k];
                            NSArray *allArray = [infokeyStr componentsSeparatedByString:@"https://joinheadoss.oss-cn"];
                                if (allArray.count==1) {
                                    if (k%2==0) {
                                         [infoarray addObject:infokeyStr];
                                    }
                                    if (k%2==1) {
                                        [infoarray1 addObject:infokeyStr];
                                    }
                                }
                                if (allArray.count==2)
                                {
                                   
                                        [imageArray addObject:[infarr objectAtIndex:k-1]];
                                
                                    [infoarray removeObject:[infarr objectAtIndex:k-1]];
                                        [imageArray1 addObject:infokeyStr];
                                }
                       
                        
                            if ([infokeyStr isEqual:[NSNull null]]) {
                                [e setObject:@"" forKey:keystr];
                            }
                        }
                        }
                    
                    }
            }
        }
        _idarray = [NSMutableArray array];
        _allInfoArray = [NSMutableArray array];
        _allInfoArray1 = [NSMutableArray array];
        if (![[datadic objectForKey:@"Title"] isEqual:[NSNull null]]) {
            
        [_allInfoArray addObject:[datadic objectForKey:@"Title"]];
        [_allInfoArray1 addObject:[datadic objectForKey:@"Amount"]];
            [_idarray addObject:@"5"];
        }
        if (Remarkstr) {
            [_allInfoArray addObject:@"备注"];
            [_allInfoArray1 addObject:Remarkstr];
            [_idarray addObject:@"6"];
        }
        [_allInfoArray addObjectsFromArray:infoarray];      //把key 和value相结合
        [_allInfoArray addObjectsFromArray:imageArray];
        [_idarray addObjectsFromArray:ActivityOptionslast];
        for (int i=0; i<imageArray.count; i++) {
            [_idarray addObject:@"4"];
        }
        [_allInfoArray1 addObjectsFromArray:infoarray1];
        [_allInfoArray1 addObjectsFromArray:imageArray1];

        
        
        
        
        
        
        NSDictionary *redic = [e copy];
      
        _dataArray1 = [muarray1 mutableCopy];
        _dataArray = [muarray mutableCopy];
     
        [[NSUserDefaults standardUserDefaults]setObject:redic forKey:[NSString stringWithFormat:@"list%li",(long)self.listID]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [indicator stopAnimating];
        [_table reloadData];
        
        }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);

    }];
        

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1+_allInfoArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section==0) {
        return _dataArray.count;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell"];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signlecell"];
            cell.userInteractionEnabled = NO;
        }
        for (UIView *subView in cell.subviews) {
            
            if ([subView isKindOfClass:[UILabel class]]) {
                [subView removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 5,65, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = _dataArray[indexPath.row];
        [cell addSubview:label];
        UILabel *label1= [[UILabel alloc]initWithFrame:CGRectMake(86, 5, kScreenWidth-96, 30)];
        label1.font = [UIFont systemFontOfSize:15];
        label1.textAlignment = NSTextAlignmentRight;
        label1.text = _dataArray1[indexPath.row];
        label1.textColor = [UIColor lightGrayColor];
        [cell addSubview:label1];
        
    }
    if (indexPath.section>0) {
        if ([_idarray[indexPath.section-1]integerValue]==1||[_idarray[indexPath.section-1]integerValue]==6||[_idarray[indexPath.section-1]integerValue]==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell1"];
            if (cell==nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signlecell1"];
                cell.userInteractionEnabled = NO;
            }
            for (UIView *subView in cell.subviews) {
                NSLog(@"subviews = %@",cell.subviews);
                if ([subView isKindOfClass:[UILabel class]]) {
                    [subView removeFromSuperview];
                }
            }
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10,0,kScreenWidth-20, 0)];
                    label.font = [UIFont systemFontOfSize:15];
                    label.textAlignment = NSTextAlignmentRight;
                    label.text = _allInfoArray1[indexPath.section-1];
                    label.numberOfLines = 0;
                    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                    CGSize size1 = [_allInfoArray1[indexPath.section-1] boundingRectWithSize:label.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                        NSLog(@"%f",size1.height);
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:0.5];
            NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSKernAttributeName : @(0.1f)}];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
            
            label.attributedText = attributedString;
                    label.frame = CGRectMake(10, 2, kScreenWidth-20, size1.height+2);
                        NSLog(@"text = %@",label.text);
                    [cell addSubview:label];
        }
       else if ([_idarray[indexPath.section-1]integerValue]==5) {
          cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell2"];
           if (cell==nil) {
               cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signlecell2"];
               cell.userInteractionEnabled = NO;
           }
           for (UIView *subView in cell.subviews) {
               
               if ([subView isKindOfClass:[UILabel class]]) {
                   [subView removeFromSuperview];
               }
           }
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 2,120, 25)];
                    label.font = [UIFont systemFontOfSize:15];
                    label.textAlignment = NSTextAlignmentLeft;
                    label.text = listTitle;
                    [cell addSubview:label];
                    UILabel *label1= [[UILabel alloc]initWithFrame:CGRectMake(86, 2, kScreenWidth-96, 25)];
                    label1.font = [UIFont systemFontOfSize:15];
                    label1.textAlignment = NSTextAlignmentRight;
                    label1.text = [NSString stringWithFormat:@"¥%.2f",flag];
                   label1.textColor = [UIColor colorWithRed:8.00f/255.00f green:73.00f/255.00f blue:173.00f/155.00f alpha:1];
                
                    [cell addSubview:label1];
        }
       else if ([_idarray[indexPath.section-1]integerValue]==2||[_idarray[indexPath.section-1]integerValue]==3) {
         cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell3"];
           if (cell==nil) {
               cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signlecell3"];
               cell.userInteractionEnabled = NO;
           }
           for (UIView *subView in cell.subviews) {
               
               if ([subView isKindOfClass:[UILabel class]]) {
                   [subView removeFromSuperview];
               }
           }
            UILabel *label1= [[UILabel alloc]initWithFrame:CGRectMake(86, 0, kScreenWidth-96, 30)];
                    label1.font = [UIFont systemFontOfSize:15];
                    label1.textAlignment = NSTextAlignmentRight;
           label1.text = _allInfoArray1[indexPath.section-1];
           label1.textColor =[UIColor blackColor];
           
                    [cell addSubview:label1];
        }
       else if ([_idarray[indexPath.section-1]integerValue]==4) {
           cell = [tableView dequeueReusableCellWithIdentifier:@"signlecell4"];
           if (cell==nil) {
               cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"signlecell4"];
               cell.userInteractionEnabled = NO;
           }
           for (UIView *subView in cell.subviews) {
               
               if ([subView isKindOfClass:[UIImageView class]]) {
                   [subView removeFromSuperview];
               }
           }
           
           UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
           [imageview sd_setImageWithURL:_allInfoArray1[indexPath.section-1]];
           imageview.contentMode =  UIViewContentModeScaleAspectFit;

           [cell.contentView addSubview:imageview];

           return cell;
       }
        
    }
    return cell;
    
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        sign=0;
        return 40;
      
    }
    if (indexPath.section>0) {
       if ([_idarray[indexPath.section-1]integerValue]==1||[_idarray[indexPath.section-1]integerValue]==6||[_idarray[indexPath.section-1]integerValue]==0||[_idarray[indexPath.section-1]integerValue]==2||[_idarray[indexPath.section-1]integerValue]==3)
       {
           NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
                       CGSize size = [_allInfoArray1[indexPath.section-1] boundingRectWithSize:CGSizeMake(kScreenWidth-20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                       NSLog(@"%f",size.height);
                       return  size.height+10;
       }
          else if ([_idarray[indexPath.section-1]integerValue]==5) {
              return 40;
          }
        else
        {
            return 120;
        }
    }
  
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section>0) {
         UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 200, 30.0)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 10,50,30)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor lightGrayColor];
        label.text = _allInfoArray[section-1];
        label.textAlignment = NSTextAlignmentLeft;
        [customView addSubview:label];
        return customView;
    }
    else
    {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=0) {
        return 40;
    }
    else{
        return 1;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{if (scrollView == _table) {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
