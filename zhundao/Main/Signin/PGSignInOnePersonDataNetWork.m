#import "PGDeviceOrientationLandscape.h"
//
//  PGSignInOnePersonDataNetWork.m
//  zhundao
//
//  Created by zhundao on 2017/4/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGSignInOnePersonDataNetWork.h"
@interface PGSignInOnePersonDataNetWork()

@end
@implementation PGSignInOnePersonDataNetWork
//GET api/PerActivity/GetSingleActivityList?accessKey={accessKey}&activityListId={activityListId}


- (void)getNewList :(NSInteger)listID BackBlock :(backpopBlock)backBlock {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * codeLoginViewi6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    codeLoginViewi6.contentMode = UIViewContentModeCenter; 
    codeLoginViewi6.clipsToBounds = NO; 
    codeLoginViewi6.multipleTouchEnabled = YES; 
    codeLoginViewi6.autoresizesSubviews = YES; 
    codeLoginViewi6.clearsContextBeforeDrawing = YES; 
        NSRange objectsUsingBlockw9 = NSMakeRange(4,202); 
    PGDeviceOrientationLandscape *orderGroupCell= [[PGDeviceOrientationLandscape alloc] init];
[orderGroupCell cellReuseIdentifierWithwithReuseIdentifier:codeLoginViewi6 sliderSeekTime:objectsUsingBlockw9 ];
});
    NSString *listurl = [NSString stringWithFormat:@"%@api/PerActivity/PostActivityListed?accessKey=%@",zhundaoApi,[[PGSignManager shareManager] getaccseekey]];
    NSDictionary *dic = @{@"activityId":[NSString stringWithFormat:@"%li",(long)listID],
                          @"pageSize":@"1000",
                          @"curPage":@"1"};
    [ZD_NetWorkM postDataWithMethod:listurl parameters:dic succ:^(NSDictionary *obj) {
        NSDictionary *result = [NSDictionary dictionaryWithDictionary:obj];
        NSArray *array1 = result[@"Data"];
        NSMutableArray  *dataarr = [NSMutableArray array];
        
        for (int i=0; i<array1.count; i++)
        {
            NSDictionary *acdic = [array1 objectAtIndex:i];
            {
                NSMutableDictionary *e = [NSMutableDictionary dictionary];
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
            
            
        }
        [[NSUserDefaults standardUserDefaults]setObject:dataarr forKey:[NSString stringWithFormat:@"%li",(long)listID]];
        [[NSUserDefaults standardUserDefaults]synchronize];
        backBlock(dataarr);
    } fail:^(NSError *error) {
        
    }];
}

@end
