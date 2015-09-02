//
//  WLServerHelper+FeedBack.h
//  Weilefood
//
//  Created by makewei on 15/9/2.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import "WLServerHelper.h"

@interface WLServerHelper (FeedBack)

- (void)feedBack_addWithContent:(NSString*)content userInfo:(NSString*)userInfo callback:(void(^)(WLApiInfoModel* apiInfo, NSError *error))callback;
@end
