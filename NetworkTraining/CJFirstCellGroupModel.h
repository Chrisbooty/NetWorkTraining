//
//  CJFirstCellGroupModel.h
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "JSONModel.h"

@interface CJFirstCellGroupModel : JSONModel

/** name */
@property(nonatomic,copy)NSString *name;
/** guide */
@property(nonatomic,strong)NSNumber *guide;
/** route */
@property(nonatomic,strong)NSNumber *route;
/** 图片 */
@property(nonatomic,copy)NSString *image;

@end
