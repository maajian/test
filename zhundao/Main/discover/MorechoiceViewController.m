//
//  MorechoiceViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/17.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MorechoiceViewController.h"
#import "maskLabel.h"

#import "UpDataViewController.h"
#import "BaseNavigationViewController.h"
@interface MorechoiceViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_dataarray;
    UITextField *chooseTextField;
    UIImageView *_deleteImage;
    UIView *imageSelectView;
    UIView *zheview;
    NSMutableDictionary *textDic;
    UIView *footerView ;
    BOOL switchFlag;
}
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation MorechoiceViewController
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)sureButton:(id)sender {
    NSInteger a =0;
    for (int i=0; i<textDic.count; i++) {
        NSString *value1 = [textDic objectForKey:[NSString stringWithFormat:@"%i",i]];
        for (int j=i+1; j<textDic.count; j++) {
            NSString *value2 = [textDic objectForKey:[NSString stringWithFormat:@"%i",j]];
            if ([value1 isEqualToString:value2]) {
                a = 1;
            }
        }
    }
    if (a==1) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"选项不能相同"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }
   else if ([_textView.text isEqualToString:@"请输入项目名称"]||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"输入框不能为空"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }
    else if (textDic.count!= _dataarray.count) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"选项不能为空"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }
    else
    {
        
        [self sendData];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = @"请输入项目名称";
    _textView.textColor = [UIColor lightGrayColor];
    _textView.delegate =self;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = NO;
    _dataarray = @[@"选项1",@"选项2"];
    textDic =[NSMutableDictionary dictionary];
    switchFlag =YES;
    
    [_switch1 addTarget:self action:@selector(SwitchChange) forControlEvents:UIControlEventValueChanged];

    // Do any additional setup after loading the view from its nib.
}
#pragma  textView delegata
- (void)sendData
{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setObject:_textView.text forKey:@"Title"];
    [sendDic setValue:@"3" forKey:@"InputType"];
    
    NSMutableString *optionStr = [[NSMutableString alloc]init];
    [optionStr appendString:[textDic objectForKey:@"0"]];
    for (int i=1; i<textDic.count; i++) {
        [optionStr appendString:@"|"];
        [optionStr appendString:[textDic objectForKey:[NSString stringWithFormat:@"%d",i]]];
    }
    
    [sendDic setValue:[optionStr copy] forKey:@"Option"];
    if (switchFlag) {
        [sendDic setValue:@"true" forKey:@"Required"];
    }
    else{
        [sendDic setValue:@"false" forKey:@"Required"];
        
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[sendDic copy] options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSString *accesskey = [[SignManager shareManager]getaccseekey];
    NSString *posturl = [NSString stringWithFormat:@"%@api/PerActivity/UpdateOrAddOption?accessKey=%@",zhundaoApi,accesskey];
    
    [ZD_NetWorkM postDataWithMethod:posturl parameters:jsonStr succ:^(NSDictionary *obj) {
        NSLog(@"res = %@",obj);
        if ([obj[@"Res"] integerValue] == 0) {
            if (self.block) {
                self.block([sendDic copy]);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:obj[@"Msg"] message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UpDataViewController *updata = [[UpDataViewController alloc]init];
                updata.isPresent = YES;
                updata.urlString = [NSString stringWithFormat:@"%@Activity/Upgraded?accesskey=%@",zhundaoH5Api,[[SignManager shareManager] getaccseekey]];
                BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:updata];
                [self presentViewController:nav animated:YES completion:nil];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入项目名称"]) {
        textView.text = @"";
    }
    _textView.textColor = [UIColor blackColor];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        textView.text = @"请输入项目名称";
        _textView.textColor = [UIColor lightGrayColor];
    }
    
}

- (void)SwitchChange
{
    switchFlag = !switchFlag;
    NSLog(@"%i",switchFlag);
    if (switchFlag==NO) {
        [_switch1 setOn:NO];
    }
    else{
        [_switch1 setOn:YES];
    }
}
#pragma  textView delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"chooseCell%li",(long)indexPath.row]];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"chooseCell%li",(long)indexPath.row]];
        
    }
    for (UIView *subView in cell.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UIView class]]) {
            [subView removeFromSuperview];
        }
    }
    zheview = [[UIView alloc]init];
    [cell addSubview:zheview];
    imageSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    imageSelectView.tag = indexPath.row;
    [cell addSubview:imageSelectView];
    
    chooseTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth-50, 44)];
    chooseTextField.tag = indexPath.row+100;
    chooseTextField.delegate = self;
    _deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 20, 20)];
    _deleteImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [cell addSubview:chooseTextField];
    
    for (NSString *keyStr in textDic.allKeys) {
        if ([keyStr integerValue]==indexPath.row) {
            chooseTextField.text = [textDic objectForKey:keyStr];
        }
    }
    
    [imageSelectView addSubview:_deleteImage];
    chooseTextField.placeholder = _dataarray[indexPath.row];
    chooseTextField.font = [UIFont systemFontOfSize:14];
    
    if (_dataarray.count>2) {
        _deleteImage.image =  [UIImage imageNamed:@"deleteCan"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteView:)];
        imageSelectView.userInteractionEnabled = YES;
        
        [imageSelectView addGestureRecognizer:tap];
    }
    if (_dataarray.count<=2) {
        
        _deleteImage.image =  [UIImage imageNamed:@"deleteCant"];
        imageSelectView.userInteractionEnabled = NO;
    }
    
    
    zheview.backgroundColor = [UIColor colorWithRed:186.00f/255.00f green:187.00f/255.00f blue:192.00f/255.00f alpha:1];
    
    [zheview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.mas_bottom).with.offset(-1);
        make.right.equalTo(cell.mas_right).with.offset(0);
        make.height.mas_equalTo(@0.5);
        make.left.equalTo(cell.mas_left).with.offset(15);
    }];
    
    return cell;
}
- (void)deleteView:(UITapGestureRecognizer *)tap
{
    NSMutableArray *array = [_dataarray mutableCopy];
    NSInteger delete =0;
    if (textDic.count==0) {
        delete=0;
    }
    else
    {
        for (int i=0; i<textDic.count; i++)  {
            NSString *keyStr = textDic.allKeys[i];
            if ([keyStr integerValue] ==tap.view.tag) {
                [array removeLastObject];
                [textDic removeObjectForKey:keyStr];
                delete=1;
            }
            
        }
    }
    if (delete==0) {
        [array removeLastObject];
    }
    NSMutableArray *arr = [textDic.allKeys mutableCopy];
    for (int i=0; i<arr.count; i++) {
        for (int j=i+1; j<arr.count; j++) {
            if ([arr[i] integerValue]>[arr[j] integerValue]) {
                NSInteger a,b,temp;
                a = [arr[i] integerValue];
                b= [arr[j] integerValue];
                
                
                
                
                temp =a;
                a = b;
                b= temp;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%li",(long)a]];
                [arr replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%li",(long)b]];
                NSLog(@"arr =%@",arr);
            }
        }
    }

    for (int i=0; i<arr.count; i++)  {
        NSInteger a = [arr[i] integerValue];
   
        if (a>tap.view.tag) {
            NSString *valuestr = [textDic valueForKey:arr[i]];
            [textDic removeObjectForKey:arr[i]];
            [textDic setObject:valuestr forKey:[NSString stringWithFormat:@"%li",(long)a-1]];
        }
    }
    _dataarray = [array copy];
    [_tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataarray.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [_tableview reloadData];

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSInteger a = (long)textField.tag-100;
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0) {
        [textDic setObject:textField.text forKey:[NSString stringWithFormat:@"%li",(long)a]];
    }
    else
    {
        textField.text = @"";
        if ([textDic objectForKey:[NSString stringWithFormat:@"%li",(long)a]]!=nil) {
            [textDic removeObjectForKey:[NSString stringWithFormat:@"%li",(long)a]];
        }
    }
    footerView.hidden = NO;
    //      NSLog(@"dic = %@",textDic);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"view = %f",footerView.frame.origin.y);
    [UIView animateWithDuration:3 animations:^{
        footerView.hidden = YES;
    } completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 20, 20)];
    [footerView addSubview:imageview];
    
    imageview.image = [UIImage imageNamed:@"addChoose"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth-50, 44)];
    label.text = @"增加选项";
    label.textAlignment =NSTextAlignmentLeft;
    [footerView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    footerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap)];
    [footerView addGestureRecognizer:tap];
    return footerView;
}
- (void)viewTap
{
    NSMutableArray *array = [_dataarray mutableCopy];
    [array addObject:[NSString stringWithFormat:@"选项%li",(unsigned long)_dataarray.count+1]];
    _dataarray = [array copy];
    [_tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:array.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableview reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section

{
    return 44;
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
