//
//  PrintVM.m
//  zhundao
//
//  Created by zhundao on 2017/6/29.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PrintVM.h"
#import "TscCommand.h"
@implementation PrintVM
- (void)checkWithboolArray :(NSMutableArray *)boolArray tableView:(UITableView *)tableView section :(NSInteger)section
{
    NSInteger a = [boolArray indexOfObject:@"1"];
    NSIndexPath  *indexPath = [NSIndexPath indexPathForRow:a inSection:section];
    UITableViewCell *cell =(UITableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (NSMutableArray *)changeArray :(NSMutableArray *)array row :(NSInteger )row
{
    [array removeObject:@"1"];
    [array addObject:@"0"];
    [array replaceObjectAtIndex:row withObject:@"1"];
    return array;
}

//- (NSArray *)getSize
//{
//    NSArray *array = nil;
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"sizeArray"]) {
//        array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"sizeArray"] copy];
//    }else{
//        array = @[@"0",@"1",@"0"];
//        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"sizeArray"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//    }
//    return array;
//}
- (BOOL)getFlag
{
    BOOL flag;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"])
    {
        flag = [[NSUserDefaults standardUserDefaults]boolForKey:@"printFlag"] ;
    }else
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"printFlag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        flag =  NO;
    }
    return flag;
}

- (NSArray *)getModel
{
    NSMutableArray *array =nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"modelSelArray"]) {
        array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"modelSelArray"] mutableCopy];
        if (array.count!=4) {
            [array addObject:@"0"];
        }
    }else{
        NSArray  *array1 = @[@"1",@"0",@"0",@"0"];
        array = [NSMutableArray array];
        [array addObjectsFromArray:array1];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"modelSelArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return array;
}

- (NSArray *)getActive
{
    NSArray *array =nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"activeSelArray"]) {
        array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"activeSelArray"] copy];
    }else{
        array = @[@"1",@"0"];
        [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"activeSelArray"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    return array;
}

- (NSString *)getOffsetX
{
    NSString  *a  =nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"printX"]) {
        a = [[NSUserDefaults standardUserDefaults]objectForKey:@"printX"];
    }else
    {
        a = @"0";
        [[NSUserDefaults standardUserDefaults]setObject:a forKey:@"printX"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return  a;
}
- (NSString *)getOffsetY
{
     NSString  *a  =nil;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"printY"]) {
        a = [[NSUserDefaults standardUserDefaults]objectForKey:@"printY"];
    }else
    {
         a = @"0";
        [[NSUserDefaults standardUserDefaults]setObject:a forKey:@"printY"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    return  a;
}
- (void)printTextIsPrint :(BOOL)isPrint offsetx :(int )x offsety :(int)y  textArray :(NSArray *)textArray
{
    TscCommand *tscCmd = [self setTscCmd:isPrint];
    /*
     打印多行标签文本
     */
    NSString *str = nil;
    for (int i = 0; i <textArray.count; i++) {
        str = textArray[i ];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] } context:nil];
        [tscCmd addTextwithX:x + 100 -rect.size.width/2
                       withY:(40+40*i)+y
                    withFont:@"TSS24.BF2"
                withRotation:0
                   withXscal:1
                   withYscal:1
                    withText:str];
    }
    //print
    [tscCmd addPrint:1 :1];
}

/*! 打印二维码 备注 */
- (void)printQRCode :(NSString *)linkStr isPrint :(BOOL)isPrint offsetx :(int )x offsety :(int)y textArray :(NSArray *)textArray{
     TscCommand *tscCmd = [self setTscCmd:isPrint];
    NSInteger index = textArray.count-1;
    switch (index) {
        case 0:
        {
            [self codeDataTscCommand:tscCmd x:75+x y:35+y width:6 str:linkStr];
            NSString *str = nil;
            for (int i = 0; i <textArray.count; i++) {
                str = textArray[i ];
                CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] } context:nil];
                [tscCmd addTextwithX:x + 70 -rect.size.width/2
                               withY:(160+30*i)+y
                            withFont:@"TSS24.BF2"
                        withRotation:0
                           withXscal:1
                           withYscal:1
                            withText:str];
            }
            [tscCmd addPrint:1 :1];
        }
            break;
        case 1:
        {
            [self codeDataTscCommand:tscCmd x:75+x y:20+y width:6 str:linkStr];
            NSString *str = nil;
            for (int i = 0; i <textArray.count; i++) {
                str = textArray[i ];
                CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] } context:nil];
                [tscCmd addTextwithX:x + 70 -rect.size.width/2
                               withY:(150+30*i)+y
                            withFont:@"TSS24.BF2"
                        withRotation:0
                           withXscal:1
                           withYscal:1
                            withText:str];
            }
            [tscCmd addPrint:1 :1];
        }
            break;
        case 2:
        {
            [self codeDataTscCommand:tscCmd x:75+x y:5+y width:6 str:linkStr];
            NSString *str = nil;
            for (int i = 0; i <textArray.count; i++) {
                str = textArray[i ];
                CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] } context:nil];
                [tscCmd addTextwithX:x + 70 -rect.size.width/2
                               withY:(140+30*i)+y
                            withFont:@"TSS24.BF2"
                        withRotation:0
                           withXscal:1
                           withYscal:1
                            withText:str];
            }
            [tscCmd addPrint:1 :1];
        }
            break;
            
        default:
            break;
    }

}

