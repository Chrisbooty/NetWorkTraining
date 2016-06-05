//
//  CJTool.m
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJTool.h"
#import "CJModel.h"
#import "CJFirstCellGroupModel.h"
#import "AppDelegate.h"

@interface CJTool ()

/** coredata context */
@property(nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation CJTool


+ (instancetype)sharedTool
{
    static CJTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[CJTool alloc] init];
        tool.context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    });
    return tool;
}

- (NSArray *)searchModelName:(NSString *)name
{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:name];
    return [self.context executeFetchRequest:req error:nil];
}

- (void)insertToName:(NSString *)name withModel:(id)entity
{
    NSManagedObject *data = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.context];
    if ([entity isKindOfClass:[CJModel class]]) {
        CJModel *model = (CJModel *)entity;
        [data setValue:model.title forKey:@"title"];
        [data setValue:model.discount_price forKey:@"discount_price"];
        [data setValue:model.cover forKey:@"cover"];
        [data setValue:model.avatar forKey:@"avatar"];
        [data setValue:model.route_id forKey:@"route_id"];
        [data setValue:model.collect forKey:@"collect"];
    }else
    {
        CJFirstCellGroupModel *model = (CJFirstCellGroupModel *)entity;
        [data setValue:model.name forKey:@"name"];
        [data setValue:model.guide forKey:@"guide"];
        [data setValue:model.route forKey:@"route"];
        [data setValue:model.image forKey:@"image"];
    }
    [self.context save:nil];
}

- (void)editName:(NSString *)name withRouteId:(NSNumber *)routeId withValue:(NSNumber *)value
{
    NSArray *arr = [self searchModelName:name];
    for ( CJModel *model in arr) {
        if (model.route_id == routeId) {
            model.collect = value;
        }
    }
    [self.context save:nil];
}

- (void)saveData
{
    [self.context save:nil];
}


@end
