//
//  CJFirstCellModel.h
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "JSONModel.h"

@interface CJModel : JSONModel

/** 标题 */
@property(nonatomic,copy)NSString *title;
/** 价格 */
@property(nonatomic,copy)NSString *discount_price;
/** 背景图片 */
@property(nonatomic,copy)NSString *cover;
/** 用户头像 */
@property(nonatomic,copy)NSString *avatar;
/** 页面id */
@property(nonatomic,strong)NSNumber *route_id;
/** 收藏 */
@property(nonatomic,strong)NSNumber<Ignore> *collect;

@end
