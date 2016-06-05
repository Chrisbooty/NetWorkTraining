//
//  CJTool.h
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CJTool : NSObject

/** 单例 */
+ (instancetype)sharedTool;
/** 查询 */
- (NSArray *)searchModelName:(NSString *)name;
/** 插入*/
- (void)insertToName:(NSString *)name withModel:(id)entity;
/** 修改收藏值*/
- (void)editName:(NSString *)name withRouteId:(NSNumber *)routeId withValue:(NSNumber *)value;
/** 保存 */
- (void)saveData;
@end
