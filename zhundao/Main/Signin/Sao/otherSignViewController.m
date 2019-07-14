//
//  otherSignViewController.m
//  zhundao
//
//  Created by zhundao on 2017/3/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "otherSignViewController.h"
#import "signResult.h"
#import "Time.h"
@interface otherSignViewController ()<UITextFieldDelegate>
{
    NSInteger i;
    Reachability *r;
    MBProgressHUD *hud;
    NSString *textFieldStr;
    NSInteger flag; //判断是否离线签到成功
    
    NSMutableArray *array;
    NSMutableArray *array1;
    NSMutableArray *array2;
    
    NSMutableArray *dataarr;
    NSMutableArray *dataarr1;
    NSMutableArray *dataarr2;
}
@end

@implementation otherSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = zhundaoBackgroundColor;
    i = 0;
    flag=0;
    array = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"all%li",(long)self.signid]] mutableCopy];
    array1 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"sign%li",(long)self.signid]] mutableCopy];
    array2 = [[[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"signed%li",(long)self.signid]]mutableCopy];
    [self createUI];
      self.modalTransitionStyle =UIModalTransitionStyleFlipHorizontal;
    _textf.delegate =self;
    _textf.keyboardType = UIKeyboardTypeNumberPad;
    [_textf addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location>12) {
        return NO;
    }
    else{
        return YES;
    }
    
}
-(void)textFieldDidEditing:(UITextField *)textField{
    if (textField == _textf) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {//输入
                NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {//输入完成
                textField.text = [textField.text substringToIndex:13];
            }
            i = textField.text.length;
            
        }else if (textField.text.length < i){//删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}
- (void)createUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)]; //顶部黑色视图
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor blackColor];
    
    UIImageView *image = [MyImage initWithImageFrame:CGRectMake(10, 29, 25, 25) imageName:@"nav_back" cornerRadius:0 masksToBounds:NO];
    [self.view addSubview:image];
    UITapGestureRecognizer *imagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backroot)];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:imagetap];
    
    UILabel *topLabel = [MyLabel initWithLabelFrame:CGRectMake(kScreenWidth/2-40, 20, 80, 44) Text:@"管理代签" textColor:[UIColor whiteColor] font: [UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter cornerRadius:0 masksToBounds:NO ];
    [self.view addSubview:topLabel];   //titlelabel 中间
    
    
    _textf = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2-120, 120, 240, 40)];       //输入框
    _textf.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    _textf.placeholder = @"请输入代签的手机号";
    _textf.textAlignment = NSTextAlignmentCenter;
    _textf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textf.layer.cornerRadius = 20;
    _textf.layer.masksToBounds = YES;
    _textf.tintColor = zhundaoGreenColor;
    
    _textf.layer.borderColor = zhundaoGreenColor.CGColor;
    _textf.layer.borderWidth = 1;
    NSMutableParagraphStyle *style = [_textf.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight = _textf.font.lineHeight - (_textf.font.lineHeight - [UIFont systemFontOfSize:13].lineHeight) / 2.0;
    
    _textf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入代签的手机号"];
    [_textf setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:_textf.placeholder attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName : style}]];
    [self.view addSubview:_textf];
    
    
    UIButton *signButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth/2-110, 180, 100, 40) title:@"扫码签到" textcolor:[UIColor whiteColor] Target:self action:@selector(backSao) BackgroundColor: nil cornerRadius:20 masksToBounds:YES];
    [signButton setImage:[UIImage imageNamed:@"saoma-5"] forState:UIControlStateNormal];   //扫码签到按钮
    [signButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [signButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    signButton.layer.borderWidth = 1;
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"扫码签到" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]
                                                                                             ,NSForegroundColorAttributeName:zhundaoGreenColor}];
    
    
    [signButton setAttributedTitle:str forState:UIControlStateNormal];        //确定按钮
    signButton.layer.borderColor = zhundaoGreenColor.CGColor;
    [self.view addSubview:signButton];
    
    UIButton *sureButton = [MyButton initWithButtonFrame:CGRectMake(kScreenWidth/2+10, 180, 100, 40) title:@"确定" textcolor:[UIColor whiteColor] Target:self action:@selector(sure) BackgroundColor: nil cornerRadius:20 masksToBounds:YES];
    
    sureButton.layer.borderWidth = 1;
    
    NSAttributedString *str1 = [[NSAttributedString alloc]initWithString:@"确定" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]
                                                                                            ,NSForegroundColorAttributeName:zhundaoGreenColor}];
    
    
    [sureButton setAttributedTitle:str1 forState:UIControlStateNormal];
    sureButton.layer.borderColor = zhundaoGreenColor.CGColor;
    [self.view addSubview:sureButton];
}
- (void)sure
{   textFieldStr =[_textf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    if ([r currentReachabilityStatus] ==NotReachable) {
        [self NotReachable];
    }
    else
    {
        hud = [MyHud initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:self.view];
        [self haveNet];
    }
   
}


- (FMResultSet *)searchFMResultSet
{
    SignManager *manager = [SignManager shareManager];
    FMResultSet * rs = nil;
    [manager createDatabase];
    if ([manager.dataBase open]) {
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM signList WHERE signID = %li",(long)_signid];
        rs = [manager.dataBase executeQuery:sql];
   }
    return rs;
}
- (void)NotReachable
{
    NSLog(@"没网");
 FMResultSet *rs =[self searchFMResultSet];
    
   while ([rs next]) {
        if ([[rs stringForColumn:@"phone"] isEqualToString:textFieldStr]) {
            flag = 1;
            [self updatapost];
            [self signinwithRs:rs];
            [self removeObject];
        }
       dataarr = [array copy];
        dataarr1 = [array1 copy];
        dataarr2 = [array2 copy];
    }
    if (flag==0) {
        [self signLost];
    }
    [[SignManager shareManager].dataBase close];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"all%li",(long)_signid]];
    
    [[NSUserDefaults standardUserDefaults]setObject:dataarr1 forKey:[NSString stringWithFormat:@"sign%li",(long)_signid]];
    [[NSUserDefaults standardUserDefaults]setObject:dataarr2 forKey:[NSString stringWithFormat:@"signed%li",(long)_signid]];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)signLost
{
     [[SignManager shareManager]showAlertWithTitle:@"扫描结果" WithMessage:@"签到失败 凭证码无效" WithTitleOne:@"返回主界面" WithActionOne:^(TYAlertAction *action1) {
          [self backroot];
     } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"继续签到" WithActionTwo:nil WithCTR:self];
}
- (void)signinwithRs:( FMResultSet *)rs
{
    for (int j=0; j<array.count; j++) {
        NSDictionary *acdic = [array objectAtIndex:j];
        
        NSMutableDictionary *e =  [acdic mutableCopy];
        
        for (NSString *keystr in acdic.allKeys) {
            
            if ([keystr isEqualToString:@"Mobile"]) {
                NSLog(@"status = %@",[acdic valueForKey:@"Status"]);
                if ([[acdic valueForKey:keystr] isEqualToString:textFieldStr]) {
                    
                    if ([[acdic valueForKey:@"Status"]integerValue]==0) {
                        [e  setValue:@"1" forKey:@"Status"];
                        [array removeObjectAtIndex:j];
                        [array addObject:e];
                        [array2 addObject:e];  //array2   已经签到
                        
                        [[signResult alloc]showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"返回主界面" actionWithTitle2:@"继续签到" withAction1:^(TYAlertAction *action1) {
                            [self backroot];
                        } withAction2:^(TYAlertAction *action1) {
                            nil;
                        } otherSign:NO withCtr:self];
                    }
                    if ([[acdic valueForKey:@"Status"]integerValue]==1) {
                        [[signResult alloc]showallWithFMResultSet:rs withdic:acdic actionWithTitle1:@"返回主界面" actionWithTitle2:@"继续签到" withAction1:^(TYAlertAction *action1) {
                            [self backroot];
                        } withAction2:^(TYAlertAction *action1) {
                            nil;
                        } otherSign:NO withCtr:self];
                    }
                }

            }
            
        }
        
        
    }
    

}
- (void)removeObject
{
    for (int j=0; j<array1.count; j++) {
        NSDictionary *acdic = [array1 objectAtIndex:j];
        
        for (NSString *keystr in acdic.allKeys) {
            
            if ([keystr isEqualToString:@"VCode"]) {
                if ([[acdic valueForKey:keystr] isEqualToString:textFieldStr])  {
                    
                    [array1 removeObjectAtIndex:j];
                    break;
                }
            }
        }
    }
}
- (void)updatapost
{
    NSString *timeStr = [[Time alloc]nextDateWithNumber:0];
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET Status = '1'  where phone = '%@' AND signID = %li",textFieldStr,(long)_signid]];   //更新数据库的vcode
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET post = '0'  where phone = '%@' AND signID = %li",textFieldStr,(long)_signid]];
    [ [SignManager shareManager].dataBase executeUpdate:[NSString stringWithFormat:@"UPDATE signList SET addTime = '%@'  where phone = '%@' AND signID = %li",timeStr,textFieldStr,(long)_signid]];

}
-(void)haveNet
{
    NSString *urlstr = [NSString stringWithFormat:@"%@api/CheckIn/AddCheckInListByPhone?accessKey=%@&phone=%@&checkInId=%li&checkInWay=11",zhundaoApi,[[SignManager shareManager] getaccseekey],textFieldStr,(long)self.signid];
    [[AFmanager shareManager]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"responseObject = %@",responseObject);
        NSString *Url = dic[@"Url"];
        NSString *Res = dic[@"Res"];
        NSMutableDictionary *Data = nil;
        if ( ! [dic[@"Data"] isEqual:[NSNull null]]){
            Data =[dic[@"Data"] mutableCopy];
            for (NSString *keystr in Data.allKeys) {
                if ([[Data valueForKey:keystr] isEqual:[NSNull null]]) {
                    [Data setObject:@"" forKey:keystr];
                }
            }
        }
        NSString *phone = nil;
        NSString *Mobile =Data[@"Phone"];
        if (Mobile.length>7) {
            phone = [Mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        }
        [hud hideAnimated:YES];
        if ([Url isEqualToString:@"101"]&&[Res integerValue]==1) {
            [[signResult alloc]getDataWithData:Data WithStringValue:textFieldStr withID:_signid WithSignBool:0 withSigncheckInWay:11 WithPhone:phone Withtitle1:@"返回主界面" Withtitle2:@"继续签到" WithAction1:^(TYAlertAction *action1) {
                [self backroot];
            } WithAction1:^(TYAlertAction *action1) {
                nil;
            } otherSign:NO WithCtr:self];
        }
        else  if ([Url isEqualToString:@"100"]&&[Res integerValue]==0) {
            [[signResult alloc]getDataWithData:Data WithStringValue:textFieldStr withID:_signid WithSignBool:1 withSigncheckInWay:11 WithPhone:phone Withtitle1:@"返回主界面" Withtitle2:@"继续签到" WithAction1:^(TYAlertAction *action1) {
                [self backroot];
            } WithAction1:^(TYAlertAction *action1) {
                nil;
            } otherSign:NO WithCtr:self];
        }
        else {
            [[SignManager shareManager]showAlertWithTitle:@"扫描结果" WithMessage:@"签到失败 凭证码无效"  WithTitleOne:@"返回主界面" WithActionOne:^(TYAlertAction *action1) {
                [self backroot];
            } WithAlertStyle:TYAlertActionStyleDefault WithTitleTwo:@"继续签到"  WithActionTwo:nil WithCTR:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (hud) {
                [hud hideAnimated: YES];
        }
        NSLog(@"error = %@",error);
    }];
}
- (void)backroot
{
        UIViewController *rootVC = self.presentingViewController;
    
        while (rootVC.presentingViewController) {
            rootVC = rootVC.presentingViewController;
        }
        [rootVC dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)backSao
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
