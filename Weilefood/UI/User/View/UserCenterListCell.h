//
//  UserCenterListCell.h
//  Weilefood
//
//  Created by makewei on 15/8/28.
//  Copyright (c) 2015年 kelei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UserCenterListItemType) {
    MyOrder,
    MyFavorite,
    MyComment,
    FeedBack
};

@interface UserCenterListCell : UITableViewCell

@property(nonatomic,assign)UserCenterListItemType itemType;

+ (NSString*)reuseIdentify;
@end