- (void)printQRCode :(NSString *)linkStr isPrint :(BOOL)isPrint offsetx :(int )x offsety :(int)y
{
   TscCommand *tscCmd = [self setTscCmd:isPrint];
//    NSArray *array = [self getSize];
//    NSInteger index = [array indexOfObject:@"1"];
    
//    switch (index) {
//        case 0:
//        {
//            [self codeDataTscCommand:tscCmd x:95+x y:80+y width:4 str:linkStr];
//             [tscCmd addPrint:1 :1];
//        }
//             break;
//        case 1:
//        {
//            [self codeDataTscCommand:tscCmd x:75+x y:50+y width:6 str:linkStr];
//             [tscCmd addPrint:1 :1];
//        }
//             break;
//        case 2:
//        {
            [self codeDataTscCommand:tscCmd x:55+x y:30+y width:8 str:linkStr];
             [tscCmd addPrint:1 :1];
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (void)printQRCode :(NSString *)linkStr name :(NSString *)name isPrint :(BOOL)isPrint offsetx :(int )x offsety :(int)y
{
    TscCommand *tscCmd = [self setTscCmd:isPrint];
//    NSArray *array = [self getSize];
//    NSInteger index = [array indexOfObject:@"1"];
    CGRect rect = [name boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17] } context:nil];
    
//    switch (index) {
//        case 0:
//        {
//            [self codeDataTscCommand:tscCmd x:95+x y:60+y width:4 str:linkStr];
//            [self codeTscCommand:tscCmd x:30-rect.size.width/2 y:110 name:name];
//            [tscCmd addPrint:1 :1];
//        }
//            break;
//        case 1:
//        {
//             [self codeDataTscCommand:tscCmd x:75+x y:50+y width:6 str:linkStr];
//            [self codeTscCommand:tscCmd x:50-rect.size.width/2 y:150 name:name];
//            [tscCmd addPrint:1 :1];
//        }
//            break;
//        case 2:
//        {
            [self codeDataTscCommand:tscCmd x:55+x y:10+y width:8 str:linkStr];
             [self codeTscCommand:tscCmd x:70 -rect.size.width/2 y:185 name:name];   //x和坐标原点相同居中
            [tscCmd addPrint:1 :1];
//        }
//            break;
//        default:
//            break;
//    }
}
- ( TscCommand *)setTscCmd :(BOOL)isPrint{
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:isPrint];
    [tscCmd addSize:30 :30];
    [tscCmd addGapWithM:2   withN:0];
    [tscCmd addSpeed:4];
    [tscCmd addDensity:8];
    [tscCmd addDirection:0];
    [tscCmd addComonCommand];
    [tscCmd addCls];
    return tscCmd;
}

- (void)codeDataTscCommand:(TscCommand *)tscCmd x :(int)x y :(int)y  width :(int)width str :(NSString *)str
{
    [tscCmd addReference:x
                        :y];
    [tscCmd addQRCode:0
                     :4
                     :@"L"
                     :width
                     :@"A"
                     :0
                     :str];
}


-(void)codeTscCommand:(TscCommand *)tscCmd x :(int)x y :(int)y name :(NSString *)name
{
    [tscCmd addTextwithX:x
                   withY:y
                withFont:@"TSS24.BF2"
            withRotation:0
               withXscal:1
               withYscal:1
                withText:name];

}

@end
