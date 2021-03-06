//
//  OnePersonDataNetWork.m
//  zhundao
//
//  Created by zhundao on 2017/4/14.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "OnePersonDataNetWork.h"
@interface OnePersonDataNetWork()

@end
@implementation OnePersonDataNetWork
//GET api/PerActivity/GetSingleActivityList?accessKey={accessKey}&activityListId={activityListId}


- (void)getNewList :(NSInteger)listID BackBlock :(backBlock)backBlock {
    NSString *listurl = [NSString stringWithFormat:@"%@api/PerActivity/PostActivityListed?accessKey=%@",zhundaoApi,[[SignManager shareManager] getaccseekey]];
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
