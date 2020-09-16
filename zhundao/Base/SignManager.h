//
//  SignManager.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "maskLabel.h"
#import "MyButton.h"
#import "MyLabel.h"
#import "MyImage.h"
#import "MyHud.h"
#import "myTextField.h"
#import "ActivityModel.h"
@interface SignManager : NSObject
{
    UIViewController *SaveCtr;
    
}
@property(nonatomic,copy)NSString *accesskey;
@property(nonatomic,strong)FMDatabase *dataBase;
@property(nonatomic,assign)CGRect imageRect;

+(SignManager *)shareManager;

- (NSString *)getaccseekey; //获取acckey
 // 获取token
- (NSString *)getToken;

- (void)createDatabase; //创建数据库

- (void)showNotHaveNet:(UIView *)View;  //没有网络的界面显示

- (void)saveImageWithFrame:(CGRect) rect
                WithCtr:(UIViewController *)Ctr
                
;

- (void)shareImagewithModel:(ActivityModel *)model withCTR:(UIViewController *)ctr Withtype:(NSInteger)type withImage :(UIImage *)image;  // 保存图片至相册
- (void)shareWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle thumImage:(UIImage *)thumImage webpageUrl:(NSString *)webpageUrl withCTR:(UIViewController *)ctr Withtype:(NSInteger)type;

- (void)saveData:(NSArray *)array name :(NSString *)name; //保存入本地

- (NSArray *)getArray :(NSString *)name; //从本地取出
@end
