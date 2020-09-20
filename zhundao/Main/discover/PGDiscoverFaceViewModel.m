//
//  PGDiscoverFaceViewModel.m
//  zhundao
//
//  Created by zhundao on 2017/7/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverFaceViewModel.h"

@implementation PGDiscoverFaceViewModel

//http://face.zhundao.net/api/Core/GetDeviceList?accessKey=oX9XjjizWbtuCeHkJRKDwJDvPFEQ&userId=2 //获取列表

//http://face.zhundao.net/api/Core/SyncNewPerson?accessKey=oX9XjjizWbtuCeHkJRKDwJDvPFEQ&deviceKey={deviceKey} //新人同步

//http://face.zhundao.net/api/Core/BindDevice?accessKey=oX9XjjizWbtuCeHkJRKDwJDvPFEQ&deviceKey={deviceKey}&checkInId={checkInId}  全部同步

#pragma mark --------网络请求








//    Name = null;
//    accessKey = oX9XjjizWbtuCeHkJRKDwJDvPFEQ;
//    addTime = "1900-01-01 00:00:00";
//    checkInId = 11748;
//    checkInName = "\U4eba\U8138\U7b7e\U5230\U6d3b\U52a8[\U7b7e\U5230]";
//    comModContent = 1;
//    comModType = 1;
//    deviceKey = 84E0F420051400B0;
//    displayModContent = "<null>";
//    displayModType = 1;
//    endTime = "2019-04-04 00:00:00";
//    intro = "2017\U5e74\U7ec8\U603b\U7ed3\U4f1a\n13:30-14:00 \U4e0e\U4f1a\U4eba\U5458\U9646\U7eed\U5165\U5e2d \n14:00-14:15 \U4f1a\U8bae\U5f00\U5e55\U81f4\U8bcd\U5e76\U901a\U62a5\U516c\U53f8\U53d1\U5c55\U6982\U51b5  \U4e60\U5927\U5927 \n14:15-15:00 \U90e8\U95e8\U5212\U5206\U53ca\U5c97\U4f4d\U804c\U8d23   \U9648\U5927\U5927 \n15:00-17:00 \U5e73\U53f0\U5f00\U53d1\U8fdb\U5c55\U901a\U62a5\Uff08\U63d0\U95ee\U8ba8\U8bba\Uff09 \U5218\U5927\U5927 \n17:00-18:30 \U5e02\U573a\U90e8\U5de5\U4f5c\U8ba1\U5212         \U5f90\U5927\U5927 \n18:30-18:50 \U4f1a\U8bae\U603b\U7ed3\U53ca\U81f4\U8bcd          \U4e60\U5927\U5927";
//    logoUrl = "http://joinheadoss.oss-cn-hangzhou.aliyuncs.com/zhundao/20170717180513960";
//    nameType = 2;
//    previewModType = 1;
//    recDisModType = 0;
//    recScore = "\U4eba\U8138\U8bc6\U522b\U8bbe\U5907115";
//    slogan = "\U6ce8\U610f\Uff1a\U665a\U996d\U5728\U9152\U5e97\U4e00\U697c\U5bb4\U4f1a\U5385\Uff0c\U51ed\U7b7e\U5230\U65f6\U5019\U9886\U53d6\U7684\U9910\U5238\U5165\U573a";
//    startTime = "2017-04-15 00:00:00";
//    stock = 9999;
//    ttsModContent = "<null>";
//    ttsModType = 1;
//    userId = 4;



- (void)getListWithBlock :(listBlock)listBlock
{
    NSString *str = [NSString stringWithFormat:@"https://face.zhundao.net/api/Core/GetDeviceList?accessKey=%@&userId=2",[[PGSignManager shareManager] getaccseekey]];
    [ZD_NetWorkM getDataWithMethod:str parameters:nil succ:^(NSDictionary *obj) {
//        NSArray *array = [NSArray arrayWithArray:obj];
//        listBlock(array);
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}


#pragma mark 逻辑 

- (void)saveData:(NSArray *)array
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"faceArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSArray *)getData
{
    NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:@"faceArray"];
    NSArray *array = [[NSKeyedUnarchiver unarchiveObjectWithData:data]copy];
    return array;
}

@end
